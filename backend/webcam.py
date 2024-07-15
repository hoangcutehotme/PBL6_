from datetime import datetime
from threading import Thread

from ultralytics import YOLO
import cv2
import math

from models.detection import Detection
from upload_image import create_image
from yolov8_detect_video import get_detection

def upload_and_save_detection(image_to_upload, filename):
    try:
        image_url = create_image(image_to_upload.tobytes())
        detect = Detection(
            name=filename,
            date=datetime.now().strftime("%a, %d %b %Y %H:%M:%S %Z"),
            image=image_url,
            description="",
            detections=[],
        )
        get_detection(detect)  # Upload and save detection data
        print(f"Image uploaded and detection saved successfully for: {filename}")
    except Exception as e:
        print(f"Error uploading image for {filename}: {e}")


cap = cv2.VideoCapture(0)

# Model path (replace with your weights path)
weight1 = "weights/best4.pt"
weight2 = "yolov8n.pt"

model1 = YOLO(weight1)
model2 = YOLO(weight2)

classNames1 = ['person']
classNames2 = ['Garbage_Bag', 'Glass', 'Paper_Bag', 'Pet_Bottle', 'Plastic_Bag', 'can']

start_time = datetime.now()
detection_interval = 5
has_detection = False

detect1 = []
trash_in_person_box = set([])
trash_out_person_box = set([])

assert cap.isOpened(), "Error reading video file"
w, h, fps = (int(cap.get(x)) for x in (cv2.CAP_PROP_FRAME_WIDTH, cv2.CAP_PROP_FRAME_HEIGHT, cv2.CAP_PROP_FPS))
video_writer = cv2.VideoWriter("output6.mp4", cv2.VideoWriter_fourcc(*"mp4v"), fps, (w, h))

while True:
    success, img = cap.read()
    if not success:
        continue

    # Object detection using YOLOv8
    result_person = model2.track(img, stream=True, persist=True, tracker="bytetrack.yaml", classes=[0])
    result_trash = model1.track(img, stream=True, persist=True, conf=0.2, iou=0.75, tracker="bytetrack.yaml",
                                     classes=[0, 2, 4])

    # Process detections and draw bounding boxes
    # person_box = []
    
    # check collect person
    # if result_person is not None:
    #     detect1 = []
    #     trash_in_person_box = set([])

    # Draw bounding box person
    for r in result_person:
        boxes = r.boxes
        for box in boxes:
            x1, y1, x2, y2 = box.xyxy[0].cpu()
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            detect1 = [x1, y1, x2, y2]
            print(detect1)
            # Draw bounding box and label
            cv2.rectangle(img, (x1 - 50, y1), (x2 + 50, y2), (255, 0, 0), 2)
            conf = math.ceil((box.conf[0] * 100)) / 100
            cls = int(box.cls[0])
            id = ''
            if box.id:
                id = f'id:{int(box.id)}'

            class_name = classNames1[cls]
            label = f'{id}  {class_name}{conf}'
            t_size = cv2.getTextSize(label, 0, fontScale=1, thickness=2)[0]
            c2 = x1 + t_size[0], y1 - t_size[1] - 3
            cv2.rectangle(img, (x1, y1), c2, [255, 0, 0], -1, cv2.LINE_AA)  # filled
            cv2.putText(img, label, (x1, y1 - 2), 0, 1, [255, 255, 255], thickness=1, lineType=cv2.LINE_AA)

    # Draw bounding box trash
    for r in result_trash:
        boxes = r.boxes
        for box in boxes:
            x1, y1, x2, y2 = box.xyxy[0]
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            # check the object out of the true object
            id = ''
            if box.id:
                id = int(box.id)
            # Draw bounding box and label
            cv2.rectangle(img, (x1, y1), (x2, y2), (255, 0, 255), 1)
            conf = math.ceil((box.conf[0] * 100)) / 100
            cls = int(box.cls[0])
            class_name = classNames2[cls]
            label = ''

            if id != '':
                label = f'id:{int(id)} {class_name}{conf}'
            else:
                label = f'{class_name}{conf}'

            t_size = cv2.getTextSize(label, 0, fontScale=1, thickness=2)[0]
            c2 = x1 + t_size[0], y1 - t_size[1] - 3
            cv2.rectangle(img, (x1, y1), c2, [255, 0, 255], -1, cv2.LINE_AA)  # filled
            cv2.putText(img, label, (x1, y1 - 2), 0, 1, [255, 255, 255], thickness=1, lineType=cv2.LINE_AA)

            # Detect trash
            if detect1 is not []:
                if detect1[0] > x2 or detect1[2] < x1:
                    if box.id is not None:
                        has_detection = True
                        cv2.putText(img, 'Warning', (10, 20), 0, 1, [0, 0, 255], thickness=3)
                else:
                    if box.id is not None:
                        trash_in_person_box.add(str(int(box.id)))

    print(trash_in_person_box)

    # Calculate elapsed time only once per frame
    elapsed_time = (datetime.now() - start_time).total_seconds()

    # Save image logic (if object detected)
    if has_detection:
        if elapsed_time >= detection_interval:
            # Reset timer and flag for next interval
            start_time = datetime.now()
            has_detection = False

            # Generate filename with formatted date and time
            filename = f"Detection_{start_time.strftime('%a, %d %b %Y %H:%M:%S')}"
            ret, image_to_upload = cv2.imencode(".jpg", img)

            # Create a separate thread for image upload and saving
            upload_thread = Thread(target=upload_and_save_detection, args=(image_to_upload, filename))
            upload_thread.start()

    # Display the frame
    cv2.imshow("Webcam detection", img)
    video_writer.write(img)
    # Exit on 'q' key press
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
video_writer.release()
cv2.destroyAllWindows()



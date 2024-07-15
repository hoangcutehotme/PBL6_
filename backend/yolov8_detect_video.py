from datetime import datetime
from threading import Thread
from ultralytics import YOLO
import cv2
import math
from upload_image import create_image
from config.db import client, collection
from models.detection import Detection

classNames2 = ['Garbage_Bag', 'Glass', 'Paper_Bag', 'Pet_Bottle', 'Plastic_Bag', 'can']
classNames1 = ['person']

def video_detection(path_x):
    video_capture = path_x
    has_detection = False
    detection_interval = 5
    cap = cv2.VideoCapture(0)

    model_trash = YOLO("weights/best4.pt")
    model_person = YOLO("weights/yolov8n.pt")

    # Start counting time
    start_time = datetime.now()

    detect1 = []
    trash_in_person_box = set([])

    while True:
        success, img = cap.read()
        # has_detection = False
        if not success:
            continue

        result_person = model_person.track(img, stream=True, persist=True, tracker="bytetrack.yaml", classes=[0])
        result_trash = model_trash.track(img, stream=True, persist=True, conf=0.2, iou=0.75, tracker="bytetrack.yaml", classes=[0, 2, 4])

        # result_trash = model_trash.track(img, stream=True, persist=True, conf=0.2, iou=0.75, tracker="bytetrack.yaml")

        # check collect person
        if result_person is None:
            detect1 = []
            trash_in_person_box = set([])

        for r in result_person:
            boxes = r.boxes
            for box in boxes:
                x1, y1, x2, y2 = box.xyxy[0].cpu()
                x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
                detect1 = [x1, y1, x2, y2]
                print("Person box ", detect1)
                # Draw bounding box and label
                cv2.rectangle(img, (x1 - 50, y1), (x2 + 50, y2), (255, 0, 0), 2)
                conf = math.ceil((box.conf[0] * 100)) / 100
                cls = int(box.cls[0])
                id_object = ''
                if box.id:
                    id_object = f'id:{int(box.id)}'

                class_name = classNames1[cls]
                label = f'{id_object}  {class_name}{conf}'
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
                id_object = ''
                if box.id:
                    id_object = int(box.id)
                # Draw bounding box and label
                cv2.rectangle(img, (x1, y1), (x2, y2), (255, 0, 255), 1)
                conf = math.ceil((box.conf[0] * 100)) / 100
                cls = int(box.cls[0])
                class_name = classNames2[cls]

                if id_object != '':
                    label = f'id:{int(id_object)} {class_name}{conf}'
                else:
                    label = f'{class_name}{conf}'

                t_size = cv2.getTextSize(label, 0, fontScale=1, thickness=2)[0]
                c2 = x1 + t_size[0], y1 - t_size[1] - 3
                cv2.rectangle(img, (x1, y1), c2, [255, 0, 255], -1, cv2.LINE_AA)  # filled
                cv2.putText(img, label, (x1, y1 - 2), 0, 1, [255, 255, 255], thickness=1, lineType=cv2.LINE_AA)

                # Detect check the trash is out of person
                if detect1 is not []:
                    if detect1[0] > x2 or detect1[2] < x1:
                        # if box.id is not None and trash_in_person_box.__contains__(str(box.id)):

                        if box.id is not None :
                            has_detection = True
                            cv2.putText(img, 'Warning', (10, 20), 0, 1, [0, 0, 255], thickness=3)
                    else:
                        if box.id is not None:
                            trash_in_person_box.add(str(int(box.id)))

        print(trash_in_person_box)
        print(has_detection)

        # Calculate elapsed time only once per frame
        elapsed_time = (datetime.now() - start_time).total_seconds()

        # Save image logic (if object detected after 5s)
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

        yield img


def upload_and_save_detection(image_to_upload, filename):
    try:
        image_url = create_image(image_to_upload.tobytes())
        detect = Detection(
            name=filename,
            date=datetime.now(),
            image=image_url,
            description="",
            detections=[],
        )
        get_detection(detect)  # Upload and save detection data
        print(f"Image uploaded and detection saved successfully for: {filename}")
    except Exception as e:
        print(f"Error uploading image for {filename}: {e}")


def get_detection(detection: Detection):
    try:
        collection.insert_one(dict(detection))
    except Exception as e:
        print("Error ",e)
    print("get detection success")
    # return serializeList(collection.find())

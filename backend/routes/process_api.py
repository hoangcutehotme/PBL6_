import cv2
from flask import jsonify, request, Blueprint
from ultralytics import YOLO
from PIL import Image
import io
import numpy as np

from upload_image import create_image

process_api = Blueprint('process_api', __name__)
model = YOLO("weights/best4.pt")

@process_api.route('/api/process_image', methods=['POST'])
def process_image():
    try:
        # Check if the image is in the request
        if 'files' not in request.files:
            return jsonify({"error": "Missing image data"}), 400

        image_file = request.files['files']

        # Read the image file and convert it to a format suitable for YOLO
        image = Image.open(io.BytesIO(image_file.read()))

        img = np.array(image)

        # Perform YOLO detection
        results = model(img)
        # Render results and get the annotated image

        annotated_img = results[0].plot()

        # Convert the annotated image to bytes
        _, encoded_img = cv2.imencode('.jpeg', annotated_img)
        encoded_img_bytes = encoded_img.tobytes()

        image_url = create_image(io.BytesIO(encoded_img_bytes))

        return jsonify({
            "status": "success",
            "processed_image": image_url,

        }), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

import os
from flask import Flask, request, render_template, redirect, url_for, flash
import pandas as pd
import cv2
import shutil
from ultralytics import YOLO
from werkzeug.utils import secure_filename
import numpy as np
import traceback
from zipfile import ZipFile
from flask_mysqldb import MySQL
from datetime import datetime
from PIL import Image, ImageFile



# import getpass
#
# password = getpass.getpass("Enter the password to run this program: ")
# if password != "sam":
#     print("Incorrect password! Exiting...")
#     exit()

# Rest of your program code here

app = Flask(__name__)
app.config['SECRET_KEY'] = '12345'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'cleandetection'

mysql = MySQL(app)

cwd = os.getcwd()
model = YOLO("updated_Unclean_model.pt")
classnames = ['tissue']
print("classes: ", model.names)

created_at = datetime.now()
current_year = str(created_at.year)
current_month = str(created_at.month).zfill(2)
current_day = str(created_at.day)

# Define thresholds for invalid image detection
DARK_THRESHOLD = 30  # Any pixel with a value < 30 is considered dark
PERCENTAGE_THRESHOLD = 0.5  # 50% of the image being dark means it's invalid (adjusted)
VARIANCE_THRESHOLD = 15  # Low variance means the region is mostly one color
HALF_IMAGE_THRESHOLD = 0.5  # If half the image is a single color, consider it invalid
BLUR_STD_DEV_THRESHOLD = 100  # Standard deviation threshold for detecting blur (adjusted)

# Create 'invalid' folder if it doesn't exist
ImageFile.LOAD_TRUNCATED_IMAGES = True

def insert_classification(created_at):
    try:
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO classification (created_at, status,type) VALUES (%s, %s, %s)", (created_at, 1, 'clean_unclean'))
        classification_id = cur.lastrowid
        mysql.connection.commit()
        cur.close()
        print("Inserted classification record into the database.")
        return classification_id
    except Exception as e:
        print(f"Error inserting classification into the database: {e}")
        traceback.print_exc()
        mysql.connection.rollback()
        return None

def insert_classification_details(classification_id, images):
    try:
        cur = mysql.connection.cursor()
        for image_name, classification_type in images:
            path = 'cleanDetection/' + classification_type + '/' + current_year + '/' + current_month + '/' + current_day + '/' + str(
                classification_id) + '/' + image_name

            cur.execute(
                "INSERT INTO classificationDetails (classificationId, image_name, type, created_at) VALUES (%s, %s, %s, %s)",
                (classification_id, path, classification_type, datetime.now()))
        mysql.connection.commit()
        cur.close()
        print("Inserted classification details into the database.")
    except Exception as e:
        print(f"Error inserting classification details into the database: {e}")
        traceback.print_exc()
        mysql.connection.rollback()

def has_large_uniform_area(image_array, variance_threshold, percentage_threshold):
    variances = np.var(image_array, axis=(0, 1))
    max_variance = np.max(variances)
    print(f"Max variance: {max_variance}")
    if max_variance < variance_threshold:
        return True
    return False

def is_half_image_uniform(image_array, half_image_threshold):
    height, width, _ = image_array.shape
    half_height = height // 2
    half_width = width // 2

    halves = [
        image_array[:half_height, :],  # Top half
        image_array[half_height:, :],  # Bottom half
        image_array[:, :half_width],  # Left half
        image_array[:, half_width:]  # Right half
    ]

    for half in halves:
        variances = np.var(half, axis=(0, 1))
        max_variance = np.max(variances)
        print(f"Half image max variance: {max_variance}")
        if max_variance < VARIANCE_THRESHOLD:
            return True
    return False

def histogram_analysis(image):
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    hist = cv2.calcHist([gray_image], [0], None, [256], [0, 256])
    return hist.flatten()

def is_blur(hist):
    std_dev = np.std(hist)
    print(f"Histogram standard deviation: {std_dev}")
    return std_dev < BLUR_STD_DEV_THRESHOLD

def classify_images(temp_dir):
    clean_images = []
    unclean_images = []
    invalid_images = []

    classification_id = insert_classification(created_at)
    if classification_id is None:
        print("Error: Classification ID is None")
        return None

    base_clean_dir = os.path.join(cwd, "clean", current_year, current_month, current_day, str(classification_id))
    base_unclean_dir = os.path.join(cwd, "unclean", current_year, current_month, current_day, str(classification_id))
    base_invalid_dir = os.path.join(cwd, "invalid", current_year, current_month, current_day, str(classification_id))

    for folder in [base_clean_dir, base_unclean_dir, base_invalid_dir]:
        if not os.path.exists(folder):
            os.makedirs(folder)

    for file in os.listdir(temp_dir):
        base_file = os.path.join(temp_dir, file)
        print(f"Processing file: {base_file}")
        if os.path.isdir(base_file):
            continue
        file_size = os.path.getsize(base_file)
        print(f"File size: {file_size}")
        if file_size >= 6000:
            img = cv2.imread(base_file)
            
            image_pil = Image.open(base_file)
            gray_image = image_pil.convert('L')
            image_array = np.array(gray_image)
            dark_pixels = np.sum(image_array < DARK_THRESHOLD)
            total_pixels = image_array.size
            dark_pixel_percentage = dark_pixels / total_pixels
            color_image_array = np.array(image_pil)
            print(f"Dark pixel percentage: {dark_pixel_percentage}")

            if (dark_pixel_percentage > PERCENTAGE_THRESHOLD or
                    has_large_uniform_area(color_image_array, VARIANCE_THRESHOLD, PERCENTAGE_THRESHOLD) or
                    is_half_image_uniform(color_image_array, HALF_IMAGE_THRESHOLD)):
                invalid_dest_file = os.path.join(base_invalid_dir, file)
                shutil.move(base_file, invalid_dest_file)
                invalid_images.append((file, "invalid"))
                print(f"Moved to Invalid: {invalid_dest_file}")
                continue

            hist = histogram_analysis(img)
            if is_blur(hist):
                invalid_dest_file = os.path.join(base_invalid_dir, file)
                shutil.move(base_file, invalid_dest_file)
                invalid_images.append((file, "invalid"))
                print(f"Moved to Invalid (Blur): {invalid_dest_file}")
                continue

            result = model.predict(img)
            tissue_c = 0
            for r in result:
                boxes = r.boxes
                for box in boxes:
                    x1, y1, x2, y2 = box.xyxy[0]
                    x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
                    conf = int(box.conf[0] * 100)
                    cls = int(box.cls[0])
                    if (classnames[cls] == "tissue") and conf >= 30:
                        tissue_c += 1

            if tissue_c >= 3:
                unclean_dest_file = os.path.join(base_unclean_dir, file)
                shutil.move(base_file, unclean_dest_file)
                unclean_images.append((file, "unclean"))
                print(f"Moved to Unclean (Tissue): {unclean_dest_file}")
            else:
                clean_dest_file = os.path.join(base_clean_dir, file)
                shutil.move(base_file, clean_dest_file)
                clean_images.append((file, "clean"))
                print(f"Moved to Clean (Tissue): {clean_dest_file}")
        else:
            invalid_dest_file = os.path.join(base_invalid_dir, file)
            shutil.move(base_file, invalid_dest_file)
            invalid_images.append((file, "invalid"))
            print(f"Moved to Invalid: {invalid_dest_file}")

    shutil.rmtree(temp_dir)

    insert_classification_details(classification_id, clean_images + unclean_images + invalid_images)

    # ----- recently added---------

    df = pd.DataFrame(clean_images + unclean_images + invalid_images, columns=["Image Name", "Classification"])
    excel_file = "./classification_result.xlsx"
    df.to_excel(excel_file, index=False)
    print(f"Classification results saved to {excel_file}")

    return classification_id

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['GET', 'POST'])
def upload():
    if not os.path.exists(f"{cwd}\\temp\\"):
        os.makedirs(f"{cwd}\\temp\\")

    temp_dir = f"{cwd}\\temp\\"

    zip_file = request.files['zipFile']
    if zip_file and zip_file.filename.endswith('.zip'):
        zip_filepath = os.path.join(temp_dir, secure_filename(zip_file.filename))
        zip_file.save(zip_filepath)

        with ZipFile(zip_filepath, 'r') as zip_ref:
            zip_ref.extractall(temp_dir)
        os.remove(zip_filepath)

        
        extracted_folder = os.path.join(temp_dir, os.path.splitext(zip_file.filename)[0])
        for root, directories, files in os.walk(extracted_folder):
            for filename in files:
                if filename.endswith((".jpg", ".png")):
                    shutil.move(os.path.join(root, filename), temp_dir)

    for uploaded_file in request.files.getlist('file'):
        if uploaded_file.filename != '':
            uploaded_file.save(temp_dir + uploaded_file.filename)

    classification_id = classify_images(temp_dir)
    if classification_id:
        flash(f"{classification_id}") 
    else:
        flash("Classification failed.")

    return render_template('index.html')

if __name__ == '__main__':
    app.run(port=9000, debug=True)
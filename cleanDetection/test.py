import os
from flask import Flask, request, render_template, redirect, url_for, flash
import pandas as pd
import cv2
import shutil
from ultralytics import YOLO
from werkzeug.utils import secure_filename
import numpy as np
import traceback
import tempfile
from zipfile import ZipFile
from flask_mysqldb import MySQL
import datetime

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'cleandetection'

mysql = MySQL(app)

cwd = os.getcwd()
model = YOLO("cleanDetection/best_grey.pt")
classnames = ['grey_img', 'tissue']
print("classes: ", model.names)

sample_path = 'D:\\'

def classify_images(temp_dir):
    clean_folder = os.path.join(".", "clean")
    unclean_folder = os.path.join(".", "unclean")
    invalid_folder = os.path.join(".", "invalid")

    # Ensure clean, unclean, and invalid folders exist, create them if not
    for folder in [clean_folder, unclean_folder, invalid_folder]:
        if not os.path.exists(folder):
            os.makedirs(folder)

    clean_images = []
    unclean_images = []
    invalid_images = []

    # For each file in the temporary directory
    for file in os.listdir(temp_dir):
        base_file = os.path.join(temp_dir, file)
        if os.path.isdir(base_file):
            continue
        invalid_dest_file = os.path.join(invalid_folder, file)
        unclean_dest_file = os.path.join(unclean_folder, file)
        clean_dest_file = os.path.join(clean_folder, file)
        file_size = os.path.getsize(base_file)
        print(f"{file} = {file_size}")
        if file_size >= 6000:
            print(f"valid image: {file}")
            img = cv2.imread(base_file)
            result = model.predict(img)
            tissue_c = 0
            for r in result:
                boxes = r.boxes
                for box in boxes:
                    x1, y1, x2, y2 = box.xyxy[0]
                    x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
                    conf = int(box.conf[0] * 100)
                    cls = int(box.cls[0])
                    if (classnames[cls] == "tissue") and conf >= 35:
                        tissue_c += 1

            if tissue_c >= 3:
                shutil.move(base_file, unclean_dest_file)
                unclean_images.append((file, "unclean"))
                print(f"Moved to Unclean (Tissue): {unclean_dest_file}")
            else:
                shutil.move(base_file, clean_dest_file)
                clean_images.append((file, "clean"))
                print(f"Moved to Clean (Tissue): {clean_dest_file}")
        else:
            print(f"invalid image: {file}")
            shutil.move(base_file, invalid_dest_file)
            invalid_images.append((file, "invalid"))
            print(f"Moved to Invalid (Tissue): {invalid_dest_file}")

    shutil.rmtree(temp_dir)

    # Combine all results into a DataFrame
    df = pd.DataFrame(clean_images + unclean_images + invalid_images, columns=["Image Name", "Classification"])

    # Insert classification results into the database
    insert_classification_results(clean_images, unclean_images, invalid_images)

    # Save DataFrame to Excel
    excel_file = "./classification_result.xlsx"
    df.to_excel(excel_file, index=False)
    print(f"Classification results saved to {excel_file}")
    return 'Images classified successfully.'

def insert_classification_results(clean_images, unclean_images, invalid_images):
    try:
        cur = mysql.connection.cursor()

        # Insert into classification table
        created_at = datetime.datetime.now()
        cur.execute("INSERT INTO classification (created_at, status) VALUES (%s, %s)", (created_at, 1))
        classification_id = cur.lastrowid

        # Insert into classificationDetails table
        for image_name, classification_type in clean_images + unclean_images + invalid_images:
            cur.execute("INSERT INTO classificationDetails (classificationId, image_name, type, created_at) VALUES (%s, %s, %s, %s)", 
                        (classification_id, image_name, classification_type, created_at))

        mysql.connection.commit()
        cur.close()
        print("Inserted classification results into the database.")
    except Exception as e:
        print(f"Error inserting into the database: {e}")
        traceback.print_exc()
        mysql.connection.rollback()

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

    classify_images(temp_dir)
    flash("Done Classification")

    return render_template('index.html')

if __name__ == '__main__':
    app.run(port=9000, debug=True)

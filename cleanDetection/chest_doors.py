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

app = Flask(__name__)
app.config['SECRET_KEY'] = '12345'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'cleandetection'

mysql = MySQL(app)

cwd = os.getcwd()
model = YOLO("chest_door_updated.pt")
classnames = ['chest_door', 'chestdoor_close']
print("classes: ", model.names)

created_at = datetime.now()
current_year = str(created_at.year)
current_month = str(created_at.month).zfill(2)
current_day = str(created_at.day)


def insert_classification(created_at):
    try:
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO classification (created_at, status,type) VALUES (%s, %s, %s)", (created_at, 1,'chestdoor'))
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


# def insert_classification_details(classification_id, images):
#     try:
#         cur = mysql.connection.cursor()
#         for image_name, classification_type in images:
#             path = 'cleanDetection/' + classification_type + '/' + current_year + '/' + current_month + '/' + current_day + '/' + str(classification_id) + '/' + image_name
            
#             # Print the values being inserted
#             print(f"Inserting: classificationId={classification_id}, image_name={path}, type={classification_type}, created_at={datetime.now()}")

#             cur.execute(
#                 "INSERT INTO classificationDetails (classificationId, image_name, type, created_at) VALUES (%s, %s, %s, %s)",
#                 (classification_id, path, classification_type, datetime.now()))
#         mysql.connection.commit()
#         cur.close()
#         print("Inserted classification details into the database.")
#     except Exception as e:
#         print(f"Error inserting classification details into the database: {e}")
#         traceback.print_exc()
#         mysql.connection.rollback()

def insert_classification_details(classification_id, images):
    try:    
        # print(images)
        # print(f"{}")
        # print(f"INSERT INTO classificationDetails (classificationId, image_name, type, created_at) VALUES ({classification_id}, {path}, {classification_type}, {datetime.now()})")
       
        cur = mysql.connection.cursor()

        for image_name, classification_type in images:
            path = 'cleanDetection/' + classification_type + '/' + current_year + '/' + current_month + '/' + current_day + '/' + str(
                classification_id) + '/' + image_name
            # cur.execute(f"INSERT INTO classificationDetails (classificationId, image_name, type, created_at) VALUES ('{classification_id}', '{path}', '{classification_type}', '{datetime.now()}')")
            q = f'INSERT INTO classificationDetails (classificationId, image_name, type, created_at) VALUES (%s, %s, %s, %s)'
            val =  (classification_id, path, classification_type, datetime.now())
            cur.execute(q,val)

            # cur.execute(
            #     "INSERT INTO classificationDetails (classificationId, image_name, type, created_at) VALUES (%s, %s, %s, %s)",
            #     (classification_id, path, classification_type, datetime.now()))
            mysql.connection.commit()
        cur.close()
        print("Inserted classification details into the database.")
    except Exception as e:
        print(f"Error inserting classification details into the database: {e}")
        traceback.print_exc()
        mysql.connection.rollback()


def classify_images(temp_dir):
    chest_doors_images = []
    suspect_images = []

    classification_id = insert_classification(created_at)
    if classification_id is None:
         print("Error: Classification ID is None")
         return None


    base_chestdoor_dir = os.path.join(cwd, "chest_door_open", current_year, current_month, current_day, str(classification_id))
    base_chestdoor_suspect_dir = os.path.join(cwd, "chest_door_suspect", current_year, current_month, current_day, str(classification_id))

# Ensure chest_doors and suspect folders exist, create them if not
    for folder in [base_chestdoor_dir, base_chestdoor_suspect_dir]:
        if not os.path.exists(folder):
            os.makedirs(folder)



    for file in os.listdir(temp_dir):
        base_file = os.path.join(temp_dir, file)
        print(f"Processing file: {base_file}")  # Debug print

        if base_file.lower().endswith((".jpg", ".jpeg", ".png")):
            # try:
            print(base_file)
            img = cv2.imread(base_file)
            if img is not None:
                result = model.predict(img)
                chest_door = 0

                for r in result:
                    boxes = r.boxes
                    for box in boxes:
                        x1, y1, x2, y2 = map(int, box.xyxy[0])
                        conf = int(box.conf[0] * 100)
                        cls = int(box.cls[0])
                        if (classnames[cls] == "chest_door" and conf >= 30):
                        # if (classnames[cls] == "chest_door" and conf >= 30) or (
                        #         classnames[cls] == "chestdoor_close" and conf >= 30):
                            # cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)
                            # cv2.putText(img, f"{classnames[cls]} - {conf}%", (x1, y1 + 2), cv2.FONT_HERSHEY_SIMPLEX,
                            #             0.6, (255, 255, 255), 2)
                            chest_door += 1

            # while True:
            #     cv2.imshow("frame", img)
            #     if cv2.waitKey(0) == ord('z'):
            #         break

                if chest_door >= 1:
                    door_dest_file = os.path.join(base_chestdoor_dir, file)
                    shutil.move(base_file, door_dest_file)
                    chest_doors_images.append((file, "chest_door"))
                    print(f"Moved to chest doors (chest_door): {door_dest_file}")
                else:
                    suspect_dest_file = os.path.join(base_chestdoor_suspect_dir, file)
                    shutil.move(base_file, suspect_dest_file)
                    suspect_images.append((file, "suspect"))
                    print(f"Moved to suspect (suspect): {suspect_dest_file}")

            else:
                print(f"Failed to read the image file: {base_file}")
            # except Exception as e:
            #     print(f"Error processing file {base_file}: {str(e)}")
        else:
            print(f"Ignoring non-image file: {base_file}")

    shutil.rmtree(temp_dir)

    insert_classification_details(classification_id, chest_doors_images + suspect_images)

    return classification_id



@app.route('/')
def index():
    return render_template('indexc.html')


@app.route('/upload', methods=['GET', 'POST'])
def upload():
    temp_dir = os.path.join(cwd, "temp")
    if not os.path.exists(temp_dir):
        os.makedirs(temp_dir)

    zip_file = request.files['zipFile']
    if zip_file and zip_file.filename.endswith('.zip'):
        zip_filepath = os.path.join(temp_dir, secure_filename(zip_file.filename))
        zip_file.save(zip_filepath)

        with ZipFile(zip_filepath, 'r') as zip_ref:
            zip_ref.extractall(temp_dir)
        os.remove(zip_filepath)

        # Move images from nested directories to temp_dir
        for root, directories, files in os.walk(temp_dir):
            for filename in files:
                if filename.lower().endswith((".jpg", ".jpeg", ".png")):
                    file_path = os.path.join(root, filename)
                    shutil.move(file_path, temp_dir)

    for uploaded_file in request.files.getlist('file'):
        if uploaded_file.filename != '':
            uploaded_file.save(os.path.join(temp_dir, uploaded_file.filename))
    
    
    classification_id = classify_images(temp_dir)
    if classification_id:
        flash(f"{classification_id}")
    else:
        flash("Classification failed.")
    return render_template('indexc.html')


if __name__ == '__main__':
    app.run(port=9001, debug=True)


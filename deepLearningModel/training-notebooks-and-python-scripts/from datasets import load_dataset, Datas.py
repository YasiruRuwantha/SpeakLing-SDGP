import os
import csv

# path to the directory containing all the folders
root_dir = r"E:/wav2vec2 datasets/data"

# list to store data rows
data_rows = []

for subdir, dirs, files in os.walk(root_dir):
    for file in files:
        if file.endswith(".wav"):
            # get the transcription from the corresponding txt file
            txt_file = os.path.splitext(file)[0] + ".txt"
            with open(os.path.join(subdir, txt_file), encoding="utf-8") as f:
                transcription = f.read().strip()

            # get the relative path to the wav file
            wav_path = os.path.join(subdir, file)
            rel_wav_path = os.path.join("data", os.path.relpath(wav_path, root_dir)).replace("\\", "/")

            # append the data row
            data_rows.append({"file": rel_wav_path, "text": transcription})

            # write the row to a CSV file in the same directory as the wav file
            csv_file = os.path.join(subdir, os.path.splitext(file)[0] + ".csv")
            with open(csv_file, mode="w", newline='') as f:
                writer = csv.writer(f)
                writer.writerow(["file", "text"])
                writer.writerow([rel_wav_path, transcription])
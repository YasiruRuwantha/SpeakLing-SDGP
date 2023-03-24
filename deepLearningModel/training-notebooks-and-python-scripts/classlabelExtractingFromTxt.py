import os
import csv
csv.field_size_limit(100000000)

root_dir = "E:/wav2vec2 datasets/data" # change this to the directory where your CSV files are located

for subdir, dirs, files in os.walk(root_dir):
    for file in files:
        if file.endswith(".csv"):
            with open(os.path.join(subdir, file), mode="r", encoding="utf-8") as f:
                reader = csv.DictReader(f)
                data_rows = []
                for row in reader:
                    # replace backslashes with forward slashes in the "file" column
                    row["file"] = row["file"].replace("\\", "/")
                    data_rows.append(row)
            
            with open(os.path.join(subdir, file), mode="w", newline="", encoding="utf-8") as f:
                writer = csv.DictWriter(f, fieldnames=["file", "text" , "audio"])
                writer.writeheader()
                writer.writerows(data_rows)
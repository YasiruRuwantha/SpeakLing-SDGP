import csv

# Open the original CSV file for reading
with open('C:/Users/Yasiru/Downloads/wav2vec2 datasets/metadata.csv', 'r') as csv_file:
    reader = csv.reader(csv_file)
    # Open the new CSV file for writing
    with open('new_metadata.csv', 'w', newline='') as new_csv_file:
        writer = csv.writer(new_csv_file)
        # Iterate through each row in the original CSV file
        for row in reader:
            # Modify the file path column
            row[0] = row[0].replace('\\', '/')
            # Write the modified row to the new CSV file
            writer.writerow(row)
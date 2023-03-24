import os
import shutil
import random

output_dir = "C:/Users/Yasiru/Downloads/wav2vec2 datasets/output"
train_ratio = 0.8
dev_ratio = 0.1
test_ratio = 0.1
output_arranged_dir = "C:/Users/Yasiru/Downloads/wav2vec2 datasets/arranged output"

# Create train/dev/test directories
train_dir = os.path.join(output_arranged_dir, "train")
dev_dir = os.path.join(output_arranged_dir, "dev")
test_dir = os.path.join(output_arranged_dir, "test")
os.makedirs(train_dir, exist_ok=True)
os.makedirs(dev_dir, exist_ok=True)
os.makedirs(test_dir, exist_ok=True)

for folder_name in os.listdir(output_dir):
    folder_path = os.path.join(output_dir, folder_name)
    if not os.path.isdir(folder_path):
        continue

    audio_files = []
    transcript_files = []
    for file_name in os.listdir(folder_path):
        if file_name.endswith(".wav"):
            audio_files.append(file_name)
        elif file_name.endswith(".txt"):
            transcript_files.append(file_name)

    # Randomly shuffle audio files and split into train/dev/test
    random.shuffle(audio_files)
    num_audio_files = len(audio_files)
    num_train_files = int(num_audio_files * train_ratio)
    num_dev_files = int(num_audio_files * dev_ratio)
    train_audio_files = audio_files[:num_train_files]
    dev_audio_files = audio_files[num_train_files:num_train_files + num_dev_files]
    test_audio_files = audio_files[num_train_files + num_dev_files:]

    # Create train/dev/test directories for this folder
    train_folder_dir = os.path.join(train_dir, folder_name)
    dev_folder_dir = os.path.join(dev_dir, folder_name)
    test_folder_dir = os.path.join(test_dir, folder_name)
    os.makedirs(os.path.join(train_folder_dir, "audio"), exist_ok=True)
    os.makedirs(os.path.join(dev_folder_dir, "audio"), exist_ok=True)
    os.makedirs(os.path.join(test_folder_dir, "audio"), exist_ok=True)
    os.makedirs(os.path.join(train_folder_dir, "transcripts"), exist_ok=True)
    os.makedirs(os.path.join(dev_folder_dir, "transcripts"), exist_ok=True)
    os.makedirs(os.path.join(test_folder_dir, "transcripts"), exist_ok=True)

    # Move audio files to train/dev/test directories
    for audio_file in train_audio_files:
        src_path = os.path.join(folder_path, audio_file)
        dst_path = os.path.join(train_folder_dir, "audio", audio_file)
        shutil.move(src_path, dst_path)

    for audio_file in dev_audio_files:
        src_path = os.path.join(folder_path, audio_file)
        dst_path = os.path.join(dev_folder_dir, "audio", audio_file)
        shutil.move(src_path, dst_path)

    for audio_file in test_audio_files:
        src_path = os.path.join(folder_path, audio_file)
        dst_path = os.path.join(test_folder_dir, "audio", audio_file)
        shutil.move(src_path, dst_path)

    # Move transcript files to train/dev/test directories
    for transcript_file in transcript_files:
        src_path = os.path.join(folder_path, transcript_file)
        if transcript_file[:-4] in train_audio_files:
            dst_dir = os.path.join(train_folder_dir, "transcripts")
        elif transcript_file[:-4] in dev_audio_files:
            dst_dir = os.path.join(dev_folder_dir, "transcripts")
        else:
            dst_dir = os.path.join(test_folder_dir, "transcripts")

        dst_path = os.path.join(dst_dir, transcript_file)
        os.makedirs(os.path.dirname(dst_path), exist_ok=True)
        shutil.move(src_path, dst_path)

        print("done")
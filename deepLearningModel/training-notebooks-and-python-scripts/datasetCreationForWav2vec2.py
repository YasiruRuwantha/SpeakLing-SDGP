import os
import soundfile as sf
import re
import shutil

# Define paths to input audio and SRT files
input_dir = r"C:/Users/Yasiru/Downloads/wav2vec2 datasets/input"
audio_ext = ".wav"
srt_ext = ".srt"

# Define output directory for segmented WAV files
output_dir = r"C:/Users/Yasiru/Downloads/wav2vec2 datasets/output"

# Define maximum duration (in seconds) for each segmented WAV file
max_duration = 10

# Define train/dev/test split ratios
train_ratio = 0.8
dev_ratio = 0.1
test_ratio = 0.1

# Define paths to train/dev/test directories
train_dir = os.path.join(output_dir, "train")
dev_dir = os.path.join(output_dir, "dev")
test_dir = os.path.join(output_dir, "test")

# Create train/dev/test directories if they don't exist
for dir_path in [train_dir, dev_dir, test_dir]:
    if not os.path.exists(dir_path):
        os.makedirs(dir_path)
    os.makedirs(os.path.join(dir_path, "audio"))
    os.makedirs(os.path.join(dir_path, "text"))

# Process each audio file in input directory
transcripts = []
utterance_count = 1
for audio_filename in os.listdir(input_dir):
    # Check if file is a WAV file
    if not audio_filename.endswith(audio_ext):
        continue

    # Define corresponding SRT file name
    srt_filename = audio_filename.replace(audio_ext, srt_ext)
    srt_path = os.path.join(input_dir, srt_filename)

    # Read SRT file
    with open(srt_path, "r", encoding="utf-8") as f:
        srt_lines = f.readlines()

    # Define path to audio file
    audio_path = os.path.join(input_dir, audio_filename)

    # Load audio file
    audio, sample_rate = sf.read(audio_path)

    # Process each line in SRT file
    for i in range(0, len(srt_lines), 4):
        # Parse start and end times
        start_time, end_time = srt_lines[i+1].strip().split(" --> ")
        time_pattern = re.compile(r"(\d{2}):(\d{2}):(\d{2}).(\d{2})")
        match = time_pattern.match(start_time)
        if match:
            hours = int(match.group(1))
            minutes = int(match.group(2))
            seconds = int(match.group(3))
            milliseconds = int(match.group(4))
            start_time_in_seconds = hours * 3600 + minutes * 60 + seconds + milliseconds / 1000

        match = time_pattern.match(end_time)
        if match:
            hours = int(match.group(1))
            minutes = int(match.group(2))
            seconds = int(match.group(3))
            milliseconds = int(match.group(4))
            end_time_in_seconds = hours * 3600 + minutes * 60 + seconds + milliseconds / 1000

        # Calculate start and end frames
        start_frame = int(start_time_in_seconds * sample_rate)
        end_frame = int(end_time_in_seconds * sample_rate)

        # Split audio file into segments
        for j in range(start_frame, end_frame, max_duration * sample_rate):
            # Generate folder path for segmented WAV file and transcript
            folder_name = f"{audio_filename[:-4]}_{utterance_count}"
            folder_path = os.path.join(output_dir, folder_name)

            # Create folder if it doesn't exist
            if not os.path.exists(folder_path):
                os.makedirs(folder_path)

            # Generate filename for segmented WAV file
            wav_filename = f"{folder_name}.wav"
            wav_path = os.path.join(folder_path, wav_filename)

            # Extract audio segment
            segment = audio[j:min(j + max_duration * sample_rate, end_frame)]

            # Write audio segment to segmented WAV file
            sf.write(wav_path, segment, sample_rate)

            # Generate transcript and remove special characters
            transcript = srt_lines[i+2].strip().lower()
            transcript = re.sub(r"[^a-zA-Z0-9\s]+", "", transcript)

            # Write transcript to text file
            txt_filename = f"{folder_name}.txt"
            txt_path = os.path.join(folder_path, txt_filename)
            with open(txt_path, "w", encoding="utf-8") as f:
                f.write(transcript)

            transcripts.append(transcript)

            utterance_count += 1

# Write vocabulary file
vocab = list(set(" ".join(transcripts).split()))
vocab_path = os.path.join(output_dir, "vocab.txt")
with open(vocab_path, "w", encoding="utf-8") as f:
    f.write("\n".join(vocab))

    

print("Done")
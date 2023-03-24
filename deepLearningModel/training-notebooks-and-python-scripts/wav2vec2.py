import os

# Define paths to SRT and WAV files
srt_file_path = r"C:\Users\Yasiru\Downloads\datasets\030926.srt"
wav_file_path = r"C:\Users\Yasiru\Downloads\datasets\030926.wav"

# Define output directory for segmented WAV files
output_dir = r"C:\Users\Yasiru\Downloads\wav2vec2out"

# Define the duration (in seconds) for each segment
segment_duration = 5

# Read SRT file
with open(srt_file_path, "r", encoding="utf-8") as srt_file:
    srt_lines = srt_file.readlines()

# Process each line in SRT file
utterance_count = 1
wav_filenames = []
transcripts = []
for i in range(0, len(srt_lines), 4):
    # Parse start and end times
    start_time, end_time = srt_lines[i+1].strip().split(" --> ")
    start_time_parts = start_time.split(":")
    hours = int(start_time_parts[0])
    minutes = int(start_time_parts[1])
    seconds = float(start_time_parts[2].replace(",", "."))
    start_time_in_seconds = hours * 3600 + minutes * 60 + seconds

    end_time_parts = end_time.split(":")
    hours = int(end_time_parts[0])
    minutes = int(end_time_parts[1])
    seconds = float(end_time_parts[2].replace(",", "."))
    end_time_in_seconds = hours * 3600 + minutes * 60 + seconds

    # Parse transcript
    transcript = srt_lines[i+2].strip().rstrip('.')

    # Split WAV file into segments using ffmpeg
    segment_start_time = start_time_in_seconds
    while segment_start_time < end_time_in_seconds:
        segment_end_time = min(segment_start_time + segment_duration, end_time_in_seconds)

        # Generate filename for segmented WAV file
        wav_filename = f"{utterance_count:05d}"
        wav_path = os.path.join(output_dir, f"{wav_filename}.wav")

        # Split WAV file using ffmpeg
        os.system(f"ffmpeg -i {wav_file_path} -ss {segment_start_time:.3f} -to {segment_end_time:.3f} -ar 16k -ac 1 {wav_path}")

        # Append filename and transcript to lists
        wav_filenames.append(wav_filename)
        transcripts.append(transcript)

        utterance_count += 1
        segment_start_time = segment_end_time

# Write filenames to train_manifest.txt file
manifest_path = os.path.join(output_dir, "train_manifest.txt")
with open(manifest_path, "w", encoding="utf-8") as manifest_file:
    for i in range(len(wav_filenames)):
        manifest_file.write(f"{os.path.abspath(os.path.join(output_dir, wav_filenames[i] + '.wav'))}\t{transcripts[i]}\n")

print("Done.")
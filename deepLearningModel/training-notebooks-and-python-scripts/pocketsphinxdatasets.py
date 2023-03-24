import os
import re

# Define paths to WAV and SRT directories
wav_dir_path = r"E:\pocketsphinx\input"
srt_dir_path = r"E:\wav2vec2 datasets\input"

# Define output directory for segmented WAV files
output_dir = r"E:\pocketsphinx\output"

# Read SRT files and process each file
utterance_count = 1
wav_filenames = []
transcripts = []
for srt_filename in os.listdir(srt_dir_path):
    if srt_filename.endswith(".srt"):
        # Get corresponding WAV filename
        wav_filename = srt_filename.replace(".srt", ".wav")
        wav_path = os.path.join(wav_dir_path, wav_filename)

        # Read SRT file
        srt_path = os.path.join(srt_dir_path, srt_filename)
        with open(srt_path, "r", encoding="utf-8") as srt_file:
            srt_lines = srt_file.readlines()

        # Process each line in SRT file
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
            transcript = srt_lines[i+2].strip()

            # Generate filename for segmented WAV file
            wav_segment_filename = f"{utterance_count}_{wav_filename[:-4]}"
            wav_segment_path = os.path.join(output_dir, f"{wav_segment_filename}.wav")

            # Split WAV file using sox
            os.system(f"sox {wav_path} {wav_segment_path} trim {start_time_in_seconds} ={end_time_in_seconds}")

            # Append filename and transcript to lists
            wav_filenames.append(wav_segment_filename)
            transcripts.append(transcript)

            utterance_count += 1

# Write filenames to utterance.fields file
fields_path = os.path.join(output_dir, "adaptation.fields")
with open(fields_path, "w", encoding="utf-8") as fields_file:
    fields_file.write("\n".join(wav_filenames))

# Write transcripts to utterance.transcription file
transcription_path = os.path.join(output_dir, "adaptation.transcription")
with open(transcription_path, "w", encoding="utf-8") as transcription_file:
    for i in range(len(wav_filenames)):
        # Remove unwanted characters from transcript
        transcript = transcripts[i].replace(".", "").replace(",", "").replace("?", "").replace("!", "")

        # Write transcript to file
        transcription_file.write(f"<s> {transcript} </s> ({wav_filenames[i]}.wav)\n")

print("Done.")
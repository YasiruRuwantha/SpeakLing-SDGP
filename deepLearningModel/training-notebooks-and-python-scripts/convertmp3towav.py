import os
from pydub import AudioSegment

# Define paths to MP3 files
mp3_dir = "C:/Users/Yasiru/Downloads/wav2vec2 datasets"
wav_dir = "C:/Users/Yasiru/Downloads/wav2vec2 datasets/wav"


# Create output directory if it doesn't exist
os.makedirs(wav_dir, exist_ok=True)

# Set audio parameters
sample_rate = 16000
channels = 1

# Process each MP3 file
for filename in os.listdir(mp3_dir):
    if filename.endswith(".mp3"):
        # Load MP3 file
        mp3_path = os.path.join(mp3_dir, filename)
        sound = AudioSegment.from_mp3(mp3_path)

        # Set channels and sample rate
        sound = sound.set_channels(channels)
        sound = sound.set_frame_rate(sample_rate)

        # Generate filename for WAV file
        basename = os.path.splitext(filename)[0]
        wav_filename = f"{basename}.wav"
        wav_path = os.path.join(wav_dir, wav_filename)

        # Export as WAV file
        sound.export(wav_path, format="wav")


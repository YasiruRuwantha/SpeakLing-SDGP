import os
from pocketsphinx import AudioFile, get_model_path

model_path = "C:/Users/Yasiru/Downloads/adaptex/en-us-adapt"
lm_path = "C:/Users/Yasiru/Downloads/adaptex/en.lm"
dict_path = "C:/Users/Yasiru/Downloads/adaptex/cmudict-en-us.dict"
audio_path = "C:/Users/Yasiru/Downloads/adaptex/22.wav"

# Set up pocketsphinx configuration object
config = {
    "hmm": model_path,
    "lm": lm_path,
    "dict": dict_path
}

# Set up AudioFile object with configuration
audio = AudioFile(**config)

# Transcribe audio file
audio.decode(audio_path)
for phrase in audio:
    print(phrase)
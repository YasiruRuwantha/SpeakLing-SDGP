import os
from pocketsphinx import AudioFile, get_model_path, get_data_path

# Define paths
model_path = 'C:/sphinx/pocketsphinx/model/model/en-us'
data_path = 'C:/sphinx/pocketsphinx/test/data'
audio_file = 'C:/sphinx/other/wav/1.wav'
transcription_file = 'C:/sphinx/other/etc/utterance.transcription'

# Set up configuration
config = {
    'verbose': False,
    'audio_file': audio_file,
    'buffer_size': 2048,
    'no_search': False,
    'full_utt': False,
    'hmm': os.path.join(model_path, 'en-us'),
    'lm': os.path.join(model_path, 'en-us.lm.bin'),
    'dict': os.path.join(model_path, 'cmudict-en-us.dict'),
    'kws': '',
    'logfn': os.devnull,
    'samprate': 16000,
    'maxhmmpf': -1,
    'maxwpf': -1,
    'pl_window': 0,
    'dsratio': 1,
    'bestpath': False,
    'maxhmmpf': 3000
}

# Perform speech recognition
with AudioFile(**config) as audio_file:
    for phrase in audio_file:
        print(phrase.segments(detailed=True))
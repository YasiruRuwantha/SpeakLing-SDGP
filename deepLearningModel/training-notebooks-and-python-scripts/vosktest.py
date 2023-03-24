import os
import wave
import json
import vosk

# Set up Vosk model and recognizer
model_path = "C:/Users/Yasiru/Downloads/python scripts for prepare datasets/vosk-model-small-en-us-0.15/vosk-model-small-en-us-0.15"
sample_rate = 16000
vosk_model = vosk.Model(model_path)
vosk_recognizer = vosk.KaldiRecognizer(vosk_model, sample_rate)

# Open audio file
audio_path = "C:/Users/Yasiru/Downloads/adaptex/59.wav"
audio_file = wave.open(audio_path, "rb")

# Transcribe audio file
results = []
while True:
    # Read audio data in chunks
    data = audio_file.readframes(4000)
    if len(data) == 0:
        break
    
    # Feed audio data to Vosk recognizer
    vosk_recognizer.AcceptWaveform(data)
    
    # Get transcription result
    result = json.loads(vosk_recognizer.Result())
    text = result["text"]
    
    # Append transcription to results list
    results.append(text)

# Print final transcription
transcription = " ".join(results)
print(transcription)
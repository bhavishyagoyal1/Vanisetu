import wave
from piper import PiperVoice
from pathlib import Path

MODEL = Path("model/sat_piper_model.onnx")
OUTPUT = Path("output/santali.wav")

voice = PiperVoice.load(MODEL)

text = input("Enter Santali text: ").strip()

print("Generating...")
with wave.open(str(OUTPUT), "wb") as wav_file:
    voice.synthesize_wav(text, wav_file)

with wave.open(str(OUTPUT), "rb") as f:
    frames = f.getnframes()
    rate = f.getframerate()
    duration = frames / rate

print("Audio saved:", OUTPUT)
print("Sample rate:", rate)
print("Duration:", round(duration, 2), "seconds")
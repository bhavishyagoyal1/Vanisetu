from pathlib import Path
import wave
from piper import PiperVoice

MODEL = Path("model/hi_IN-pratham-medium.onnx")
OUTPUT = Path("output/hindi.wav")

voice = PiperVoice.load(MODEL)

text = input("Enter Hindi text: ").strip()

if not text:
    print("Please enter some Hindi text.")
    exit()

print("Generating speech...")

with wave.open(str(OUTPUT), "wb") as wav_file:
    voice.synthesize_wav(text, wav_file)

print("Done!")
print(f"Audio saved to: {OUTPUT}")
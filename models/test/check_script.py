import sys
import unicodedata
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from translate import IndicTransONNX

MODEL_DIR = Path(__file__).resolve().parent.parent / "model"
SENTENCES_FILE = Path(__file__).resolve().parent / "classroom_sentences.txt"

model = IndicTransONNX(str(MODEL_DIR))

sentences = [
    line.strip()
    for line in SENTENCES_FILE.read_text(encoding="utf-8").splitlines()
    if line.strip()
]

print("=" * 70)
print("OL CHIKI SCRIPT CHECK")
print("=" * 70)

for i, text in enumerate(sentences, 1):

    result = model.translate(
        text,
        src_lang="hin_Deva",
        tgt_lang="sat_Olck",
    )

    suspicious = []

    for char in result:
        name = unicodedata.name(char, "UNKNOWN")

        # Ol Chiki Unicode block: U+1C50–U+1C7F
        if not (
            0x1C50 <= ord(char) <= 0x1C7F
            or char.isspace()
            or unicodedata.category(char).startswith("P")
            or unicodedata.category(char).startswith("N")
        ):
            suspicious.append((char, name, f"U+{ord(char):04X}"))

    print(f"\n{i}. {text}")
    print(f"   {result}")

    if suspicious:
        print("   ⚠ SUSPICIOUS CHARACTERS:")
        for char, name, code in suspicious:
            print(f"      {char} — {name} — {code}")
    else:
        print("   ✓ Script looks clean")
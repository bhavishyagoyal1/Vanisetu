import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from translate import IndicTransONNX

MODEL_DIR = Path(__file__).resolve().parent.parent / "model"
SENTENCES_FILE = Path(__file__).resolve().parent / "classroom_sentences.txt"
OUTPUT_FILE = Path(__file__).resolve().parent / "santali_validation.txt"

model = IndicTransONNX(str(MODEL_DIR))

sentences = [
    line.strip()
    for line in SENTENCES_FILE.read_text(encoding="utf-8").splitlines()
    if line.strip()
]

with OUTPUT_FILE.open("w", encoding="utf-8") as f:

    f.write("VANISETU - HINDI → SANTALI VALIDATION\n")
    f.write("=" * 70 + "\n\n")

    for i, text in enumerate(sentences, 1):

        result = model.translate(
            text,
            src_lang="hin_Deva",
            tgt_lang="sat_Olck",
        )

        f.write(f"{i}. Hindi:\n")
        f.write(f"{text}\n\n")

        f.write("Santali:\n")
        f.write(f"{result}\n\n")

        f.write("Native speaker review:\n")
        f.write("[ ] Correct meaning\n")
        f.write("[ ] Needs correction\n")
        f.write("[ ] Unsure\n")
        f.write("Correction/comments: ______________________________\n\n")

        f.write("-" * 70 + "\n\n")

print(f"Validation file created:")
print(OUTPUT_FILE)
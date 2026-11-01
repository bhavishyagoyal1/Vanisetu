import sys
import time
from pathlib import Path
from statistics import mean

sys.path.insert(0, str(Path(__file__).parent))

from translate import IndicTransONNX

MODEL_DIR = Path(__file__).resolve().parent.parent / "model"
SENTENCES_FILE = Path(__file__).resolve().parent / "classroom_sentences.txt"

print("Loading IndicTrans2 INT8 ONNX model...")
load_start = time.perf_counter()

model = IndicTransONNX(str(MODEL_DIR))

load_time = time.perf_counter() - load_start

print(f"Model load time: {load_time:.3f} seconds")
print("-" * 70)

sentences = [
    line.strip()
    for line in SENTENCES_FILE.read_text(encoding="utf-8").splitlines()
    if line.strip()
]

times = []

for i, text in enumerate(sentences, 1):

    start = time.perf_counter()

    result = model.translate(
        text,
        src_lang="hin_Deva",
        tgt_lang="sat_Olck",
    )

    elapsed = time.perf_counter() - start
    times.append(elapsed)

    print(f"\n{i}. Hindi:")
    print(f"   {text}")

    print("   Santali:")
    print(f"   {result}")

    print(f"   Time: {elapsed:.3f} sec")


print("\n" + "=" * 70)
print("BENCHMARK SUMMARY")
print("=" * 70)

print(f"Number of sentences : {len(times)}")
print(f"Average latency     : {mean(times):.3f} sec")
print(f"Minimum latency     : {min(times):.3f} sec")
print(f"Maximum latency     : {max(times):.3f} sec")
print(f"Total translation   : {sum(times):.3f} sec")
print(f"Model load time     : {load_time:.3f} sec")
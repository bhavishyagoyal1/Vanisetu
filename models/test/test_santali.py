import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from translate import IndicTransONNX

MODEL_DIR = Path(__file__).resolve().parent.parent / "model"

print("Loading model...")
load_start = time.perf_counter()

model = IndicTransONNX(str(MODEL_DIR))

load_time = time.perf_counter() - load_start

print(f"Model load time: {load_time:.3f} seconds")

sentences = [
    "बच्चों, अपनी किताब खोलो।",
    "सब बच्चे खड़े हो जाओ।",
    "अपनी पेंसिल निकालो।",
    "यह कौन सा रंग है?",
    "पाँच तक गिनो।",
]

print("\nTranslation tests:\n")

for i, text in enumerate(sentences, 1):

    start = time.perf_counter()

    result = model.translate(
        text,
        src_lang="hin_Deva",
        tgt_lang="sat_Olck",
    )

    elapsed = time.perf_counter() - start

    print(f"{i}. Hindi: {text}")
    print(f"   Santali: {result}")
    print(f"   Translation time: {elapsed:.3f} seconds")
    print()
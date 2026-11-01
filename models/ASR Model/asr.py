"""Shared loading helpers for the betterflow Hindi/Hinglish streaming CTC model.

Model files sit next to this file, so everything works offline.
"""
import hashlib
import os

import sherpa_onnx

HERE = os.path.dirname(os.path.abspath(__file__))
ENCODER = os.path.join(HERE, "encoder.int8.onnx")
TOKENS = os.path.join(HERE, "tokens.txt")
SAMPLE_RATE = 16000

# Pinned upstream revision 2c8ad90 of
# huggingface.co/mobilebytesensei/betterflow-hindi-streaming-ctc
ENCODER_SHA256 = "e5758a0c0549063edf02fafc8af1be19d42715eb816d1b8f4d45e8de0fa6d039"
ENCODER_BYTES = 68954634


def verify_encoder():
    """Return (ok, actual_sha256, actual_size)."""
    size = os.path.getsize(ENCODER)
    h = hashlib.sha256()
    with open(ENCODER, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    digest = h.hexdigest()
    return (digest == ENCODER_SHA256 and size == ENCODER_BYTES), digest, size


def build_recognizer(endpointing=False):
    """CTC needs only the encoder + tokens - there is no decoder or joiner."""
    kwargs = dict(tokens=TOKENS, model=ENCODER)
    if endpointing:
        kwargs.update(
            enable_endpoint_detection=True,
            rule1_min_trailing_silence=2.4,   # silence with no speech yet
            rule2_min_trailing_silence=0.8,   # pause after speech -> commit
            rule3_min_utterance_length=20.0,  # hard cap on one segment
        )
    return sherpa_onnx.OnlineRecognizer.from_zipformer2_ctc(**kwargs)

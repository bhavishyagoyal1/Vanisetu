"""WER/CER scoring for the ASR bundle.

Implemented here rather than pulled from `jiwer` to keep the bundle
self-contained and offline, the same reason the model weights sit next to the
code. The alignment is a plain Levenshtein DP - about thirty lines, and
tested, which matters more than the dependency it avoids.

Both WER and CER are reported. CER earns its place for this language pair:
Devanagari matra and nukta errors are partial failures that WER scores as
total misses, and this model's word segmentation is unreliable enough that
word-level counts alone paint a misleading picture.
"""
import re
import unicodedata
from collections import namedtuple

# Stripped before scoring: the ASR emits no punctuation and no casing, so
# charging it for either would measure the reference's formatting, not the
# model's recognition.
_PUNCTUATION = "।॥,.?!;:()[]{}\"'`-–—"
_WHITESPACE = re.compile(r"\s+")
# Zero-width joiners are invisible and inconsistently typed; folding them
# keeps us from measuring Unicode trivia instead of speech recognition.
_ZERO_WIDTH = dict.fromkeys(map(ord, "‌‍"), None)

Score = namedtuple(
    "Score",
    "wer cer substitutions deletions insertions ref_words ref_chars utterances",
)


def normalize_for_scoring(text):
    """Fold away everything the recognizer could not have produced."""
    text = unicodedata.normalize("NFC", text)
    text = text.translate(_ZERO_WIDTH)
    text = "".join(" " if ch in _PUNCTUATION else ch for ch in text)
    return _WHITESPACE.sub(" ", text).strip().lower()


def _edit_counts(reference, hypothesis):
    """Return (substitutions, deletions, insertions) aligning hyp to ref."""
    rows, cols = len(reference) + 1, len(hypothesis) + 1
    # cost[i][j] = (total_edits, subs, dels, ins) for ref[:i] vs hyp[:j]
    previous = [(j, 0, 0, j) for j in range(cols)]
    for i in range(1, rows):
        current = [(i, 0, i, 0)] + [None] * (len(hypothesis))
        for j in range(1, cols):
            if reference[i - 1] == hypothesis[j - 1]:
                current[j] = previous[j - 1]
                continue
            sub = previous[j - 1]
            dele = previous[j]
            ins = current[j - 1]
            best = min(sub[0], dele[0], ins[0])
            if sub[0] == best:
                current[j] = (best + 1, sub[1] + 1, sub[2], sub[3])
            elif dele[0] == best:
                current[j] = (best + 1, dele[1], dele[2] + 1, dele[3])
            else:
                current[j] = (best + 1, ins[1], ins[2], ins[3] + 1)
        previous = current
    _, subs, dels, ins = previous[-1]
    return subs, dels, ins


def score(references, hypotheses):
    """Score aligned lists of reference and hypothesis strings.

    WER is undefined when the references contain no words at all - that is the
    case for the `noise` fixtures, whose references are empty on purpose - so
    it is reported as 0.0 there and the insertion count carries the meaning.
    """
    if len(references) != len(hypotheses):
        raise ValueError("references and hypotheses must be the same length")

    subs = dels = ins = ref_words = 0
    char_edits = ref_chars = 0
    for reference, hypothesis in zip(references, hypotheses):
        ref = normalize_for_scoring(reference)
        hyp = normalize_for_scoring(hypothesis)

        ref_tokens = ref.split()
        hyp_tokens = hyp.split()
        s, d, i = _edit_counts(ref_tokens, hyp_tokens)
        subs, dels, ins = subs + s, dels + d, ins + i
        ref_words += len(ref_tokens)

        cs, cd, ci = _edit_counts(list(ref), list(hyp))
        char_edits += cs + cd + ci
        ref_chars += len(ref)

    return Score(
        wer=(subs + dels + ins) / ref_words if ref_words else 0.0,
        cer=char_edits / ref_chars if ref_chars else 0.0,
        substitutions=subs,
        deletions=dels,
        insertions=ins,
        ref_words=ref_words,
        ref_chars=ref_chars,
        utterances=len(references),
    )

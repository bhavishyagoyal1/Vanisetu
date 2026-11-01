"""Normalizes ASR transcripts into valid hin_Deva text.

The Hinglish ASR emits code-switched output - Devanagari for Hindi, Latin for
English loanwords, ASCII for digits (see HANDOFF.md and tokens.txt: 26 Latin
tokens sit in the same output layer as the 63 Devanagari ones). IndicTrans2
consumes this text tagged `hin_Deva`, for which Latin and ASCII digits are
out-of-script. Everything here exists to close that gap.
"""
import re

_LATIN_RUN = re.compile(r"[A-Za-z]+")

# Conventional Devanagari spellings for English words common in a primary
# classroom. These beat the transliterator because real usage is not
# phonetically regular ("school" is स्कूल, not स्चूल).
LOANWORDS = {
    "school": "स्कूल", "computer": "कंप्यूटर", "class": "क्लास",
    "teacher": "टीचर", "copy": "कॉपी", "pencil": "पेंसिल",
    "book": "बुक", "board": "बोर्ड", "model": "मॉडल",
    "test": "टेस्ट", "paper": "पेपर", "pen": "पेन",
    "bag": "बैग", "table": "टेबल", "chair": "कुर्सी",
    "answer": "आंसर", "question": "क्वेश्चन", "number": "नंबर",
    "colour": "कलर", "color": "कलर", "student": "स्टूडेंट",
    "homework": "होमवर्क", "exam": "एग्जाम", "page": "पेज",
    "line": "लाइन", "map": "मैप", "picture": "पिक्चर",
}

# Longest-first so digraphs win over their constituent letters.
_GRAPHEMES = [
    ("tch", "च"),
    ("sh", "श"), ("ch", "च"), ("th", "थ"), ("ph", "फ"), ("kh", "ख"),
    ("gh", "घ"), ("bh", "भ"), ("dh", "ध"), ("jh", "झ"), ("ck", "क"),
    ("ee", "ई"), ("oo", "ऊ"), ("aa", "आ"), ("ai", "ऐ"), ("au", "औ"),
    ("ea", "ई"), ("ou", "ऊ"),
    ("a", "अ"), ("e", "ए"), ("i", "इ"), ("o", "ओ"), ("u", "उ"),
    ("b", "ब"), ("c", "क"), ("d", "ड"), ("f", "फ"), ("g", "ग"),
    ("h", "ह"), ("j", "ज"), ("k", "क"), ("l", "ल"), ("m", "म"),
    ("n", "न"), ("p", "प"), ("q", "क"), ("r", "र"), ("s", "स"),
    ("t", "ट"), ("v", "व"), ("w", "व"), ("x", "क्स"), ("y", "य"),
    ("z", "ज़"),
]

# Independent vowel -> its matra form. A vowel opening a syllable keeps the
# independent form; after a consonant it must become a matra.
_MATRA = {
    "अ": "", "आ": "ा", "इ": "ि", "ई": "ी", "उ": "ु",
    "ऊ": "ू", "ए": "े", "ऐ": "ै", "ओ": "ो", "औ": "ौ",
}
_VIRAMA = "्"


# A trailing silent "e" lengthens the preceding vowel instead of being
# pronounced: name -> नेम, taste -> टेस्ट. Rewrite that vowel and drop the e.
_MAGIC_E = re.compile(r"^(.*?)([aeiou])([^aeiou]+)e$")
_MAGIC_E_VOWEL = {"a": "e", "e": "i", "i": "ai", "o": "o", "u": "yu"}
# "c" is a sibilant before a front vowel (city -> सिटी) and a stop otherwise.
_SOFT_C = re.compile(r"c(?=[eiy])")
# A word-final "y" is a vowel, not the consonant य: city -> सिटी, not सिटय.
_FINAL_Y = re.compile(r"(?<=[^aeiou])y$")


def _apply_spelling_rules(word):
    match = _MAGIC_E.match(word)
    if match and len(word) > 3:
        head, vowel, tail = match.groups()
        word = head + _MAGIC_E_VOWEL[vowel] + tail
    word = _SOFT_C.sub("s", word)
    word = _FINAL_Y.sub("ee", word)
    return word


def _split_graphemes(word):
    units, i = [], 0
    while i < len(word):
        for src, dst in _GRAPHEMES:
            if word.startswith(src, i):
                units.append(dst)
                i += len(src)
                break
        else:
            i += 1  # unmappable character, drop it
    return units


def transliterate_latin(word):
    """Transliterate one Latin word into Devanagari."""
    known = LOANWORDS.get(word.lower())
    if known:
        return known

    units = _split_graphemes(_apply_spelling_rules(word.lower()))
    out = []
    for idx, unit in enumerate(units):
        if unit in _MATRA:
            # Vowel: independent at the start of the word or after another
            # vowel, matra when it follows a consonant.
            if idx == 0 or units[idx - 1] in _MATRA:
                out.append(unit)
            else:
                out.append(_MATRA[unit])
            continue
        # Consonant. A following consonant means a cluster, which needs an
        # explicit virama; a word-final consonant takes none, because Hindi
        # deletes the inherent schwa there anyway (test -> टेस्ट, not टेस्टअ).
        out.append(unit)
        is_last = idx == len(units) - 1
        if not is_last and units[idx + 1] not in _MATRA:
            out.append(_VIRAMA)
    return "".join(out)


# A token repeated this many times in a row is the hallucination signature,
# not speech. Real Hindi doubles words for emphasis ("बहुत बहुत अच्छा") but
# does not triple them, so the threshold sits above ordinary repetition.
_MAX_CONSECUTIVE_REPEATS = 3


def is_hallucinated(text):
    """True when the text has the degenerate shape of a silence hallucination.

    Fed bit-exact silence the model emits confident runs of a single token
    ("का का का ..."). There is no confidence score to threshold on this CTC
    path, so the repetition itself is the only signal available.
    """
    words = text.split()
    run = 1
    for previous, current in zip(words, words[1:]):
        run = run + 1 if current == previous else 1
        if run > _MAX_CONSECUTIVE_REPEATS:
            return True
    return False


def normalize(text):
    """Normalize one committed ASR transcript into hin_Deva text.

    Returns an empty string for transcripts judged hallucinated - silence
    that produces plausible text is worse than silence that produces nothing.
    """
    if is_hallucinated(text):
        return ""
    text = text.translate(_DEVANAGARI_DIGITS)
    text = _LATIN_RUN.sub(lambda m: transliterate_latin(m.group(0)), text)
    text = _DIGIT_RUN.sub(lambda m: _spell_digit_run(m.group(0)), text)
    text = _WHITESPACE.sub(" ", text).strip()
    if text and text[-1] not in _TERMINATORS:
        text += "।"
    return text


# Hindi numerals below 100 are lexically irregular - each is its own word, so
# they must be enumerated rather than composed from tens and units.
_NUMBERS = [
    "शून्य", "एक", "दो", "तीन", "चार", "पाँच", "छह", "सात", "आठ", "नौ",
    "दस", "ग्यारह", "बारह", "तेरह", "चौदह", "पंद्रह", "सोलह", "सत्रह", "अठारह", "उन्नीस",
    "बीस", "इक्कीस", "बाईस", "तेईस", "चौबीस", "पच्चीस", "छब्बीस", "सत्ताईस", "अट्ठाईस", "उनतीस",
    "तीस", "इकतीस", "बत्तीस", "तैंतीस", "चौंतीस", "पैंतीस", "छत्तीस", "सैंतीस", "अड़तीस", "उनतालीस",
    "चालीस", "इकतालीस", "बयालीस", "तैंतालीस", "चवालीस", "पैंतालीस", "छियालीस", "सैंतालीस", "अड़तालीस", "उनचास",
    "पचास", "इक्यावन", "बावन", "तिरेपन", "चौवन", "पचपन", "छप्पन", "सत्तावन", "अट्ठावन", "उनसठ",
    "साठ", "इकसठ", "बासठ", "तिरसठ", "चौंसठ", "पैंसठ", "छियासठ", "सड़सठ", "अड़सठ", "उनहत्तर",
    "सत्तर", "इकहत्तर", "बहत्तर", "तिहत्तर", "चौहत्तर", "पचहत्तर", "छिहत्तर", "सतहत्तर", "अठहत्तर", "उन्यासी",
    "अस्सी", "इक्यासी", "बयासी", "तिरासी", "चौरासी", "पचासी", "छियासी", "सत्तासी", "अट्ठासी", "नवासी",
    "नब्बे", "इक्यानवे", "बानवे", "तिरानवे", "चौरानवे", "पंचानवे", "छियानवे", "सत्तानवे", "अट्ठानवे", "निन्यानवे",
]
_SCALES = [(10000000, "करोड़"), (100000, "लाख"), (1000, "हज़ार"), (100, "सौ")]

_DIGIT_RUN = re.compile(r"[0-9]+")
_WHITESPACE = re.compile(r"\s+")
_TERMINATORS = "।॥?!."
# Devanagari digits are also out of scope for a spelled-out transcript.
_DEVANAGARI_DIGITS = str.maketrans("०१२३४५६७८९", "0123456789")


# Beyond this many digits a run is an identifier (phone number, code), not a
# quantity. Composing it would also overflow a 64-bit int in the Dart port.
_MAX_COMPOSED_DIGITS = 9


def _spell_digit_run(run):
    """Spell a run of digits, as a quantity if short enough, else one by one."""
    if len(run) > _MAX_COMPOSED_DIGITS:
        return " ".join(_NUMBERS[int(digit)] for digit in run)
    return number_to_hindi(int(run))


def number_to_hindi(n):
    """Spell a non-negative integer as Hindi words."""
    if n < 100:
        return _NUMBERS[n]
    for value, name in _SCALES:
        if n >= value:
            words = "{} {}".format(number_to_hindi(n // value), name)
            remainder = n % value
            if remainder:
                words += " " + number_to_hindi(remainder)
            return words
    raise AssertionError("unreachable: n >= 100 always matches a scale")

/// Normalizes ASR transcripts into valid `hin_Deva` text.
///
/// The bundled ASR is a Hinglish model: `tokens.txt` is character-level and
/// holds 26 Latin tokens (`a`–`z`) in the same output layer as the 63
/// Devanagari ones, plus 10 ASCII digits. It therefore emits code-switched
/// text — `model`, not `मॉडल` — exactly as `models/ASR Model/HANDOFF.md`
/// describes.
///
/// [HindiSantaliMtService] feeds that text to IndicTrans2 tagged `hin_Deva`,
/// for which Latin runs and ASCII digits are out of script. Everything here
/// exists to close that gap.
///
/// This is a port of `models/ASR Model/normalize.py`. Both implementations
/// are pinned to the same behavioural contract in
/// `models/ASR Model/eval/normalizer_cases.json`; see
/// `test/asr_normalizer_test.dart`. Change one side without the other and the
/// shared-case tests fail, which is the point.
library;

/// Conventional Devanagari spellings for English words common in a primary
/// classroom. These beat the transliterator because real usage is not
/// phonetically regular — `school` is `स्कूल`, not `स्चूल`.
const Map<String, String> _loanwords = {
  'school': 'स्कूल',
  'computer': 'कंप्यूटर',
  'class': 'क्लास',
  'teacher': 'टीचर',
  'copy': 'कॉपी',
  'pencil': 'पेंसिल',
  'book': 'बुक',
  'board': 'बोर्ड',
  'model': 'मॉडल',
  'test': 'टेस्ट',
  'paper': 'पेपर',
  'pen': 'पेन',
  'bag': 'बैग',
  'table': 'टेबल',
  'chair': 'कुर्सी',
  'answer': 'आंसर',
  'question': 'क्वेश्चन',
  'number': 'नंबर',
  'colour': 'कलर',
  'color': 'कलर',
  'student': 'स्टूडेंट',
  'homework': 'होमवर्क',
  'exam': 'एग्जाम',
  'page': 'पेज',
  'line': 'लाइन',
  'map': 'मैप',
  'picture': 'पिक्चर',
};

/// Longest-first, so digraphs win over their constituent letters.
const List<List<String>> _graphemes = [
  ['tch', 'च'],
  ['sh', 'श'],
  ['ch', 'च'],
  ['th', 'थ'],
  ['ph', 'फ'],
  ['kh', 'ख'],
  ['gh', 'घ'],
  ['bh', 'भ'],
  ['dh', 'ध'],
  ['jh', 'झ'],
  ['ck', 'क'],
  ['ee', 'ई'],
  ['oo', 'ऊ'],
  ['aa', 'आ'],
  ['ai', 'ऐ'],
  ['au', 'औ'],
  ['ea', 'ई'],
  ['ou', 'ऊ'],
  ['a', 'अ'],
  ['e', 'ए'],
  ['i', 'इ'],
  ['o', 'ओ'],
  ['u', 'उ'],
  ['b', 'ब'],
  ['c', 'क'],
  ['d', 'ड'],
  ['f', 'फ'],
  ['g', 'ग'],
  ['h', 'ह'],
  ['j', 'ज'],
  ['k', 'क'],
  ['l', 'ल'],
  ['m', 'म'],
  ['n', 'न'],
  ['p', 'प'],
  ['q', 'क'],
  ['r', 'र'],
  ['s', 'स'],
  ['t', 'ट'],
  ['v', 'व'],
  ['w', 'व'],
  ['x', 'क्स'],
  ['y', 'य'],
  ['z', 'ज़'],
];

/// Independent vowel to its matra form. A vowel opening a syllable keeps the
/// independent form; after a consonant it must become a matra.
const Map<String, String> _matra = {
  'अ': '',
  'आ': 'ा',
  'इ': 'ि',
  'ई': 'ी',
  'उ': 'ु',
  'ऊ': 'ू',
  'ए': 'े',
  'ऐ': 'ै',
  'ओ': 'ो',
  'औ': 'ौ',
};

const String _virama = '्';
const String _vowelLetters = 'aeiou';
const String _terminators = '।॥?!.';

/// Hindi numerals below 100 are lexically irregular — each is its own word,
/// so they must be enumerated rather than composed from tens and units.
const List<String> _numbers = [
  'शून्य',
  'एक',
  'दो',
  'तीन',
  'चार',
  'पाँच',
  'छह',
  'सात',
  'आठ',
  'नौ',
  'दस',
  'ग्यारह',
  'बारह',
  'तेरह',
  'चौदह',
  'पंद्रह',
  'सोलह',
  'सत्रह',
  'अठारह',
  'उन्नीस',
  'बीस',
  'इक्कीस',
  'बाईस',
  'तेईस',
  'चौबीस',
  'पच्चीस',
  'छब्बीस',
  'सत्ताईस',
  'अट्ठाईस',
  'उनतीस',
  'तीस',
  'इकतीस',
  'बत्तीस',
  'तैंतीस',
  'चौंतीस',
  'पैंतीस',
  'छत्तीस',
  'सैंतीस',
  'अड़तीस',
  'उनतालीस',
  'चालीस',
  'इकतालीस',
  'बयालीस',
  'तैंतालीस',
  'चवालीस',
  'पैंतालीस',
  'छियालीस',
  'सैंतालीस',
  'अड़तालीस',
  'उनचास',
  'पचास',
  'इक्यावन',
  'बावन',
  'तिरेपन',
  'चौवन',
  'पचपन',
  'छप्पन',
  'सत्तावन',
  'अट्ठावन',
  'उनसठ',
  'साठ',
  'इकसठ',
  'बासठ',
  'तिरसठ',
  'चौंसठ',
  'पैंसठ',
  'छियासठ',
  'सड़सठ',
  'अड़सठ',
  'उनहत्तर',
  'सत्तर',
  'इकहत्तर',
  'बहत्तर',
  'तिहत्तर',
  'चौहत्तर',
  'पचहत्तर',
  'छिहत्तर',
  'सतहत्तर',
  'अठहत्तर',
  'उन्यासी',
  'अस्सी',
  'इक्यासी',
  'बयासी',
  'तिरासी',
  'चौरासी',
  'पचासी',
  'छियासी',
  'सत्तासी',
  'अट्ठासी',
  'नवासी',
  'नब्बे',
  'इक्यानवे',
  'बानवे',
  'तिरानवे',
  'चौरानवे',
  'पंचानवे',
  'छियानवे',
  'सत्तानवे',
  'अट्ठानवे',
  'निन्यानवे',
];

const List<List<Object>> _scales = [
  [10000000, 'करोड़'],
  [100000, 'लाख'],
  [1000, 'हज़ार'],
  [100, 'सौ'],
];

/// A token repeated this many times in a row is the hallucination signature,
/// not speech. Real Hindi doubles words for emphasis (`बहुत बहुत अच्छा`) but
/// does not triple them, so the threshold sits above ordinary repetition.
const int _maxConsecutiveRepeats = 3;

final RegExp _latinRun = RegExp(r'[A-Za-z]+');
final RegExp _digitRun = RegExp(r'[0-9]+');
final RegExp _whitespace = RegExp(r'\s+');
final RegExp _magicE = RegExp(r'^(.*?)([aeiou])([^aeiou]+)e$');
final RegExp _softC = RegExp(r'c([eiy])');

const Map<String, String> _magicEVowel = {
  'a': 'e',
  'e': 'i',
  'i': 'ai',
  'o': 'o',
  'u': 'yu',
};

const Map<String, String> _devanagariDigits = {
  '०': '0',
  '१': '1',
  '२': '2',
  '३': '3',
  '४': '4',
  '५': '5',
  '६': '6',
  '७': '7',
  '८': '8',
  '९': '9',
};

/// Beyond this many digits a run is an identifier (phone number, code), not a
/// quantity. Composing it would also overflow Dart's 64-bit int.
const int _maxComposedDigits = 9;

/// Spells a run of digits — as a quantity if short enough, else one by one.
String _spellDigitRun(String run) {
  if (run.length > _maxComposedDigits) {
    return run.split('').map((d) => _numbers[int.parse(d)]).join(' ');
  }
  return numberToHindi(int.parse(run));
}

/// Spells a non-negative integer as Hindi words.
String numberToHindi(int n) {
  if (n < 100) return _numbers[n];
  for (final scale in _scales) {
    final value = scale[0] as int;
    final name = scale[1] as String;
    if (n >= value) {
      final words = StringBuffer('${numberToHindi(n ~/ value)} $name');
      final remainder = n % value;
      if (remainder != 0) words.write(' ${numberToHindi(remainder)}');
      return words.toString();
    }
  }
  throw StateError('unreachable: n >= 100 always matches a scale');
}

String _applySpellingRules(String word) {
  // A trailing silent "e" lengthens the preceding vowel instead of being
  // pronounced: name -> नेम, taste -> टेस्ट. Rewrite that vowel, drop the e.
  final match = _magicE.firstMatch(word);
  if (match != null && word.length > 3) {
    word = '${match.group(1)}${_magicEVowel[match.group(2)]}${match.group(3)}';
  }
  // "c" is a sibilant before a front vowel (city -> सिटी), a stop otherwise.
  word = word.replaceAllMapped(_softC, (m) => 's${m.group(1)}');
  // A word-final "y" is a vowel, not the consonant य: city -> सिटी.
  if (word.length > 1 &&
      word.endsWith('y') &&
      !_vowelLetters.contains(word[word.length - 2])) {
    word = '${word.substring(0, word.length - 1)}ee';
  }
  return word;
}

List<String> _splitGraphemes(String word) {
  final units = <String>[];
  var i = 0;
  while (i < word.length) {
    var matched = false;
    for (final pair in _graphemes) {
      if (word.startsWith(pair[0], i)) {
        units.add(pair[1]);
        i += pair[0].length;
        matched = true;
        break;
      }
    }
    if (!matched) i += 1; // unmappable character, drop it
  }
  return units;
}

/// Transliterates one Latin word into Devanagari.
String transliterateLatin(String word) {
  final known = _loanwords[word.toLowerCase()];
  if (known != null) return known;

  final units = _splitGraphemes(_applySpellingRules(word.toLowerCase()));
  final out = StringBuffer();
  for (var idx = 0; idx < units.length; idx++) {
    final unit = units[idx];
    if (_matra.containsKey(unit)) {
      // Vowel: independent at the start of the word or after another vowel,
      // matra when it follows a consonant.
      final independent = idx == 0 || _matra.containsKey(units[idx - 1]);
      out.write(independent ? unit : _matra[unit]);
      continue;
    }
    // Consonant. A following consonant means a cluster, which needs an
    // explicit virama; a word-final consonant takes none, because Hindi
    // deletes the inherent schwa there anyway (test -> टेस्ट, not टेस्टअ).
    out.write(unit);
    final isLast = idx == units.length - 1;
    if (!isLast && !_matra.containsKey(units[idx + 1])) out.write(_virama);
  }
  return out.toString();
}

/// True when the text has the degenerate shape of a silence hallucination.
///
/// Fed bit-exact silence the model emits confident runs of a single token
/// (`का का का ...`). There is no confidence score to threshold on this CTC
/// path — `ys_probs` comes back empty — so the repetition itself is the only
/// signal available.
bool isHallucinated(String text) {
  final words = text
      .split(_whitespace)
      .where((w) => w.isNotEmpty)
      .toList(growable: false);
  var run = 1;
  for (var i = 1; i < words.length; i++) {
    run = words[i] == words[i - 1] ? run + 1 : 1;
    if (run > _maxConsecutiveRepeats) return true;
  }
  return false;
}

/// Normalizes one committed ASR transcript into `hin_Deva` text.
///
/// Returns an empty string for transcripts judged hallucinated — silence that
/// produces plausible text is worse than silence that produces nothing.
String normalizeTranscript(String text) {
  if (isHallucinated(text)) return '';

  var result = text;
  _devanagariDigits.forEach((deva, ascii) {
    result = result.replaceAll(deva, ascii);
  });
  result = result.replaceAllMapped(
    _latinRun,
    (m) => transliterateLatin(m.group(0)!),
  );
  result = result.replaceAllMapped(
    _digitRun,
    (m) => _spellDigitRun(m.group(0)!),
  );
  return _tidy(result);
}

/// Collapses whitespace and gives the sentence a final danda. Shared so that
/// [transcriptWasCleaned] can tell this cosmetic tidying apart from the
/// script rewrite that precedes it.
String _tidy(String text) {
  var result = text.replaceAll(_whitespace, ' ').trim();
  if (result.isNotEmpty && !_terminators.contains(result[result.length - 1])) {
    result += '।';
  }
  return result;
}

/// Whether [normalizeTranscript] materially rewrites [raw] — transliterating
/// a Latin run or spelling out digits — as opposed to only tidying spacing
/// and punctuation.
///
/// Drives the Translate screen's "Cleaned ASR" badge, which claims the
/// transcript was pulled back into `hin_Deva`; appending a danda is not that,
/// so this stays false for it.
bool transcriptWasCleaned(String raw) {
  if (raw.trim().isEmpty) return false;
  if (isHallucinated(raw)) return false;
  return normalizeTranscript(raw) != _tidy(raw);
}

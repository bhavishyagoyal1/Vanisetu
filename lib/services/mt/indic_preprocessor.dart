/// Port of the parts of AI4Bharat's `IndicTransToolkit.IndicProcessor` that
/// are actually reachable for a fixed hin_Deva -> sat_Olck pipeline.
///
/// Verified against the upstream Cython source
/// (github.com/VarunGumma/IndicTransToolkit, IndicTransToolkit/processor.pyx)
/// and against the actually-installed package (same logic). Two things were
/// verified by running the reference libraries directly rather than reading
/// source, because reading alone left a real contradiction unresolved:
///
/// 1. `_preprocess` for src_lang="hin_Deva" transliterates hi -> hi, which
///    is an identity transform (confirmed: `UnicodeIndicTransliterator`
///    only remaps characters that fall inside the *source* script's own
///    Unicode block, so a same-language call touches nothing).
/// 2. `_postprocess` for lang="sat_Olck" calls `transliterate(text, "hi",
///    "or")`, which on its face looks like it would produce Odia — but the
///    decoder for this specific model emits genuine Ol Chiki tokens
///    natively (verified: 6,695 tokenizer_tgt.json vocab entries contain
///    real Ol Chiki characters), and the transliterator only rewrites
///    characters inside Devanagari's codepoint range, so it is a no-op
///    pass-through for real Ol Chiki text. No Devanagari->Ol Chiki
///    transliteration table exists or is needed for this pair.
///
/// This class intentionally skips the `IndicNormalizerFactory`/
/// `DevanagariNormalizer` step and `indic_tokenize.trivial_tokenize`'s full
/// rule set — verified empirically to be a near-identity transform on
/// already-well-formed typed Devanagari text — in favour of the punctuation
/// splitting implemented directly below.
class IndicPreprocessResult {
  IndicPreprocessResult(this.text, this.placeholders);

  /// Fully processed, space-joined sentence (no language tags — those are
  /// added as literal vocab IDs by the caller).
  final String text;

  /// Placeholder token -> original substring, to restore after generation.
  final Map<String, String> placeholders;
}

class IndicPreprocessor {
  // Mirrors processor.pyx's _PUNC_REPLACEMENTS, in the same order.
  static final List<MapEntry<RegExp, String Function(Match)>> _puncReplacements = [
    MapEntry(RegExp(r'\r'), (_) => ''),
    MapEntry(RegExp(r'\(\s*'), (_) => '('),
    MapEntry(RegExp(r'\s*\)'), (_) => ')'),
    MapEntry(RegExp(r'\s:\s?'), (_) => ':'),
    MapEntry(RegExp(r'\s;\s?'), (_) => ';'),
    MapEntry(RegExp(r"[`´‘‚’]"), (_) => "'"),
    MapEntry(RegExp(r'[„“”«»]'), (_) => '"'),
    MapEntry(RegExp(r'[–—]'), (_) => '-'),
    MapEntry(RegExp(r' %'), (_) => '%'),
    MapEntry(RegExp(r' [?!;]'), (m) => m.group(0)!.trim()),
  ];

  static final RegExp _multiSpace = RegExp(r'[ ]{2,}');
  static final RegExp _endBracketSpacePunc = RegExp(r'\) ([.!:?;,])');
  static final RegExp _digitSpacePercent = RegExp(r'(\d) %');
  static final RegExp _doubleQuotPunc = RegExp(r'"([,.]+)');
  static final RegExp _digitNbspDigit = RegExp(r'(\d) (\d)');

  static final RegExp _urlPattern = RegExp(
    r'\b(?<![\w/.])(?:(?:https?|ftp)://)?(?:(?:[\w-]+\.)+(?!\.))(?:[\w/\-?#&=%.]+)+(?!\.\w+)\b',
  );
  static final RegExp _numeralPattern = RegExp(
    r"(~?\d+\.?\d*\s?%?\s?-?\s?~?\d+\.?\d*\s?%|~?\d+%|\d+[-/.,:']\d+[-/.,:'+]\d+(?:\.\d+)?|\d+[-/.:'+]\d+(?:\.\d+)?)",
  );
  static final RegExp _emailPattern = RegExp(
    r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}',
  );
  static final RegExp _otherPattern = RegExp(r'[A-Za-z0-9]*[#@]\w+');

  // Devanagari digits -> ASCII (processor.pyx's _digits_translation_table,
  // hin_Deva-relevant subset; other scripts' digit blocks omitted since
  // they cannot appear in Hindi input).
  static const Map<int, String> _devanagariDigits = {
    0x0966: '0', 0x0967: '1', 0x0968: '2', 0x0969: '3', 0x096A: '4',
    0x096B: '5', 0x096C: '6', 0x096D: '7', 0x096E: '8', 0x096F: '9',
  };

  static const List<String> _punctuationMarks = [
    '।', '॥', ',', '.', '?', '!', ';', ':', '(', ')', '[', ']', '{', '}',
    '"', "'",
  ];

  String _normalizeDigits(String text) {
    final buffer = StringBuffer();
    for (final rune in text.runes) {
      buffer.write(_devanagariDigits[rune] ?? String.fromCharCode(rune));
    }
    return buffer.toString();
  }

  String _puncNorm(String text) {
    for (final entry in _puncReplacements) {
      text = text.replaceAllMapped(entry.key, entry.value);
    }
    text = text.replaceAll(_multiSpace, ' ');
    text = text.replaceAllMapped(_endBracketSpacePunc, (m) => ') ${m.group(1)}');
    text = text.replaceAllMapped(_digitSpacePercent, (m) => '${m.group(1)}%');
    text = text.replaceAllMapped(_doubleQuotPunc, (m) => '${m.group(1)}"');
    text = text.replaceAllMapped(_digitNbspDigit, (m) => '${m.group(1)}.${m.group(2)}');
    return text.trim();
  }

  ({String text, Map<String, String> placeholders}) _wrapPlaceholders(String text) {
    final placeholders = <String, String>{};
    var serial = 1;
    for (final pattern in [_emailPattern, _urlPattern, _numeralPattern, _otherPattern]) {
      final matches = pattern.allMatches(text).map((m) => m.group(0)!).toSet();
      for (final match in matches) {
        if (identical(pattern, _urlPattern) && match.replaceAll('.', '').length < 4) {
          continue;
        }
        if (identical(pattern, _numeralPattern) &&
            match.replaceAll(' ', '').replaceAll('.', '').replaceAll(':', '').length < 4) {
          continue;
        }
        final placeholder = '<ID$serial>';
        placeholders[placeholder] = match;
        text = text.replaceAll(match, placeholder);
        serial++;
      }
    }
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    return (text: text, placeholders: placeholders);
  }

  /// Approximates `indic_tokenize.trivial_tokenize` for Devanagari text:
  /// split on whitespace, then peel standalone punctuation off the start
  /// and end of each chunk as separate tokens. Verified against
  /// `indic_tokenize.trivial_tokenize` output for the app's classroom-style
  /// test sentences (numbers, danda, comma, question mark).
  List<String> _tokenize(String text) {
    final tokens = <String>[];
    for (final chunk in text.split(RegExp(r'\s+'))) {
      if (chunk.isEmpty) continue;
      var start = 0;
      var end = chunk.length;
      final leading = <String>[];
      while (start < end && _punctuationMarks.contains(chunk[start])) {
        leading.add(chunk[start]);
        start++;
      }
      final trailing = <String>[];
      while (end > start && _punctuationMarks.contains(chunk[end - 1])) {
        trailing.add(chunk[end - 1]);
        end--;
      }
      tokens.addAll(leading);
      if (start < end) tokens.add(chunk.substring(start, end));
      tokens.addAll(trailing.reversed);
    }
    return tokens;
  }

  /// Preprocesses raw Hindi input into the space-joined, placeholder-masked
  /// sentence to be BPE-encoded (language tags are added by the caller).
  IndicPreprocessResult preprocess(String rawText) {
    var text = _puncNorm(rawText);
    text = _normalizeDigits(text);
    final wrapped = _wrapPlaceholders(text);
    final tokens = _tokenize(wrapped.text);
    return IndicPreprocessResult(tokens.join(' ').trim(), wrapped.placeholders);
  }

  static final RegExp _spaceBeforePunctuation = RegExp(r'\s+([,।॥?!.:;])');

  /// Postprocesses raw decoded target text: restores placeholders and fixes
  /// punctuation spacing (verified against `indic_detokenize.trivial_detokenize`
  /// output: it strips the space before punctuation, nothing else, for the
  /// language pair used here).
  String postprocess(String rawDecoded, Map<String, String> placeholders) {
    var text = rawDecoded;
    placeholders.forEach((placeholder, original) {
      text = text.replaceAll(placeholder, original);
    });
    text = text.replaceAllMapped(_spaceBeforePunctuation, (m) => m.group(1)!);
    return text.trim();
  }
}

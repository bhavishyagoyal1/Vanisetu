/// A from-scratch port of HuggingFace `tokenizers`' BPE algorithm, reading
/// the exact `tokenizer_src.json` / `tokenizer_tgt.json` format shipped with
/// the IndicTrans2 ONNX export (see models/indic_translate/README.md).
///
/// Verified against the actual model files: `model.type == "BPE"`,
/// `byte_fallback == false` (base symbols are Unicode codepoints, not
/// bytes), `continuing_subword_prefix`/`end_of_word_suffix` both null, and
/// pre_tokenizer/decoder are both `Metaspace` with replacement "▁" and
/// `prepend_scheme: "always"`. Deliberately does NOT implement the
/// `normalizer` (a SentencePiece "Precompiled" charsmap trie) — for
/// already-well-formed typed Devanagari text this normalizer is close to a
/// no-op, and porting its binary trie format is out of scope.
class BpeTokenizer {
  BpeTokenizer({
    required this.vocab,
    required this.idToToken,
    required this.mergeRanks,
    required this.unkToken,
  });

  final Map<String, int> vocab;
  final Map<int, String> idToToken;
  final Map<String, int> mergeRanks;
  final String unkToken;

  int get unkId => vocab[unkToken] ?? 3;

  factory BpeTokenizer.fromJson(Map<String, dynamic> json) {
    final model = json['model'] as Map<String, dynamic>;
    final rawVocab = model['vocab'] as Map<String, dynamic>;
    final vocab = <String, int>{};
    final idToToken = <int, String>{};
    rawVocab.forEach((token, id) {
      final intId = id as int;
      vocab[token] = intId;
      idToToken[intId] = token;
    });

    final merges = model['merges'] as List;
    final mergeRanks = <String, int>{};
    for (var i = 0; i < merges.length; i++) {
      final entry = merges[i];
      String a, b;
      if (entry is List) {
        a = entry[0] as String;
        b = entry[1] as String;
      } else {
        final parts = (entry as String).split(' ');
        a = parts[0];
        b = parts[1];
      }
      mergeRanks['$a $b'] = i;
    }

    final unkToken = model['unk_token'] as String? ?? '<unk>';
    return BpeTokenizer(
      vocab: vocab,
      idToToken: idToToken,
      mergeRanks: mergeRanks,
      unkToken: unkToken,
    );
  }

  /// Metaspace pre-tokenization: prepend "▁" (prepend_scheme=always), treat
  /// it as the word-boundary marker, and split into pieces that each start
  /// with "▁".
  List<String> _metaspaceSplit(String text) {
    final marked = '▁${text.replaceAll(' ', '▁')}';
    final pieces = <String>[];
    final buffer = StringBuffer();
    for (final rune in marked.runes) {
      final ch = String.fromCharCode(rune);
      if (ch == '▁' && buffer.isNotEmpty) {
        pieces.add(buffer.toString());
        buffer.clear();
      }
      buffer.write(ch);
    }
    if (buffer.isNotEmpty) pieces.add(buffer.toString());
    return pieces;
  }

  /// Classic BPE merge loop over Unicode-codepoint symbols: repeatedly merge
  /// the adjacent pair with the lowest merge rank until none apply.
  List<String> _bpeMerge(String piece) {
    var symbols = piece.runes.map(String.fromCharCode).toList();
    if (symbols.length <= 1) return symbols;

    while (symbols.length > 1) {
      int? bestRank;
      var bestIndex = -1;
      for (var i = 0; i < symbols.length - 1; i++) {
        final rank = mergeRanks['${symbols[i]} ${symbols[i + 1]}'];
        if (rank != null && (bestRank == null || rank < bestRank)) {
          bestRank = rank;
          bestIndex = i;
        }
      }
      if (bestIndex == -1) break;
      final merged = symbols[bestIndex] + symbols[bestIndex + 1];
      symbols = [
        ...symbols.sublist(0, bestIndex),
        merged,
        ...symbols.sublist(bestIndex + 2),
      ];
    }
    return symbols;
  }

  /// Encodes already-preprocessed, space-joined text (no language tags —
  /// callers prepend those as literal vocab IDs) into vocab IDs.
  List<int> encode(String text) {
    final ids = <int>[];
    for (final piece in _metaspaceSplit(text)) {
      for (final symbol in _bpeMerge(piece)) {
        ids.add(vocab[symbol] ?? unkId);
      }
    }
    return ids;
  }

  /// Decodes vocab IDs back to text (Metaspace decode: join pieces, replace
  /// "▁" with a space, trim). Unknown IDs are skipped.
  String decode(List<int> ids) {
    final buffer = StringBuffer();
    for (final id in ids) {
      final token = idToToken[id];
      if (token == null) continue;
      buffer.write(token);
    }
    return buffer.toString().replaceAll('▁', ' ').trim();
  }
}

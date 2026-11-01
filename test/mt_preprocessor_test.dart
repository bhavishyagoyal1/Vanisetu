import 'package:flutter_test/flutter_test.dart';
import 'package:vaanisetu/services/mt/indic_preprocessor.dart';
import 'package:vaanisetu/services/mt/bpe_tokenizer.dart';

void main() {
  test('preprocessor handles classroom sentences without throwing', () {
    final pre = IndicPreprocessor();
    const sentences = [
      'बच्चों, अपनी किताब खोलो।',
      'सब बच्चे खड़े हो जाओ।',
      'यह कौन सा रंग है?',
      'पाँच तक गिनो।',
      'मेरा फ़ोन नंबर 91-9876543210 है।',
    ];
    for (final s in sentences) {
      final result = pre.preprocess(s);
      // ignore: avoid_print
      print('IN:  $s');
      // ignore: avoid_print
      print('OUT: "${result.text}" placeholders=${result.placeholders}');
      expect(result.text, isNotEmpty);
    }
  });

  test('BPE tokenizer round-trips a simple vocab', () {
    final tok = BpeTokenizer.fromJson({
      'model': {
        'type': 'BPE',
        'unk_token': '<unk>',
        'vocab': {
          '<unk>': 0,
          '▁': 1,
          'क': 2,
          'ा': 3,
          '▁क': 4,
          'का': 5,
          '▁का': 6,
        },
        'merges': [
          ['▁', 'क'],
          ['क', 'ा'],
          ['▁क', 'ा'],
        ],
      },
    });
    final ids = tok.encode('का');
    expect(ids, isNotEmpty);
    final decoded = tok.decode(ids);
    expect(decoded, 'का');
  });
}

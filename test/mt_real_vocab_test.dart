import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vaanisetu/services/mt/bpe_tokenizer.dart';
import 'package:vaanisetu/services/mt/indic_preprocessor.dart';

void main() {
  test('BPE tokenizer round-trips real classroom sentences against the actual vocab', () {
    final srcJson = jsonDecode(
      File('assets/models/mt/tokenizer_src.json').readAsStringSync(),
    ) as Map<String, dynamic>;
    final tokenizer = BpeTokenizer.fromJson(srcJson);
    final pre = IndicPreprocessor();

    expect(tokenizer.vocab['hin_Deva'], 8);
    expect(tokenizer.vocab['sat_Olck'], 29925);
    expect(tokenizer.vocab['</s>'], 2);

    const sentences = [
      'बच्चों, अपनी किताब खोलो।',
      'सब बच्चे खड़े हो जाओ।',
      'अपनी पेंसिल निकालो।',
      'यह कौन सा रंग है?',
      'पाँच तक गिनो।',
      'अपना नाम लिखो।',
      'बोर्ड की तरफ देखो।',
      'आज हम एक कहानी पढ़ेंगे।',
    ];

    for (final sentence in sentences) {
      final processed = pre.preprocess(sentence).text;
      final ids = tokenizer.encode(processed);
      expect(ids, isNotEmpty);
      for (final id in ids) {
        expect(id, lessThan(tokenizer.vocab.length + 10));
      }
      final decoded = tokenizer.decode(ids);
      // ignore: avoid_print
      print('sentence : $sentence');
      // ignore: avoid_print
      print('processed: $processed');
      // ignore: avoid_print
      print('ids      : $ids');
      // ignore: avoid_print
      print('decoded  : $decoded');
      // ignore: avoid_print
      print('');
      expect(decoded, processed);
    }
  });
}

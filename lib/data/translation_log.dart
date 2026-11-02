/// One saved translation: both sides' text plus when it happened, as read
/// back from [TranslationHistoryService]'s on-device database.
class TranslationLog {
  const TranslationLog({
    required this.id,
    required this.timestamp,
    required this.sourceLanguageCode,
    required this.sourceLanguageName,
    required this.targetLanguageCode,
    required this.targetLanguageName,
    required this.sourceText,
    required this.targetText,
  });

  final int id;
  final DateTime timestamp;
  final String sourceLanguageCode;
  final String sourceLanguageName;
  final String targetLanguageCode;
  final String targetLanguageName;
  final String sourceText;
  final String targetText;

  factory TranslationLog.fromMap(Map<String, Object?> map) {
    return TranslationLog(
      id: map['id']! as int,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']! as int),
      sourceLanguageCode: map['source_lang_code']! as String,
      sourceLanguageName: map['source_lang_name']! as String,
      targetLanguageCode: map['target_lang_code']! as String,
      targetLanguageName: map['target_lang_name']! as String,
      sourceText: map['source_text']! as String,
      targetText: map['target_text']! as String,
    );
  }
}

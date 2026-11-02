import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../data/translation_log.dart';

/// On-device (SQLite, via sqflite) log of every completed translation —
/// timestamp plus both languages' text. Purely local: nothing here ever
/// leaves the phone.
///
/// Logging failures (e.g. running on a platform sqflite doesn't support)
/// are swallowed rather than thrown — a teacher mid-lesson should never see
/// the translate flow break because history-keeping hit a snag.
class TranslationHistoryService {
  TranslationHistoryService._();

  static final instance = TranslationHistoryService._();

  static const _table = 'translation_logs';

  Database? _db;
  Future<Database>? _opening;

  Future<Database> _database() {
    final existing = _db;
    if (existing != null) return Future.value(existing);
    // Concurrent callers (a translate firing while history is still being
    // read) must share one open() call, not race to open the file twice.
    return _opening ??= _open().then((db) {
      _db = db;
      return db;
    });
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/translation_history.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE $_table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timestamp INTEGER NOT NULL,
          source_lang_code TEXT NOT NULL,
          source_lang_name TEXT NOT NULL,
          target_lang_code TEXT NOT NULL,
          target_lang_name TEXT NOT NULL,
          source_text TEXT NOT NULL,
          target_text TEXT NOT NULL
        )
      '''),
    );
  }

  Future<void> add({
    required String sourceLanguageCode,
    required String sourceLanguageName,
    required String targetLanguageCode,
    required String targetLanguageName,
    required String sourceText,
    required String targetText,
  }) async {
    try {
      final db = await _database();
      await db.insert(_table, {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'source_lang_code': sourceLanguageCode,
        'source_lang_name': sourceLanguageName,
        'target_lang_code': targetLanguageCode,
        'target_lang_name': targetLanguageName,
        'source_text': sourceText,
        'target_text': targetText,
      });
    } catch (e) {
      debugPrint('TranslationHistoryService: failed to log translation: $e');
    }
  }

  Future<List<TranslationLog>> getAll() async {
    final db = await _database();
    final rows = await db.query(_table, orderBy: 'timestamp DESC');
    return rows.map(TranslationLog.fromMap).toList();
  }

  Future<void> delete(int id) async {
    final db = await _database();
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAll() async {
    final db = await _database();
    await db.delete(_table);
  }
}

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../data/translation_log.dart';
import '../l10n/app_strings.dart';
import '../services/inference_isolate.dart';
import '../services/translation_history_service.dart';
import '../theme/app_colors.dart';

/// Every completed translation, newest first, read from the on-device
/// SQLite log ([TranslationHistoryService]). Each entry can be deleted on
/// its own, or the whole history cleared in one go — both destructive, so
/// both confirm first.
class TranslationHistoryScreen extends StatefulWidget {
  const TranslationHistoryScreen({super.key});

  @override
  State<TranslationHistoryScreen> createState() =>
      _TranslationHistoryScreenState();
}

class _TranslationHistoryScreenState extends State<TranslationHistoryScreen> {
  late Future<List<TranslationLog>> _future;
  final _hindiTts = FlutterTts();
  final _audioPlayer = AudioPlayer();

  /// id of the entry currently being spoken, or null. Only one card can
  /// play at a time — a second tap while this is set is ignored.
  int? _speakingId;

  @override
  void initState() {
    super.initState();
    _future = TranslationHistoryService.instance.getAll();
    _hindiTts.setLanguage('hi-IN');
    _hindiTts.awaitSpeakCompletion(true);
  }

  @override
  void dispose() {
    _hindiTts.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _reload() {
    setState(() => _future = TranslationHistoryService.instance.getAll());
  }

  /// Speaks a saved entry's Hindi text, then its Santhali text, one after
  /// the other — Hindi via the system TTS voice, Santhali via the offline
  /// Piper model (see [InferenceIsolate.speakSantali]).
  Future<void> _speakEntry(TranslationLog log) async {
    if (_speakingId != null) return;
    final hindiText = log.sourceLanguageCode == 'hi'
        ? log.sourceText
        : log.targetLanguageCode == 'hi'
        ? log.targetText
        : null;
    final santaliText = log.sourceLanguageCode == 'sat'
        ? log.sourceText
        : log.targetLanguageCode == 'sat'
        ? log.targetText
        : null;
    if (hindiText == null && santaliText == null) return;

    setState(() => _speakingId = log.id);
    try {
      if (hindiText != null && hindiText.isNotEmpty) {
        try {
          await _hindiTts.speak(hindiText);
        } catch (e) {
          if (mounted) {
            _showError(tr(context, 'could_not_play_audio_hindi', {'error': '$e'}));
          }
        }
      }
      if (santaliText != null && santaliText.isNotEmpty) {
        try {
          final wavBytes = await InferenceIsolate.instance.speakSantali(
            santaliText,
          );
          final completer = Completer<void>();
          final sub = _audioPlayer.onPlayerComplete.listen((_) {
            if (!completer.isCompleted) completer.complete();
          });
          await _audioPlayer.play(BytesSource(wavBytes, mimeType: 'audio/wav'));
          await completer.future;
          await sub.cancel();
        } catch (e) {
          if (mounted) {
            _showError(tr(context, 'could_not_play_audio', {'error': '$e'}));
          }
        }
      }
    } finally {
      if (mounted) setState(() => _speakingId = null);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _deleteOne(TranslationLog log) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr(context, 'history_delete_title')),
        content: Text(tr(context, 'history_delete_body')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(tr(context, 'cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              tr(context, 'delete'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await TranslationHistoryService.instance.delete(log.id);
    if (!mounted) return;
    _reload();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr(context, 'history_entry_deleted')),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _clearAll(int count) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr(context, 'history_clear_all_title')),
        content: Text(tr(context, 'history_clear_all_body', {'n': '$count'})),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(tr(context, 'cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              tr(context, 'delete'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await TranslationHistoryService.instance.clearAll();
    if (!mounted) return;
    _reload();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr(context, 'history_all_cleared')),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: Text(tr(context, 'history_title')),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        actions: [
          FutureBuilder<List<TranslationLog>>(
            future: _future,
            builder: (context, snapshot) {
              final logs = snapshot.data;
              if (logs == null || logs.isEmpty) return const SizedBox();
              return IconButton(
                icon: const Icon(Icons.delete_sweep_outlined),
                tooltip: tr(context, 'history_clear_all'),
                onPressed: () => _clearAll(logs.length),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<TranslationLog>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final logs = snapshot.data!;
            if (logs.isEmpty) return _EmptyState();
            return ListView.separated(
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                16 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: logs.length,
              separatorBuilder: (context, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _HistoryCard(
                log: logs[index],
                onDelete: _deleteOne,
                onSpeak: _speakEntry,
                speaking: _speakingId == logs[index].id,
                speakDisabled: _speakingId != null,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.history_rounded,
              size: 56,
              color: AppColors.navy.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 16),
            Text(
              tr(context, 'history_empty_title'),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tr(context, 'history_empty_subtitle'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.log,
    required this.onDelete,
    required this.onSpeak,
    required this.speaking,
    required this.speakDisabled,
  });

  final TranslationLog log;
  final ValueChanged<TranslationLog> onDelete;
  final ValueChanged<TranslationLog> onSpeak;
  final bool speaking;
  final bool speakDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E8EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _formatTimestamp(log.timestamp),
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ),
              InkResponse(
                onTap: speakDisabled ? null : () => onSpeak(log),
                radius: 18,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: speaking
                      ? const SizedBox(
                          width: 19,
                          height: 19,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.teal,
                          ),
                        )
                      : Icon(
                          Icons.volume_up_rounded,
                          size: 19,
                          color: speakDisabled
                              ? Colors.grey[300]
                              : AppColors.teal,
                        ),
                ),
              ),
              const SizedBox(width: 14),
              InkResponse(
                onTap: () => onDelete(log),
                radius: 18,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    size: 19,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _LangLine(
            languageName: log.sourceLanguageName,
            color: AppColors.navy,
            text: log.sourceText,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Icon(
              Icons.arrow_downward_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ),
          _LangLine(
            languageName: log.targetLanguageName,
            color: AppColors.teal,
            text: log.targetText,
          ),
        ],
      ),
    );
  }
}

class _LangLine extends StatelessWidget {
  const _LangLine({
    required this.languageName,
    required this.color,
    required this.text,
  });

  final String languageName;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageName.toUpperCase(),
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
            color: color,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF14213D),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

String _formatTimestamp(DateTime t) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final hour24 = t.hour;
  final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  final minute = t.minute.toString().padLeft(2, '0');
  final period = hour24 < 12 ? 'AM' : 'PM';
  return '${t.day} ${months[t.month - 1]} ${t.year}, $hour12:$minute $period';
}

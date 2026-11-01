import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../data/dictionary_data.dart';
import '../l10n/app_strings.dart';
import '../services/tts/santali_tts_service.dart';
import '../theme/app_colors.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final _searchController = TextEditingController();
  final _audioPlayer = AudioPlayer();
  String _query = '';
  String? _speakingSantali;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  List<DictionaryEntry> get _filtered {
    if (_query.isEmpty) return dictionaryData;
    return dictionaryData.where((e) {
      return e.hindi.contains(_query) ||
          e.gloss.toLowerCase().contains(_query) ||
          e.santali.contains(_query);
    }).toList();
  }

  Future<void> _speak(DictionaryEntry entry) async {
    if (_speakingSantali == entry.santali) return;
    setState(() => _speakingSantali = entry.santali);
    try {
      final wav = await SantaliTtsService.instance.synthesizeWav(entry.santali);
      await _audioPlayer.play(BytesSource(wav, mimeType: 'audio/wav'));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr(context, 'could_not_play_audio', {'error': '$e'})),
            backgroundColor: AppColors.navy,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _speakingSantali = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = _filtered;
    final grouped = <String, List<DictionaryEntry>>{};
    for (final entry in entries) {
      grouped.putIfAbsent(entry.category, () => []).add(entry);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: Text(
          tr(context, 'dictionary_title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: tr(context, 'dictionary_search_hint'),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: AppColors.navy.withValues(alpha: 0.12),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: entries.isEmpty
                ? Center(
                    child: Text(
                      tr(context, 'no_matching_words'),
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      16 + MediaQuery.of(context).padding.bottom,
                    ),
                    children: [
                      for (final category in grouped.keys) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.teal,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        for (final entry in grouped[category]!)
                          _DictionaryTile(
                            entry: entry,
                            speaking: _speakingSantali == entry.santali,
                            onSpeak: () => _speak(entry),
                          ),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _DictionaryTile extends StatelessWidget {
  const _DictionaryTile({
    required this.entry,
    required this.speaking,
    required this.onSpeak,
  });

  final DictionaryEntry entry;
  final bool speaking;
  final VoidCallback onSpeak;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.navy.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.hindi,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.gloss,
                  style: TextStyle(fontSize: 12.5, color: Colors.grey[600]),
                ),
                const SizedBox(height: 6),
                Text(
                  entry.santali,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.teal,
                  ),
                ),
              ],
            ),
          ),
          speaking
              ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.volume_up_rounded),
                  color: AppColors.teal,
                  onPressed: onSpeak,
                  tooltip: 'Speak',
                ),
        ],
      ),
    );
  }
}

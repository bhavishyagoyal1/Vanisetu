import 'dart:async';

import 'package:flutter/material.dart';

import '../data/translation_languages.dart';
import '../services/hindi_asr_service.dart';
import '../services/mt/hindi_santali_mt_service.dart';
import '../theme/app_colors.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  static final TranslateLanguage _hindi =
      translateLanguages.firstWhere((lang) => lang.code == 'hi');
  static final List<TranslateLanguage> _targetOptions = translateLanguages
      .where((lang) => lang.code == 'sat' || lang.code == 'unr')
      .toList();

  late TranslateLanguage _targetLang = _targetOptions.first; // Santhali

  final _sourceController = TextEditingController();
  String? _targetText;

  bool _listening = false;
  bool _starting = false;
  bool _translating = false;

  Timer? _elapsedTimer;
  Duration _elapsed = Duration.zero;

  @override
  void dispose() {
    _elapsedTimer?.cancel();
    if (HindiAsrService.instance.isListening) {
      HindiAsrService.instance.stopListening();
    }
    _sourceController.dispose();
    super.dispose();
  }

  void _startElapsedTimer() {
    _elapsed = Duration.zero;
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _elapsed += const Duration(seconds: 1));
    });
  }

  void _stopElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }

  String _formatElapsed(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _pickTargetLanguage() async {
    final selected = await showModalBottomSheet<TranslateLanguage>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Select a language',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              for (final lang in _targetOptions)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: lang.color,
                    child: Text(
                      lang.badge,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  title: Text(lang.name),
                  onTap: () => Navigator.of(context).pop(lang),
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (selected == null) return;
    setState(() => _targetLang = selected);
  }

  Future<void> _translate() async {
    final text = _sourceController.text.trim();
    if (text.isEmpty || _translating) return;

    if (_targetLang.code != 'sat') {
      // Only Hindi -> Santali has an offline MT model bundled; other
      // targets (e.g. Mundari) aren't in this model's supported language
      // list, so be explicit rather than silently mistranslating.
      setState(() => _targetText = null);
      _showError(
        'Hindi → ${_targetLang.name} isn\'t supported yet — only Santali translation is available offline.',
      );
      return;
    }

    setState(() {
      _translating = true;
      _targetText = null;
    });
    try {
      final result = await HindiSantaliMtService.instance.translate(text);
      if (!mounted) return;
      setState(() => _targetText = result);
    } catch (e) {
      if (!mounted) return;
      _showError('Translation failed: $e');
    } finally {
      if (mounted) setState(() => _translating = false);
    }
  }

  void _setSourceText(String text) {
    _sourceController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.navy,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _toggleMic() async {
    try {
      if (_listening) {
        _stopElapsedTimer();
        final finalText = await HindiAsrService.instance.stopListening();
        if (!mounted) return;
        setState(() {
          _listening = false;
          if (finalText != null && finalText.isNotEmpty) {
            _setSourceText(finalText);
          }
        });
        return;
      }

      setState(() => _starting = true);
      await HindiAsrService.instance.startListening(
        onPartial: (partial) {
          if (!mounted) return;
          setState(() => _setSourceText(partial));
        },
        onError: (message) {
          _stopElapsedTimer();
          if (!mounted) return;
          setState(() {
            _listening = false;
            _starting = false;
          });
          _showError(message);
        },
      );
      if (!mounted) return;
      final started = HindiAsrService.instance.isListening;
      setState(() {
        _starting = false;
        _listening = started;
      });
      if (started) _startElapsedTimer();
    } catch (e) {
      _stopElapsedTimer();
      if (!mounted) return;
      setState(() {
        _starting = false;
        _listening = false;
      });
      _showError('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('Translate', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: _LanguagePane(
                  language: _hindi,
                  controller: _sourceController,
                  editable: true,
                  hint: 'Type or tap the mic to speak in ${_hindi.name}…',
                  trailing: _translating
                      ? const Padding(
                          padding: EdgeInsets.all(10),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.send_rounded, color: AppColors.navy),
                          onPressed: _translate,
                          tooltip: 'Translate',
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _LanguagePane(
                  language: _targetLang,
                  editable: false,
                  displayText: _targetText,
                  hint: _translating
                      ? 'Translating…'
                      : 'Translation will appear here',
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _LanguagePill(language: _hindi, onTap: null),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward, color: AppColors.teal),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _LanguagePill(
                      language: _targetLang,
                      onTap: _pickTargetLanguage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _MicButton(
                listening: _listening,
                loading: _starting,
                color: _hindi.color,
                onTap: _starting ? null : _toggleMic,
              ),
              if (_starting)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Loading speech model…',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ),
              if (_listening)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.fiber_manual_record, color: _hindi.color, size: 12),
                      const SizedBox(width: 6),
                      Text(
                        _formatElapsed(_elapsed),
                        style: TextStyle(
                          color: _hindi.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguagePane extends StatelessWidget {
  const _LanguagePane({
    required this.language,
    required this.editable,
    required this.hint,
    this.controller,
    this.displayText,
    this.trailing,
  });

  final TranslateLanguage language;
  final bool editable;
  final String hint;
  final TextEditingController? controller;
  final String? displayText;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: language.color.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: language.color,
                child: Text(
                  language.badge,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                language.name,
                style: TextStyle(
                  color: language.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              ?trailing,
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: editable
                ? TextField(
                    controller: controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                    style: const TextStyle(fontSize: 16),
                  )
                : Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      displayText ?? hint,
                      style: TextStyle(
                        fontSize: 16,
                        color: displayText == null ? Colors.grey[400] : Colors.black87,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _LanguagePill extends StatelessWidget {
  const _LanguagePill({required this.language, required this.onTap});

  final TranslateLanguage language;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: language.color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: language.color,
                child: Text(
                  language.badge,
                  style: const TextStyle(color: Colors.white, fontSize: 9),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  language.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: language.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onTap != null)
                Icon(Icons.expand_more, color: language.color, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({
    required this.listening,
    required this.color,
    required this.onTap,
    this.loading = false,
  });

  final bool listening;
  final bool loading;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: listening ? color : color.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: listening ? 0.45 : 0.25),
              blurRadius: listening ? 18 : 10,
              spreadRadius: listening ? 3 : 0,
            ),
          ],
        ),
        child: loading
            ? const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Icon(
                listening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
                size: 26,
              ),
      ),
    );
  }
}

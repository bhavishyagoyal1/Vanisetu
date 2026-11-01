import 'dart:async';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_tts/flutter_tts.dart';

import '../data/translation_languages.dart';
import '../l10n/app_strings.dart';
import '../services/asr/hindi_text_normalizer.dart' show isHallucinated;
import '../services/hindi_asr_service.dart';
import '../services/inference_isolate.dart';
import '../theme/app_colors.dart';
import 'settings_screen.dart';

/// Vaani Translate — the app's landing tab. Hindi in, Santali (and, once an
/// offline model exists for it, Mundari) out — live, as you speak or type.
class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  static final TranslateLanguage _hindi = translateLanguages.firstWhere(
    (lang) => lang.code == 'hi',
  );
  static final List<TranslateLanguage> _targetOptions = translateLanguages
      .where((lang) => lang.code == 'sat' || lang.code == 'unr')
      .toList();

  late TranslateLanguage _targetLang = _targetOptions.first; // Santhali

  // true: Hindi (top, mic-enabled) -> _targetLang (bottom, picker) — the
  // original direction. false: _targetLang (top, no mic — no Santali ASR
  // exists) -> Hindi (bottom, fixed) — the reverse direction, only ever
  // entered with _targetLang == Santali (see _canSwap): Mundari has no
  // working model in either direction, so there is nothing to swap to.
  bool _sourceIsHindi = true;

  final _sourceController = TextEditingController();
  String? _targetText;

  bool _listening = false;
  bool _starting = false;
  bool _translating = false;
  bool _retranslatePending = false;
  bool _speaking = false;
  bool _speakingHindi = false;
  bool _copiedSource = false;

  Timer? _elapsedTimer;
  Duration _elapsed = Duration.zero;
  Timer? _translateDebounce;
  final _audioPlayer = AudioPlayer();
  final _hindiTts = FlutterTts();

  static const _liveTranslateDelay = Duration(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _sourceController.addListener(_onSourceChanged);
    // Hindi has broad support in Android's built-in TTS engines (unlike
    // Santali, which needs the bundled Piper model), so no on-device model
    // is bundled for it — just point the system engine at the language.
    _hindiTts.setLanguage('hi-IN');
  }

  @override
  void dispose() {
    _translateDebounce?.cancel();
    _elapsedTimer?.cancel();
    _sourceController.removeListener(_onSourceChanged);
    if (HindiAsrService.instance.isListening) {
      HindiAsrService.instance.stopListening();
    }
    _sourceController.dispose();
    _hindiTts.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Live translation: debounced so a full decode pass doesn't fire on every
  /// keystroke or every mid-speech partial rewrite. This fires during an
  /// active recording too — real-time translation is the point — but the
  /// live ASR partial is never hallucination-gated the way
  /// HindiAsrService.stopListening's committed transcript is, so _translate
  /// re-checks isHallucinated on whatever text is about to be sent, live or
  /// not, before it ever reaches the model.
  void _onSourceChanged() => _scheduleTranslate();

  void _scheduleTranslate({Duration delay = _liveTranslateDelay}) {
    _translateDebounce?.cancel();
    if (_sourceController.text.trim().isEmpty) {
      if (_targetText != null) setState(() => _targetText = null);
      return;
    }
    _translateDebounce = Timer(delay, _translate);
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  tr(context, 'select_a_language'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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

    if (selected == null || selected.code == _targetLang.code) return;
    setState(() {
      _targetLang = selected;
      _targetText = null;
    });
    _scheduleTranslate(delay: Duration.zero);
  }

  Future<void> _translate() async {
    final text = _sourceController.text.trim();
    if (text.isEmpty) return;

    // The live ASR partial mid-recording is never hallucination-gated the
    // way HindiAsrService.stopListening's committed transcript is (see its
    // doc comment) — re-check here so a silence-hallucinated partial
    // ("क क क क") never reaches the model, live or not. Leaves whatever
    // translation is already showing in place rather than clearing it.
    if (isHallucinated(text)) return;

    // A translate() call is a full autoregressive decode, not cheap enough
    // to run concurrently with itself — coalesce anything that arrives
    // mid-flight into exactly one more run once this one finishes, rather
    // than overlapping calls on the shared ONNX sessions.
    if (_translating) {
      _retranslatePending = true;
      return;
    }

    if (_sourceIsHindi && _targetLang.code != 'sat') {
      // Only Hindi <-> Santali has an offline MT model bundled; Mundari
      // isn't in this model's supported language list yet — reflected
      // inline in the target card's hint.
      setState(() => _targetText = null);
      return;
    }

    setState(() {
      _translating = true;
      _targetText = null;
    });
    try {
      final result = _sourceIsHindi
          ? await InferenceIsolate.instance.translateToSantali(text)
          : await InferenceIsolate.instance.translateToHindi(text);
      if (!mounted) return;
      setState(() => _targetText = result);
    } catch (e) {
      if (!mounted) return;
      _showError(tr(context, 'translation_failed', {'error': '$e'}));
    } finally {
      if (mounted) setState(() => _translating = false);
      if (_retranslatePending) {
        _retranslatePending = false;
        _scheduleTranslate(delay: Duration.zero);
      }
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

  Future<void> _copy(String text) async {
    if (text.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr(context, 'copied_to_clipboard')),
        backgroundColor: AppColors.teal,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _copySource() async {
    setState(() => _copiedSource = true);
    await _copy(_sourceController.text.trim());
    if (mounted) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) setState(() => _copiedSource = false);
      });
    }
  }

  /// Speaks Santali text aloud via the offline Piper TTS model.
  Future<void> _speakSantali(String text) async {
    if (text.isEmpty || _speaking) return;
    setState(() => _speaking = true);
    try {
      final wavBytes = await InferenceIsolate.instance.speakSantali(text);
      if (!mounted) return;
      await _audioPlayer.play(BytesSource(wavBytes, mimeType: 'audio/wav'));
    } catch (e) {
      if (mounted) {
        _showError(tr(context, 'could_not_play_audio', {'error': '$e'}));
      }
    } finally {
      if (mounted) setState(() => _speaking = false);
    }
  }

  /// Speaks Hindi text aloud via Android's built-in TTS engine.
  ///
  /// The bundled offline Piper voice (`HindiTtsService`, espeak-ng
  /// phonemization via `piper_phonemize`) is NOT used here — on-device
  /// testing found it reliably crashes the whole app the first time it
  /// runs, not just throws: a native `SIGABRT` ("FORTIFY: pthread_mutex_lock
  /// called on a destroyed mutex") inside `libflutter.so`, confirmed via two
  /// separate `/data/tombstones` captures with an identical stack. Being a
  /// native abort, it kills the process outright and bypasses Dart's
  /// try/catch entirely, so the fallback this function used to have after
  /// that call could never actually run. It reproduced identically whether
  /// espeak-ng's data was pre-extracted on the main isolate first or not,
  /// which rules out the isolate-messenger race that seemed like the
  /// obvious cause — root cause is still open, most likely a native
  /// conflict between `piper_phonemize`/espeak-ng and `onnxruntime` (both
  /// FFI, both pull in `libc++_shared.so`). Needs upstream investigation
  /// before it's safe to call again; system TTS already has solid Hindi
  /// support on Android, so this is a real fallback, not a downgrade in
  /// practice.
  Future<void> _speakHindi(String text) async {
    if (text.isEmpty || _speakingHindi) return;
    setState(() => _speakingHindi = true);
    try {
      await _hindiTts.speak(text);
    } catch (e) {
      if (mounted) {
        _showError(tr(context, 'could_not_play_audio_hindi', {'error': '$e'}));
      }
    } finally {
      if (mounted) setState(() => _speakingHindi = false);
    }
  }

  /// Speaks whatever is in the source box, in whichever language is
  /// currently assigned there.
  Future<void> _speakSource() {
    final text = _sourceController.text.trim();
    return _sourceIsHindi ? _speakHindi(text) : _speakSantali(text);
  }

  /// Speaks the translated output, in whichever language is currently
  /// assigned to the target box. Useful both for a Hindi-speaking teacher
  /// to hear correct Santali pronunciation, and (once swapped) the reverse.
  Future<void> _speakTarget() {
    final text = _targetText;
    if (text == null) return Future.value();
    return _sourceIsHindi ? _speakSantali(text) : _speakHindi(text);
  }

  /// Swaps translation direction. Like a typical translate app's swap
  /// button: the new source gets the old target's text, and the target is
  /// re-translated from there rather than just moving the old source text
  /// over untranslated. Only ever called while swapping is possible (see
  /// _canSwap) — Mundari has no reverse model, so swapping away from a
  /// Hindi->Mundari selection never happens.
  Future<void> _swapLanguages() async {
    if (_listening) await _toggleMic();
    _translateDebounce?.cancel();
    final oldTarget = _targetText;
    setState(() {
      _sourceIsHindi = !_sourceIsHindi;
      _targetText = null;
      _setSourceText(oldTarget ?? '');
    });
    _scheduleTranslate(delay: Duration.zero);
  }

  bool get _canSwap => !_sourceIsHindi || _targetLang.code == 'sat';

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
        // Translate the settled, hallucination-gated transcript right away
        // rather than waiting out the typing debounce.
        _scheduleTranslate(delay: Duration.zero);
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
      _showError(tr(context, 'unexpected_error', {'error': '$e'}));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAF3FB), Color(0xFFF6F8FA)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const _AppHeader(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: ConstrainedBox(
                        // Center the content vertically when it's shorter
                        // than the available space (the common case)
                        // instead of leaving it stranded at the top with
                        // empty space below; still scrolls normally once
                        // content (or the keyboard) needs more room than
                        // the viewport has.
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _TranslateCard(
                                language: _sourceIsHindi ? _hindi : _targetLang,
                                editable: true,
                                controller: _sourceController,
                                hint: _sourceIsHindi
                                    ? tr(context, 'speak_in_hindi')
                                    : tr(context, 'type_in_santali'),
                                actions: [
                                  _CardIconButton(
                                    icon: Icons.volume_up_rounded,
                                    loading: _sourceIsHindi
                                        ? _speakingHindi
                                        : _speaking,
                                    onTap: _speakSource,
                                  ),
                                  _CardIconButton(
                                    icon: _copiedSource
                                        ? Icons.check_rounded
                                        : Icons.copy_rounded,
                                    onTap: _copySource,
                                  ),
                                ],
                              ),
                              if (_sourceIsHindi) ...[
                                const SizedBox(height: 22),
                                _MicWithWaveform(
                                  listening: _listening,
                                  starting: _starting,
                                  onTap: _starting ? null : _toggleMic,
                                ),
                                if (_starting)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      tr(context, 'loading_speech_model'),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                if (_listening)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.fiber_manual_record,
                                          color: _hindi.color,
                                          size: 12,
                                        ),
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
                              const SizedBox(height: 18),
                              _TranslateToLabel(
                                canSwap: _canSwap,
                                onSwap: _swapLanguages,
                              ),
                              const SizedBox(height: 14),
                              _TranslateCard(
                                language: _sourceIsHindi ? _targetLang : _hindi,
                                editable: false,
                                displayText: _targetText,
                                onHeaderTap: _sourceIsHindi
                                    ? _pickTargetLanguage
                                    : null,
                                minHeight: 220,
                                hint: _translating
                                    ? tr(context, 'translating')
                                    : _sourceIsHindi &&
                                          _targetLang.code != 'sat'
                                    ? tr(context, 'not_available_offline')
                                    : tr(context, 'translation_appears_here'),
                                actions: _targetText == null
                                    ? const []
                                    : [
                                        _CardIconButton(
                                          icon: Icons.volume_up_rounded,
                                          loading: _sourceIsHindi
                                              ? _speaking
                                              : _speakingHindi,
                                          onTap: _speakTarget,
                                        ),
                                        _CardIconButton(
                                          icon: Icons.copy_rounded,
                                          onTap: () => _copy(_targetText ?? ''),
                                        ),
                                      ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small branding header pinned above the translate content — logo + app
/// name, so the landing tab still reads as "VaaniSetu" now that it has no
/// AppBar of its own.
class _AppHeader extends StatelessWidget {
  const _AppHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/app_icon.png',
              width: 32,
              height: 32,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          // Brand name — intentionally not localized, same as any proper noun.
          const Text(
            'VaaniSetu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.navy),
            tooltip: tr(context, 'settings_title'),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
    );
  }
}

class _TranslateToLabel extends StatelessWidget {
  const _TranslateToLabel({required this.canSwap, required this.onSwap});

  final bool canSwap;
  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.teal.withValues(alpha: 0.25),
                ),
              ),
              child: Text(
                tr(context, 'translate_to'),
                style: const TextStyle(
                  color: AppColors.teal,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: canSwap
                  ? tr(context, 'swap_languages')
                  : tr(context, 'swap_unavailable'),
              child: Material(
                color: canSwap
                    ? AppColors.teal.withValues(alpha: 0.12)
                    : Colors.grey.withValues(alpha: 0.1),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: canSwap ? onSwap : null,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.swap_vert_rounded,
                      size: 18,
                      color: canSwap ? AppColors.teal : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Icon(
          Icons.keyboard_double_arrow_down_rounded,
          color: AppColors.teal.withValues(alpha: 0.6),
        ),
      ],
    );
  }
}

class _TranslateCard extends StatelessWidget {
  const _TranslateCard({
    required this.language,
    required this.editable,
    required this.hint,
    required this.actions,
    this.controller,
    this.displayText,
    this.onHeaderTap,
    this.minHeight = 130,
  });

  final TranslateLanguage language;
  final bool editable;
  final String hint;
  final List<Widget> actions;
  final TextEditingController? controller;
  final String? displayText;
  final double minHeight;

  /// When set, the badge+name header becomes tappable (with a chevron) to
  /// switch language — used for the target card's Santali/Mundari picker.
  final VoidCallback? onHeaderTap;

  @override
  Widget build(BuildContext context) {
    final text = displayText;
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: minHeight),
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
              Expanded(
                child: InkWell(
                  onTap: onHeaderTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: language.color,
                        child: Text(
                          language.badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
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
                            fontSize: 13,
                          ),
                        ),
                      ),
                      if (onHeaderTap != null)
                        Icon(
                          Icons.expand_more,
                          color: language.color,
                          size: 18,
                        ),
                    ],
                  ),
                ),
              ),
              for (final action in actions) action,
            ],
          ),
          const SizedBox(height: 8),
          if (editable)
            TextField(
              controller: controller,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none,
                isCollapsed: true,
              ),
              style: const TextStyle(fontSize: 16),
            )
          else
            text == null
                ? Text(
                    hint,
                    style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                  )
                : SelectableText(
                    text,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
        ],
      ),
    );
  }
}

class _CardIconButton extends StatelessWidget {
  const _CardIconButton({
    required this.icon,
    required this.onTap,
    this.loading = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return IconButton(
      icon: Icon(icon, size: 18),
      color: AppColors.navy,
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
    );
  }
}

/// The mic button flanked by an animated waveform on each side — bars pulse
/// while listening (or briefly while the speech model loads), and sit flat
/// when idle.
class _MicWithWaveform extends StatefulWidget {
  const _MicWithWaveform({
    required this.listening,
    required this.starting,
    required this.onTap,
  });

  final bool listening;
  final bool starting;
  final VoidCallback? onTap;

  @override
  State<_MicWithWaveform> createState() => _MicWithWaveformState();
}

class _MicWithWaveformState extends State<_MicWithWaveform>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _active => widget.listening || widget.starting;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Waveform(
          animation: _controller,
          active: _active,
          color: AppColors.navy,
          barCount: 7,
        ),
        const SizedBox(width: 14),
        InkWell(
          borderRadius: BorderRadius.circular(52),
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.listening
                    ? [AppColors.navy, const Color(0xFF2B5CA8)]
                    : [AppColors.navy.withValues(alpha: 0.85), AppColors.navy],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.navy.withValues(
                    alpha: widget.listening ? 0.45 : 0.25,
                  ),
                  blurRadius: widget.listening ? 26 : 14,
                  spreadRadius: widget.listening ? 5 : 0,
                ),
              ],
            ),
            child: widget.starting
                ? const Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Icon(
                    widget.listening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                    size: 40,
                  ),
          ),
        ),
        const SizedBox(width: 14),
        _Waveform(
          animation: _controller,
          active: _active,
          color: AppColors.teal,
          barCount: 7,
        ),
      ],
    );
  }
}

class _Waveform extends StatelessWidget {
  const _Waveform({
    required this.animation,
    required this.active,
    required this.color,
    required this.barCount,
  });

  final Animation<double> animation;
  final bool active;
  final Color color;
  final int barCount;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return SizedBox(
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(barCount, (i) {
              final phase = animation.value * 2 * math.pi + i * 0.9;
              final wave = active ? (math.sin(phase) + 1) / 2 : 0.0;
              final height = active ? 8 + wave * 26 : 6.0;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  width: 4,
                  height: height,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: active ? 0.75 : 0.25),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

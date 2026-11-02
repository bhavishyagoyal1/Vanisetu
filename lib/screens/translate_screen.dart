import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_tts/flutter_tts.dart';

import '../data/classroom_prompts.dart';
import '../data/translation_languages.dart';
import '../l10n/app_language.dart';
import '../l10n/app_language_scope.dart';
import '../l10n/app_strings.dart';
import '../services/asr/hindi_text_normalizer.dart'
    show isHallucinated, transcriptWasCleaned;
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

class _TranslateScreenState extends State<TranslateScreen>
    with AutomaticKeepAliveClientMixin {
  // MainShell's PageView doesn't actually keep offscreen tabs alive on its
  // own despite what its doc comment implies — a tab scrolled far enough
  // from the viewport (e.g. Curriculum <-> Dictionary, two tabs from
  // Translate) falls outside the default scrollable cache extent and gets
  // disposed, so returning to it rebuilt this State from scratch: source
  // text, direction, and any translation already on screen, all gone. This
  // mixin is what the PageView doc comment's claim actually depends on.
  @override
  bool get wantKeepAlive => true;

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

  /// Whether the last committed transcript was materially rewritten on its
  /// way to `hin_Deva`. Drives the "Cleaned ASR" badge, and is cleared as
  /// soon as the text changes for any other reason — a badge that outlived
  /// the transcript it described would be a lie.
  bool _cleanedAsr = false;

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
    if (_sourceController.text.trim().isEmpty) {
      // Deliberately doesn't clear _targetText: the last translation stays
      // on screen (matches the source card's own "keep whatever's there"
      // behavior) rather than blanking out just because the source box is
      // momentarily empty — e.g. mid-edit, or between mic recordings.
      _translateDebounce?.cancel();
      return;
    }
    // Callers that want an immediate translate right now (stopping the mic,
    // swapping languages, picking a target) always cancel-and-fire.
    if (delay == Duration.zero) {
      _translateDebounce?.cancel();
      _translateDebounce = Timer(Duration.zero, _translate);
      return;
    }
    // Throttle, not debounce, for the live-dictation case: onPartial fires
    // far faster than `delay` during continuous speech (every decode step,
    // ~100-300ms), so cancelling and restarting this timer on every partial
    // — the previous behavior — meant it never elapsed until the user
    // paused for a full `delay` or stopped recording, i.e. translation only
    // ever ran after the fact rather than live. Letting an already-pending
    // timer keep counting down instead fires roughly every `delay` during
    // continuous speech; _translate() re-reads the controller's current
    // text when it fires, so this never sends stale text.
    if (_translateDebounce?.isActive ?? false) return;
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
                  trailing: lang.code == _targetLang.code
                      ? const Icon(Icons.check, color: AppColors.teal)
                      : null,
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

    // Deliberately doesn't clear _targetText here: with live translation
    // re-running roughly every _liveTranslateDelay during continuous
    // speech, nulling it at the start of every single run blanked the card
    // back to its "Translating…" hint on every cycle — a constant flicker
    // rather than a stable live view, worse the longer a decode pass takes
    // on slower hardware. The last good translation now stays on screen
    // until a new result (or a genuine context change — target language,
    // swap) replaces it.
    setState(() => _translating = true);
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

  /// Fills the source box from a one-tap classroom prompt and translates it
  /// immediately — the whole point of the chip is skipping the wait.
  void _applyPrompt(ClassroomPrompt prompt) {
    setState(() {
      _cleanedAsr = false;
      _setSourceText(prompt.hindi);
    });
    _scheduleTranslate(delay: Duration.zero);
  }

  Future<void> _showAllPrompts() async {
    final selected = await showModalBottomSheet<ClassroomPrompt>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.92,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    tr(context, 'classroom_prompts'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navy,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: classroomPrompts.length,
                    separatorBuilder: (context, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final prompt = classroomPrompts[index];
                      return Material(
                        color: const Color(0xFFF6F8FA),
                        borderRadius: BorderRadius.circular(14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => Navigator.of(context).pop(prompt),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  prompt.emoji,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    prompt.hindi,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      height: 1.35,
                                    ),
                                  ),
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
            );
          },
        );
      },
    );
    if (selected != null) _applyPrompt(selected);
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
    if (_listening) await _endCapture();
    _translateDebounce?.cancel();
    final oldTarget = _targetText;
    setState(() {
      _sourceIsHindi = !_sourceIsHindi;
      _targetText = null;
      _cleanedAsr = false;
      _setSourceText(oldTarget ?? '');
    });
    _scheduleTranslate(delay: Duration.zero);
  }

  bool get _canSwap => !_sourceIsHindi || _targetLang.code == 'sat';

  /// Tap to start, tap again to stop. The button is disabled while a start
  /// is in flight, so a second tap cannot race the (slow, first-run) model
  /// load and leave the microphone running with nothing able to stop it.
  Future<void> _toggleMic() async {
    if (_listening) {
      await _endCapture();
      return;
    }
    await _beginCapture();
  }

  Future<void> _beginCapture() async {
    if (!_sourceIsHindi || _starting || _listening) return;
    try {
      setState(() {
        _starting = true;
        _cleanedAsr = false;
      });
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
      final started = HindiAsrService.instance.isListening;
      if (!mounted) return;
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

  Future<void> _endCapture() async {
    try {
      _stopElapsedTimer();
      final finalText = await HindiAsrService.instance.stopListening();
      final raw = HindiAsrService.instance.lastRawTranscript;
      if (!mounted) return;
      setState(() {
        _listening = false;
        if (finalText != null && finalText.isNotEmpty) {
          _setSourceText(finalText);
          _cleanedAsr = raw != null && transcriptWasCleaned(raw);
        }
      });
      // Translate the settled, hallucination-gated transcript right away
      // rather than waiting out the typing debounce.
      _scheduleTranslate(delay: Duration.zero);
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
    super.build(context); // required by AutomaticKeepAliveClientMixin
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF7F9FC), Color(0xFFF2F5F9)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final m = _Metrics.of(constraints.maxWidth);
              return Center(
                child: ConstrainedBox(
                  // Phone-shaped column even on a tablet: stretching these
                  // cards to 800px would put the mic miles from the text it
                  // belongs to.
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(m.pad, 10, m.pad, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _AppHeader(metrics: m),
                        SizedBox(height: m.gap),
                        _LanguageBar(
                          source: _sourceIsHindi ? _hindi : _targetLang,
                          target: _sourceIsHindi ? _targetLang : _hindi,
                          sourceHasAsr: _sourceIsHindi,
                          canSwap: _canSwap,
                          onSwap: _swapLanguages,
                          onPickTarget: _sourceIsHindi
                              ? _pickTargetLanguage
                              : null,
                          metrics: m,
                        ),
                        SizedBox(height: m.gap),
                        _SourceCard(
                          language: _sourceIsHindi ? _hindi : _targetLang,
                          controller: _sourceController,
                          hint: _sourceIsHindi
                              ? tr(context, 'speak_in_hindi')
                              : tr(context, 'type_in_santali'),
                          cleaned: _cleanedAsr,
                          speaking: _sourceIsHindi ? _speakingHindi : _speaking,
                          copied: _copiedSource,
                          onSpeak: _speakSource,
                          onCopy: _copySource,
                          metrics: m,
                        ),
                        if (_sourceIsHindi) ...[
                          SizedBox(height: m.gap),
                          _PromptStrip(
                            onSelected: _applyPrompt,
                            onViewAll: _showAllPrompts,
                          ),
                          SizedBox(height: m.gap),
                          _MicButton(
                            listening: _listening,
                            starting: _starting,
                            elapsedLabel: _formatElapsed(_elapsed),
                            onTap: _starting ? null : _toggleMic,
                            metrics: m,
                          ),
                        ],
                        SizedBox(height: m.gap),
                        _TargetCard(
                          language: _sourceIsHindi ? _targetLang : _hindi,
                          text: _targetText,
                          translating: _translating,
                          speaking: _sourceIsHindi ? _speaking : _speakingHindi,
                          hint: _translating
                              ? tr(context, 'translating')
                              : _sourceIsHindi && _targetLang.code != 'sat'
                              ? tr(context, 'not_available_offline')
                              : tr(context, 'translation_appears_here'),
                          onSpeak: _speakTarget,
                          onCopy: () => _copy(_targetText ?? ''),
                          metrics: m,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Size steps for the three widths this app actually meets: a cheap small
/// phone, an ordinary phone, and the classroom tablet. Everything that
/// needed to change between them lives here rather than in scattered
/// `width < 360 ? a : b` conditionals.
class _Metrics {
  const _Metrics({
    required this.pad,
    required this.gap,
    required this.mic,
    required this.title,
    required this.body,
    required this.target,
  });

  final double pad;
  final double gap;
  final double mic;
  final double title;
  final double body;
  final double target;

  static const _compact = _Metrics(
    pad: 12,
    gap: 10,
    mic: 78,
    title: 16,
    body: 15,
    target: 19,
  );
  static const _regular = _Metrics(
    pad: 16,
    gap: 12,
    mic: 96,
    title: 18,
    body: 16.5,
    target: 22,
  );
  static const _large = _Metrics(
    pad: 22,
    gap: 16,
    mic: 112,
    title: 20,
    body: 18,
    target: 25,
  );

  factory _Metrics.of(double width) {
    if (width < 360) return _compact;
    if (width < 600) return _regular;
    return _large;
  }
}

/// Brand row: icon, name, the offline guarantee, who is holding the tablet,
/// and settings.
class _AppHeader extends StatelessWidget {
  const _AppHeader({required this.metrics});

  final _Metrics metrics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset('assets/images/app_icon.png', fit: BoxFit.cover),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Brand name — intentionally not localized, like any
                  // proper noun.
                  Flexible(
                    child: Text(
                      'VaaniSetu',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: metrics.title,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navy,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'वाणीसेतु',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: metrics.title - 5,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const _LanguageToggle(),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: AppColors.navy),
          tooltip: tr(context, 'settings_title'),
          visualDensity: VisualDensity.compact,
          onPressed: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
        ),
      ],
    );
  }
}

/// Interface-language switch: English or Hindi, one tap, from the screen the
/// teacher is already on. This is the app's own display language — nothing to
/// do with the source/target languages being translated below it.
class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    final controller = AppLanguageScope.of(context);
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF2F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final language in AppLanguage.values)
            _LanguageSegment(
              // Not the 'हिं' short form: that is already the Hindi badge in
              // the language bar below, and two identical chips on one
              // screen would read as the same control.
              label: language == AppLanguage.english ? 'EN' : 'हिंदी',
              selected: controller.value == language,
              onTap: () => controller.setLanguage(language),
            ),
        ],
      ),
    );
  }
}

class _LanguageSegment extends StatelessWidget {
  const _LanguageSegment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.navy : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}

/// Source language, swap, target language — the one row that says what is
/// being translated into what.
class _LanguageBar extends StatelessWidget {
  const _LanguageBar({
    required this.source,
    required this.target,
    required this.sourceHasAsr,
    required this.canSwap,
    required this.onSwap,
    required this.onPickTarget,
    required this.metrics,
  });

  final TranslateLanguage source;
  final TranslateLanguage target;
  final bool sourceHasAsr;
  final bool canSwap;
  final VoidCallback onSwap;
  final VoidCallback? onPickTarget;
  final _Metrics metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: _LanguageFace(
              language: source,
              caption: sourceHasAsr
                  ? tr(context, 'speech_in_asr')
                  : _scriptOf(source),
              captionIsLive: sourceHasAsr,
            ),
          ),
          Tooltip(
            message: canSwap
                ? tr(context, 'swap_languages')
                : tr(context, 'swap_unavailable'),
            child: Material(
              color: canSwap
                  ? AppColors.navy.withValues(alpha: 0.07)
                  : Colors.grey.withValues(alpha: 0.08),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: canSwap ? onSwap : null,
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Icon(
                    Icons.swap_horiz_rounded,
                    size: 20,
                    color: canSwap ? AppColors.navy : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onPickTarget,
              child: _LanguageFace(
                language: target,
                caption: _scriptOf(target),
                captionIsLive: false,
                alignEnd: true,
                showChevron: onPickTarget != null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The writing system a language is shown in. Factual, and the honest
/// stand-in for an endonym this project has no verified spelling for.
String _scriptOf(TranslateLanguage language) {
  switch (language.code) {
    case 'hi':
      return 'Devanagari';
    case 'sat':
      return 'Ol Chiki';
    default:
      return language.name;
  }
}

class _LanguageFace extends StatelessWidget {
  const _LanguageFace({
    required this.language,
    required this.caption,
    required this.captionIsLive,
    this.alignEnd = false,
    this.showChevron = false,
  });

  final TranslateLanguage language;
  final String caption;
  final bool captionIsLive;
  final bool alignEnd;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final badge = Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: language.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        language.badge,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    final text = Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                language.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: language.color,
                ),
              ),
            ),
            if (showChevron)
              Icon(Icons.expand_more_rounded, size: 18, color: language.color),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (captionIsLive) ...[
              const _Dot(color: AppColors.teal, size: 5),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Text(
                caption,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11.5, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ],
    );

    return Row(
      mainAxisAlignment: alignEnd
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: alignEnd
          ? [Flexible(child: text), const SizedBox(width: 8), badge]
          : [badge, const SizedBox(width: 8), Flexible(child: text)],
    );
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({
    required this.language,
    required this.controller,
    required this.hint,
    required this.cleaned,
    required this.speaking,
    required this.copied,
    required this.onSpeak,
    required this.onCopy,
    required this.metrics,
  });

  final TranslateLanguage language;
  final TextEditingController controller;
  final String hint;
  final bool cleaned;
  final bool speaking;
  final bool copied;
  final VoidCallback onSpeak;
  final VoidCallback onCopy;
  final _Metrics metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(metrics.pad),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: _SectionPill(
                  label:
                      '${tr(context, 'source_label')} • '
                      '${language.name.toUpperCase()}',
                  background: const Color(0xFFEFF2F6),
                  foreground: AppColors.navy,
                ),
              ),
              const Spacer(),
              _CardIconButton(
                icon: Icons.volume_up_rounded,
                loading: speaking,
                onTap: onSpeak,
              ),
              _CardIconButton(
                icon: copied ? Icons.check_rounded : Icons.copy_rounded,
                onTap: onCopy,
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: null,
            minLines: 2,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
              border: InputBorder.none,
              isCollapsed: true,
            ),
            style: TextStyle(
              fontSize: metrics.body + 2,
              height: 1.4,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF14213D),
            ),
          ),
          if (cleaned) ...[
            const SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey.withValues(alpha: 0.18)),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Tooltip(
                message: tr(context, 'cleaned_asr_explained'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF2F6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tr(context, 'cleaned_asr'),
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  const _TargetCard({
    required this.language,
    required this.text,
    required this.translating,
    required this.speaking,
    required this.hint,
    required this.onSpeak,
    required this.onCopy,
    required this.metrics,
  });

  final TranslateLanguage language;
  final String? text;
  final bool translating;
  final bool speaking;
  final String hint;
  final VoidCallback onSpeak;
  final VoidCallback onCopy;
  final _Metrics metrics;

  @override
  Widget build(BuildContext context) {
    final body = text;
    return Container(
      padding: EdgeInsets.all(metrics.pad),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF7F1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: _SectionPill(
                  label:
                      '${tr(context, 'target_label')} • '
                      '${language.name.toUpperCase()}',
                  background: AppColors.teal,
                  foreground: Colors.white,
                ),
              ),
              const Spacer(),
              if (body != null) ...[
                _CardIconButton(
                  icon: Icons.volume_up_rounded,
                  loading: speaking,
                  onTap: onSpeak,
                ),
                _CardIconButton(icon: Icons.copy_rounded, onTap: onCopy),
              ],
            ],
          ),
          const SizedBox(height: 12),
          if (body == null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  if (translating) ...[
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Text(
                      hint,
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            )
          else
            SelectableText(
              body,
              style: TextStyle(
                fontSize: metrics.target,
                height: 1.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F3D2E),
              ),
            ),
        ],
      ),
    );
  }
}

/// One-tap classroom sentences. Horizontal because the row is a shortcut,
/// not a menu — the full list is one tap further, behind View All.
/// Collapsed by default — a single compact toggle row — so the chip strip
/// only costs vertical space for the teacher who actually wants it, rather
/// than sitting permanently between the source card and the mic on every
/// visit.
class _PromptStrip extends StatefulWidget {
  const _PromptStrip({required this.onSelected, required this.onViewAll});

  final ValueChanged<ClassroomPrompt> onSelected;
  final VoidCallback onViewAll;

  @override
  State<_PromptStrip> createState() => _PromptStripState();
}

class _PromptStripState extends State<_PromptStrip> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Icon(
                  Icons.auto_stories_rounded,
                  size: 15,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    tr(context, 'classroom_prompts').toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
        if (_expanded) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: classroomPrompts.length,
                    separatorBuilder: (context, _) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final prompt = classroomPrompts[index];
                      return Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => widget.onSelected(prompt),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.teal.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  prompt.emoji,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  prompt.label,
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF14213D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: widget.onViewAll,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 10,
                  ),
                  child: Text(
                    tr(context, 'view_all_n', {
                      'n': '${classroomPrompts.length}',
                    }),
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.teal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Tap-to-toggle mic with a halo that swells while capturing.
class _MicButton extends StatelessWidget {
  const _MicButton({
    required this.listening,
    required this.starting,
    required this.elapsedLabel,
    required this.onTap,
    required this.metrics,
  });

  final bool listening;
  final bool starting;
  final String elapsedLabel;
  final VoidCallback? onTap;
  final _Metrics metrics;

  @override
  Widget build(BuildContext context) {
    final size = metrics.mic;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: size + (listening ? 28 : 18),
            height: size + (listening ? 28 : 18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.navy.withValues(alpha: listening ? 0.14 : 0.06),
            ),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: listening
                        ? [AppColors.navy, const Color(0xFF2B5CA8)]
                        : [
                            AppColors.navy.withValues(alpha: 0.92),
                            AppColors.navy,
                          ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navy.withValues(
                        alpha: listening ? 0.4 : 0.22,
                      ),
                      blurRadius: listening ? 24 : 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: starting
                    ? Padding(
                        padding: EdgeInsets.all(size * 0.32),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Icon(
                        listening ? Icons.mic_rounded : Icons.mic_none_rounded,
                        color: Colors.white,
                        size: size * 0.42,
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          starting
              ? tr(context, 'loading_speech_model')
              : listening
              ? tr(context, 'listening_tap_to_stop')
              : tr(context, 'tap_to_speak'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: metrics.body - 1,
            fontWeight: FontWeight.w700,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 5),
        // Recording feedback only. The engine's name was not something a
        // teacher could act on, and the timer means nothing when idle — but
        // the height stays reserved either way so the mic does not jump the
        // moment capture starts.
        SizedBox(
          height: 18,
          child: listening
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _PulsingDots(active: true),
                    const SizedBox(width: 8),
                    Text(
                      elapsedLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.teal,
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ],
    );
  }
}

class _PulsingDots extends StatefulWidget {
  const _PulsingDots({required this.active});

  final bool active;

  @override
  State<_PulsingDots> createState() => _PulsingDotsState();
}

class _PulsingDotsState extends State<_PulsingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void initState() {
    super.initState();
    if (widget.active) _controller.repeat();
  }

  // Only ticks while capturing. A permanently repeating controller would
  // repaint this row 60 times a second for the whole time the screen is
  // merely open — wasted battery on the 2GB tablet, and it also means no
  // frame ever settles, which breaks pumpAndSettle for every test that
  // touches this screen.
  @override
  void didUpdateWidget(covariant _PulsingDots oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active == oldWidget.active) return;
    if (widget.active) {
      _controller.repeat();
    } else {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final phase = (_controller.value + i * 0.22) % 1.0;
            final lit = widget.active && phase < 0.5;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _Dot(
                color: widget.active
                    ? (lit
                          ? AppColors.teal
                          : AppColors.teal.withValues(alpha: 0.3))
                    : Colors.grey.withValues(alpha: 0.45),
                size: 6,
              ),
            );
          }),
        );
      },
    );
  }
}

class _SectionPill extends StatelessWidget {
  const _SectionPill({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          color: foreground,
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
        padding: EdgeInsets.all(4),
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    // Not an IconButton: its Material 3 style keeps a fixed inset that the
    // `padding` argument does not override, which floats these actions away
    // from the card corner they belong in. InkResponse gives exact control,
    // and its splash still extends past the 4px padding.
    return InkResponse(
      onTap: onTap,
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 18, color: AppColors.navy),
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: const Color(0xFFE3E8EF)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.03),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

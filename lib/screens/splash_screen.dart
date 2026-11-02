import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../role/app_role.dart';
import '../services/hindi_asr_service.dart';
import 'role_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const _brandNavy = Color(0xFF1B3A6B);
  static const _brandOrange = Color(0xFFF6A522);
  static const _brandGreen = Color(0xFF2E8B6F);

  late final AnimationController _entranceController;
  late final Animation<double> _dotsFadeIn;

  late final AnimationController _dotsController;

  /// Plays the brand intro clip full-screen, at `_videoPlaybackSpeed`, in
  /// place of a small static logo. Muted (it must be, to autoplay). Looping
  /// is just a safety net in case `_navigateAfterDelay`'s own read of this
  /// clip's duration is ever off by a frame or two — the delay it computes
  /// there, not this, is what makes the clip play all the way through
  /// before the splash navigates away.
  late final VideoPlayerController _videoController;
  late final Future<void> _videoInitFuture;
  bool _videoReady = false;

  /// Playback speed for the intro clip. _navigateAfterDelay divides the
  /// clip's native duration by this so the splash's hold time still matches
  /// how long the sped-up clip actually takes to play through.
  static const _videoPlaybackSpeed = 1.5;

  @override
  void initState() {
    super.initState();

    _videoController =
        VideoPlayerController.asset('assets/videos/splash_intro.mp4')
          ..setVolume(0)
          ..setLooping(true);
    _videoInitFuture = _videoController.initialize().then(
      (_) {
        if (!mounted) return;
        setState(() => _videoReady = true);
        _videoController.setPlaybackSpeed(_videoPlaybackSpeed);
        _videoController.play();
      },
      // Falls back to the plain gradient background (the `_videoReady ==
      // false` branch below) if the platform's video decoder ever rejects
      // this — including in widget tests, which have no real video_player
      // platform implementation to answer this call at all. Swallowing the
      // error rather than rethrowing also matters for _navigateAfterDelay
      // below, which awaits this future — a rejected one would otherwise
      // stop the splash from ever navigating away.
      onError: (_) {},
    );

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _dotsFadeIn = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.55, 1.0, curve: Curves.easeIn),
    );

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _entranceController.forward();
    // Overlaps the ASR model's multi-second first-use load (asset
    // extraction + recognizer build) with the splash screen's own display
    // time, so it's normally already resident by the time the user reaches
    // Translate and taps the mic, instead of starting cold then.
    _navigateAfterDelay(HindiAsrService.instance.prewarm());
  }

  Future<void> _navigateAfterDelay(Future<void> prewarm) async {
    // Fallback for how long to sit on the plain gradient background if the
    // video never becomes ready at all (init error/timeout) — the normal
    // case below reads the clip's *actual* duration instead of guessing.
    const fallbackVisibleTime = Duration(milliseconds: 2200);
    // Caps how long we wait on the video itself before giving up on it.
    const maxVideoInitWait = Duration(milliseconds: 3000);
    // A real low-RAM device can take noticeably longer than this session's
    // desktop-class dev hardware to extract + build the recognizer — long
    // enough that a short fixed splash delay used to elapse first, so the
    // mic still showed "Loading speech model…" for a while on the first tap
    // anyway. Hold the splash screen for the model too, but only up to this
    // much extra: prewarm() already swallows its own errors and just lets
    // startListening() retry later, so this is purely a safety cap against
    // it simply running long, not against it throwing.
    const maxExtraWait = Duration(milliseconds: 4000);
    // Ceiling on the clip-duration wait itself, in case a corrupt/odd file
    // ever reports an implausible duration — keeps this from ever holding
    // the splash open indefinitely.
    const maxVideoPlayWait = Duration(milliseconds: 15000);

    final roleController = AppRoleScope.read(context);
    // Waits for the *actual* length of the clip (read from the file once
    // it's initialized) rather than a guessed fixed delay — a fixed delay
    // shorter than the clip cuts it off mid-playback, which was the whole
    // complaint: "the video is long" and the splash was moving on before it
    // finished. The native duration is scaled down by _videoPlaybackSpeed
    // below to get the actual wall-clock time needed to watch it through
    // once at that speed.
    final videoSettled = _videoInitFuture
        .timeout(maxVideoInitWait, onTimeout: () {})
        .then((_) {
          final nativeDuration = _videoController.value.duration;
          // Divided by the playback speed: the clip now plays through in
          // less wall-clock time than its native (1x) duration reports.
          final clipDuration = nativeDuration > Duration.zero
              ? nativeDuration * (1 / _videoPlaybackSpeed)
              : Duration.zero;
          final wait = clipDuration > Duration.zero
              ? (clipDuration < maxVideoPlayWait
                    ? clipDuration
                    : maxVideoPlayWait)
              : fallbackVisibleTime;
          return Future.delayed(wait);
        });
    // The stored role is loaded in parallel with the splash delay — not to
    // decide where to go (the role screen always follows the logo) but so
    // that screen can mark the role already in use.
    await Future.wait([
      videoSettled,
      prewarm.timeout(
        maxVideoInitWait + maxVideoPlayWait + maxExtraWait,
        onTimeout: () {},
      ),
      roleController.load(),
    ]);
    if (!mounted) return;
    const next = RoleSelectionScreen();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => next,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _dotsController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_videoReady)
            // FittedBox+contain, sized to the video's own native pixels,
            // inside a Stack forced to fill the whole screen (StackFit.
            // expand). The clip is landscape (1280x720) but the splash is
            // shown on portrait phone screens, so BoxFit.cover — which
            // scales to fill width — cropped off the top/bottom of the logo
            // animation (arrows, book) instead of showing it whole. contain
            // letterboxes against the white Scaffold background instead.
            FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            )
          else
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    _brandGreen.withValues(alpha: 0.05),
                    _brandOrange.withValues(alpha: 0.06),
                  ],
                ),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 64,
            child: FadeTransition(
              opacity: _dotsFadeIn,
              child: _LoadingDots(
                controller: _dotsController,
                // The video now letterboxes (BoxFit.contain) against the
                // white background instead of filling the screen, so the
                // dots always sit on white — never on video content —
                // regardless of _videoReady.
                color: _brandNavy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingDots extends StatelessWidget {
  const _LoadingDots({required this.controller, required this.color});

  final AnimationController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final t = (controller.value - index * 0.2) % 1.0;
            final opacity = t < 0.5
                ? Curves.easeInOut.transform(t * 2)
                : Curves.easeInOut.transform((1 - t) * 2);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Opacity(
                opacity: 0.25 + (opacity * 0.75),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

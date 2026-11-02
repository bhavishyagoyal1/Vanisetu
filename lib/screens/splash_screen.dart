import 'package:flutter/material.dart';

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
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _dotsFadeIn;

  late final AnimationController _glowController;
  late final Animation<double> _glowScale;

  late final AnimationController _dotsController;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.55,
          end: 1.06,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 65,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.06,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
    ]).animate(_entranceController);
    _logoOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );
    _dotsFadeIn = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.55, 1.0, curve: Curves.easeIn),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _glowScale = Tween<double>(begin: 0.9, end: 1.08).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
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
    const minSplashTime = Duration(milliseconds: 2600);
    // A real low-RAM device can take noticeably longer than this session's
    // desktop-class dev hardware to extract + build the recognizer — long
    // enough that the fixed splash delay used to elapse first, so the mic
    // still showed "Loading speech model…" for a while on the first tap
    // anyway. Hold the splash screen for the model too, but only up to this
    // much extra: prewarm() already swallows its own errors and just lets
    // startListening() retry later, so this is purely a safety cap against
    // it simply running long, not against it throwing.
    const maxExtraWait = Duration(milliseconds: 4000);

    final roleController = AppRoleScope.read(context);
    // The stored role is loaded in parallel with the splash delay — not to
    // decide where to go (the role screen always follows the logo) but so
    // that screen can mark the role already in use.
    await Future.wait([
      Future.delayed(minSplashTime),
      prewarm.timeout(minSplashTime + maxExtraWait, onTimeout: () {}),
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
    _glowController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
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
          ),
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _entranceController,
                _glowController,
              ]),
              builder: (context, child) {
                return Opacity(
                  opacity: _logoOpacity.value,
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scale: _glowScale.value,
                          child: Container(
                            width: 260,
                            height: 260,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  _brandOrange.withValues(alpha: 0.18),
                                  _brandGreen.withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                        child!,
                      ],
                    ),
                  ),
                );
              },
              child: Image.asset(
                'assets/images/logo.png',
                width: 260,
                height: 260,
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

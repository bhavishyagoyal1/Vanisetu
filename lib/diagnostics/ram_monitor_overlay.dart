import 'package:flutter/material.dart';

import 'ram_monitor_controller.dart';

/// Small persistent HUD showing live process RSS, visible on every screen
/// while the Settings toggle is on — see RamMonitorController's doc comment
/// for what the number actually measures and why. Draggable: it starts
/// top-right but can be dragged anywhere so it doesn't sit on top of
/// whatever it happens to be overlapping (the mic button, an app bar
/// action, etc.) — position is kept for the life of the app, not persisted
/// across restarts, since this is a developer/tester tool, not a user
/// preference.
class RamMonitorOverlay extends StatefulWidget {
  const RamMonitorOverlay({super.key});

  @override
  State<RamMonitorOverlay> createState() => _RamMonitorOverlayState();
}

class _RamMonitorOverlayState extends State<RamMonitorOverlay> {
  static const _badgeWidth = 150.0;
  static const _badgeHeight = 74.0;

  Offset? _position;

  Offset _clamp(Offset offset, Size screenSize) {
    return Offset(
      offset.dx.clamp(0.0, screenSize.width - _badgeWidth),
      offset.dy.clamp(0.0, screenSize.height - _badgeHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: RamMonitorController.instance,
      builder: (context, _) {
        final controller = RamMonitorController.instance;
        if (!controller.enabled) return const SizedBox.shrink();

        final screenSize = MediaQuery.sizeOf(context);
        _position ??= Offset(screenSize.width - _badgeWidth - 12, 40);
        final position = _clamp(_position!, screenSize);

        final currentMb = controller.currentRssBytes / (1024 * 1024);
        final peakMb = controller.peakRssBytes / (1024 * 1024);
        final fraction =
            (controller.currentRssBytes / RamMonitorController.budgetBytes)
                .clamp(0.0, 1.0);
        final color = fraction > 0.9
            ? Colors.redAccent
            : fraction > 0.7
            ? Colors.orangeAccent
            : Colors.greenAccent;

        return Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _position = _clamp(_position! + details.delta, screenSize);
              });
            },
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(14),
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.drag_indicator_rounded,
                          size: 14,
                          color: Colors.white38,
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.memory_rounded, size: 14, color: color),
                        const SizedBox(width: 6),
                        Text(
                          '${currentMb.toStringAsFixed(0)} MB',
                          style: TextStyle(
                            color: color,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          ' / 2048 MB',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: SizedBox(
                        width: 120,
                        height: 4,
                        child: LinearProgressIndicator(
                          value: fraction,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation(color),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'peak ${peakMb.toStringAsFixed(0)} MB',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

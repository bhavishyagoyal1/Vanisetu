import 'package:flutter/material.dart';

import 'ram_monitor_controller.dart';

/// Small persistent HUD showing live process RSS, visible on every screen
/// while the Settings toggle is on — see RamMonitorController's doc comment
/// for what the number actually measures and why.
class RamMonitorOverlay extends StatelessWidget {
  const RamMonitorOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: RamMonitorController.instance,
      builder: (context, _) {
        final controller = RamMonitorController.instance;
        if (!controller.enabled) return const SizedBox.shrink();

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
          top: 40,
          right: 12,
          child: SafeArea(
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

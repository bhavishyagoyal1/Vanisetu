import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// Tracks the app process's actual memory footprint via `dart:io`'s
/// [ProcessInfo] — the OS-reported resident set size (RSS), not a Dart-heap
/// estimate. RSS covers everything resident for this process: the Dart
/// heap, and critically the native allocations the ONNX Runtime and
/// sherpa-onnx make for the ASR/MT/TTS models once loaded, since those are
/// the dominant cost against this project's 2GB device budget.
///
/// A singleton (matching the rest of the app's service pattern) so the
/// Settings toggle and the overlay can share one sampling timer regardless
/// of which screens are mounted.
class RamMonitorController extends ChangeNotifier {
  RamMonitorController._();
  static final RamMonitorController instance = RamMonitorController._();

  static const budgetBytes = 2 * 1024 * 1024 * 1024; // 2GB device constraint

  bool _enabled = false;
  int _currentRssBytes = 0;
  int _peakRssBytes = 0;
  Timer? _timer;

  bool get enabled => _enabled;
  int get currentRssBytes => _currentRssBytes;
  int get peakRssBytes => _peakRssBytes;

  void setEnabled(bool value) {
    if (_enabled == value) return;
    _enabled = value;
    if (value) {
      _sample();
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _sample());
    } else {
      _timer?.cancel();
      _timer = null;
    }
    notifyListeners();
  }

  void _sample() {
    _currentRssBytes = ProcessInfo.currentRss;
    _peakRssBytes = ProcessInfo.maxRss;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

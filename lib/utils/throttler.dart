import 'dart:async';

import 'package:flutter/material.dart';

class Throttler {
  final Duration delay;
  Timer? _timer;
  bool _isThrottling = false;

  Throttler({required this.delay});

  void run(VoidCallback action) {
    if (_isThrottling) return;
    action();

    _isThrottling = true;

    _timer = Timer(delay, () {
      _isThrottling = false;
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}

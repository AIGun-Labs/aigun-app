import 'dart:async';

import 'package:flutter/material.dart';

class DebouncerUtils {
  static Timer? _timer;

  static void run({
    int milliseconds = 300,
    bool immediate = false,
    required VoidCallback action,
  }) {
    if (immediate && _timer == null) {
      action();
    }
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      if (!immediate) {
        action();
      }
      _timer = null;
    });
  }
}

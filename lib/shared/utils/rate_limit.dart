// lib/shared/utils/rate_limit.dart
import 'dart:async';

/// ===============================

/// ===============================


class Debounce {
  Debounce({required this.delay, this.maxWait});
  final Duration delay;
  final Duration? maxWait;

  Timer? _timer;
  Timer? _maxTimer;
  Completer<void>? _pending;

  
  Future<void> run(FutureOr<void> Function() action) {
    _pending ??= Completer<void>();

    _timer?.cancel();
    _timer = Timer(delay, () async {
      _clearMaxTimer();
      await _invoke(action);
    });

    if (maxWait != null && _maxTimer == null) {
      _maxTimer = Timer(maxWait!, () async {
        _timer?.cancel();
        await _invoke(action);
      });
    }
    return _pending!.future;
  }

  
  Future<void> flush(FutureOr<void> Function() action) async {
    _timer?.cancel();
    _clearMaxTimer();
    await _invoke(action);
  }

  
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _clearMaxTimer();
    _pending?.complete();
    _pending = null;
  }

  void dispose() => cancel();

  void _clearMaxTimer() {
    _maxTimer?.cancel();
    _maxTimer = null;
  }

  Future<void> _invoke(FutureOr<void> Function() action) async {
    try {
      await action();
    } finally {
      _pending?.complete();
      _pending = null;
    }
  }
}


class DebounceValue<T> {
  DebounceValue({required this.delay, this.maxWait});
  final Duration delay;
  final Duration? maxWait;

  Timer? _timer;
  Timer? _maxTimer;
  Completer<void>? _pending;
  T? _latest;

  Future<void> call(T value, FutureOr<void> Function(T value) action) {
    _latest = value;
    _pending ??= Completer<void>();

    _timer?.cancel();
    _timer = Timer(delay, () async {
      _clearMaxTimer();
      await _invoke(action);
    });

    if (maxWait != null && _maxTimer == null) {
      _maxTimer = Timer(maxWait!, () async {
        _timer?.cancel();
        await _invoke(action);
      });
    }
    return _pending!.future;
  }

  Future<void> flush(FutureOr<void> Function(T value) action) async {
    _timer?.cancel();
    _clearMaxTimer();
    await _invoke(action);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
    _clearMaxTimer();
    _pending?.complete();
    _pending = null;
  }

  void dispose() => cancel();

  Future<void> _invoke(FutureOr<void> Function(T value) action) async {
    final v = _latest;
    if (v == null) return;
    try {
      await action(v);
    } finally {
      _pending?.complete();
      _pending = null;
    }
  }

  void _clearMaxTimer() {
    _maxTimer?.cancel();
    _maxTimer = null;
  }
}

/// ===============================

/// ===============================


class Throttle {
  Throttle({
    required this.period,
    this.leading = true,
    this.trailing = true,
  });

  final Duration period;
  final bool leading; 
  final bool trailing; 

  DateTime? _lastInvoke;
  Timer? _trailingTimer;
  Completer<void>? _pending;

  Future<void> run(FutureOr<void> Function() action) {
    _pending ??= Completer<void>();
    final now = DateTime.now();

    void complete() {
      _pending?.complete();
      _pending = null;
    }

    
    if (_lastInvoke == null) {
      if (leading) {
        _lastInvoke = now;
        Future.sync(action).whenComplete(complete);
        return _pending!.future;
      }
      if (trailing && _trailingTimer == null) {
        _trailingTimer = Timer(period, () {
          _lastInvoke = DateTime.now();
          Future.sync(action).whenComplete(() {
            _trailingTimer = null;
            complete();
          });
        });
      }
      return _pending!.future;
    }

    
    final elapsed = now.difference(_lastInvoke!);
    if (elapsed >= period) {
      _trailingTimer?.cancel();
      _trailingTimer = null;
      _lastInvoke = now;
      Future.sync(action).whenComplete(complete);
    } else if (trailing && _trailingTimer == null) {
      _trailingTimer = Timer(period - elapsed, () {
        _lastInvoke = DateTime.now();
        Future.sync(action).whenComplete(() {
          _trailingTimer = null;
          complete();
        });
      });
    }
    return _pending!.future;
  }

  void cancelTrailing() {
    _trailingTimer?.cancel();
    _trailingTimer = null;
    _pending?.complete();
    _pending = null;
  }

  void dispose() => cancelTrailing();
}


class ThrottleValue<T> {
  ThrottleValue({
    required this.period,
    this.leading = true,
    this.trailing = true,
  });

  final Duration period;
  final bool leading;
  final bool trailing;

  DateTime? _lastInvoke;
  Timer? _trailingTimer;
  T? _lastArg;
  Completer<void>? _pending;

  Future<void> call(T arg, FutureOr<void> Function(T) action) {
    _pending ??= Completer<void>();
    final now = DateTime.now();
    _lastArg = arg;

    void complete() {
      _pending?.complete();
      _pending = null;
    }

    if (_lastInvoke == null) {
      if (leading) {
        _lastInvoke = now;
        Future.sync(() => action(arg)).whenComplete(complete);
        return _pending!.future;
      }
      if (trailing && _trailingTimer == null) {
        _trailingTimer = Timer(period, () {
          final a = _lastArg;
          _lastInvoke = DateTime.now();
          Future.sync(() => action(a as T)).whenComplete(() {
            _trailingTimer = null;
            complete();
          });
        });
      }
      return _pending!.future;
    }

    final elapsed = now.difference(_lastInvoke!);
    if (elapsed >= period) {
      _trailingTimer?.cancel();
      _trailingTimer = null;
      _lastInvoke = now;
      Future.sync(() => action(arg)).whenComplete(complete);
    } else if (trailing && _trailingTimer == null) {
      _trailingTimer = Timer(period - elapsed, () {
        final a = _lastArg;
        _lastInvoke = DateTime.now();
        Future.sync(() => action(a as T)).whenComplete(() {
          _trailingTimer = null;
          complete();
        });
      });
    }
    return _pending!.future;
  }

  void cancelTrailing() {
    _trailingTimer?.cancel();
    _trailingTimer = null;
    _pending?.complete();
    _pending = null;
  }

  void dispose() => cancelTrailing();
}

/// ===============================

/// ===============================


class CooldownGate {
  CooldownGate(this.cooldown, {this.fromCompletion = false});

  final Duration cooldown;

  
  final bool fromCompletion;

  DateTime? _nextAllowedAt;

  bool get isCooling =>
      _nextAllowedAt != null && DateTime.now().isBefore(_nextAllowedAt!);

  
  int secondsLeft() {
    if (_nextAllowedAt == null) return 0;
    final s = _nextAllowedAt!.difference(DateTime.now()).inSeconds;
    return s > 0 ? s : 0;
  }

  
  Future<bool> tryRun(FutureOr<void> Function() action) async {
    final now = DateTime.now();
    if (_nextAllowedAt != null && now.isBefore(_nextAllowedAt!)) {
      return false;
    }
    
    _nextAllowedAt = now.add(cooldown);

    if (fromCompletion) {
      try {
        await action();
      } finally {
        _nextAllowedAt = DateTime.now().add(cooldown);
      }
    } else {
      await action();
    }
    return true;
  }

  
  void reset() => _nextAllowedAt = null;
}

// lib/shared/utils/rate_limit.dart
import 'dart:async';

/// ===============================
/// Debounce（防抖 - 尾触发 + 可选 maxWait）
/// ===============================

/// 无参 Debounce：重复触发后，仅在最后一次触发后的 [delay] 执行。
class Debounce {
  Debounce({required this.delay, this.maxWait});
  final Duration delay;
  final Duration? maxWait;

  Timer? _timer;
  Timer? _maxTimer;
  Completer<void>? _pending;

  /// 触发一次（若在 delay 内再次触发，会重置计时）。
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

  /// 立即执行待处理的动作（如果有），并清空计时。
  Future<void> flush(FutureOr<void> Function() action) async {
    _timer?.cancel();
    _clearMaxTimer();
    await _invoke(action);
  }

  /// 取消待执行动作。
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

/// 单参数 Debounce：保存“最后一次参数”，在静默 [delay] 后执行。
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
/// Throttle（节流 - 时间窗内限频，支持 leading/trailing）
/// ===============================

/// 无参 Throttle：在 [period] 时间窗内限制执行频率。
class Throttle {
  Throttle({
    required this.period,
    this.leading = true,
    this.trailing = true,
  });

  final Duration period;
  final bool leading; // 是否在时间窗开始时立刻执行
  final bool trailing; // 是否在时间窗结束时再执行一次（取最后一次触发）

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

    // 首次触发
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

    // 非首次
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

/// 单参数 Throttle：记录最后一次参数用于 trailing。
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
/// Cooldown（冷却门 - 适合”按钮冷却“）
/// ===============================

/// 冷却门：在冷却期内拒绝执行；支持从“开始”或“完成”计时。
class CooldownGate {
  CooldownGate(this.cooldown, {this.fromCompletion = false});

  final Duration cooldown;

  /// true：冷却从“动作完成”开始；false：从“动作开始”开始。
  final bool fromCompletion;

  DateTime? _nextAllowedAt;

  bool get isCooling =>
      _nextAllowedAt != null && DateTime.now().isBefore(_nextAllowedAt!);

  /// 返回剩余秒数（UI 可用于显示倒计时）。
  int secondsLeft() {
    if (_nextAllowedAt == null) return 0;
    final s = _nextAllowedAt!.difference(DateTime.now()).inSeconds;
    return s > 0 ? s : 0;
  }

  /// 尝试执行；处于冷却期则返回 false，不执行 action。
  Future<bool> tryRun(FutureOr<void> Function() action) async {
    final now = DateTime.now();
    if (_nextAllowedAt != null && now.isBefore(_nextAllowedAt!)) {
      return false;
    }
    // 先设置冷却，防止并发穿透
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

  /// 立即解除冷却（例如用户取消了操作）
  void reset() => _nextAllowedAt = null;
}

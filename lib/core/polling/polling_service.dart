import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../constant/count.dart';

typedef Fetcher<T> = Future<T> Function(CancelToken cancelToken);
typedef OnData<T> = void Function(T data);
typedef OnError = void Function(Object error, StackTrace? stack);
typedef OnFinally = void Function();
typedef OnMaxAttemptsReached = void Function();

class PollingService<T> with WidgetsBindingObserver {
  final Fetcher<T> fetcher;
  final OnData<T> onData;
  final OnError? onError;
  final OnFinally? onFinally;

  final Duration baseInterval;

  final Duration maxInterval;

  final bool pauseOnBackground;

  final bool pauseOnNoNetwork;

  final int? maxAttempts;

  final OnMaxAttemptsReached? onMaxAttemptsReached;

  bool _running = false;
  int _attempt = 0;
  int _totalAttempts = 0;
  CancelToken? _cancelToken;

  PollingService({
    required this.fetcher,
    required this.onData,
    this.onError,
    this.baseInterval = const Duration(seconds: FIVE),
    this.maxInterval = const Duration(minutes: TEN),
    this.pauseOnBackground = true,
    this.pauseOnNoNetwork = true,
    this.onFinally,
    this.maxAttempts,
    this.onMaxAttemptsReached,
  });

  Future<void> start() async {
    if (_running) return;
    _running = true;
    _attempt = 0;
    _totalAttempts = 0;
    WidgetsBinding.instance.addObserver(this);
    _loop();
  }

  Future<void> stop() async {
    _running = false;
    _totalAttempts = 0;
    _cancelToken?.cancel('polling-stopped');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!pauseOnBackground) return;
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _cancelToken?.cancel('app-background');
    }
  }

  Duration _backoffDelay(int attempt) {
    final factor = min(
      1 << attempt,
      maxInterval.inMilliseconds ~/ baseInterval.inMilliseconds,
    );
    final cap = baseInterval * factor;
    final jitter = Random().nextDouble();
    final ms = (jitter * cap.inMilliseconds).toInt();
    final d = Duration(milliseconds: ms);
    return d > maxInterval ? maxInterval : d;
  }

  Future<void> _waitForNetworkIfNeeded() async {
    if (!pauseOnNoNetwork) return;
    final status = await Connectivity().checkConnectivity();
    if (status == ConnectivityResult.none) {
      await Connectivity().onConnectivityChanged.firstWhere(
        (s) => s != ConnectivityResult.none,
      );
    }
  }

  Future<void> _loop() async {
    while (_running) {
      if (maxAttempts != null && _totalAttempts >= maxAttempts!) {
        onMaxAttemptsReached?.call();
        stop();
        return;
      }

      try {
        await _waitForNetworkIfNeeded();

        _totalAttempts++;
        _cancelToken = CancelToken();
        final value = await fetcher(_cancelToken!);
        if (!_running) break;

        onData(value);
        _attempt = 0;

        await Future.delayed(baseInterval);
      } catch (e, s) {
        if (e is DioException && CancelToken.isCancel(e)) {
          await Future.delayed(const Duration(milliseconds: 150));
          continue;
        }
        onError?.call(e, s);

        _attempt += 1;
        final delay = _backoffDelay(_attempt);
        await Future.delayed(delay);
      } finally {
        onFinally?.call();
      }
    }
  }
}

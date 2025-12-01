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

  /// 正常轮询间隔（成功后等待）
  final Duration baseInterval;

  /// 退避的最大间隔上限
  final Duration maxInterval;

  /// 切到后台时是否暂停（会 cancel 当前请求）
  final bool pauseOnBackground;

  /// 断网时是否暂停直到恢复
  final bool pauseOnNoNetwork;

  /// 最大轮询次数限制（null 表示无限制）
  final int? maxAttempts;

  /// 达到最大轮询次数时的回调
  final OnMaxAttemptsReached? onMaxAttemptsReached;

  bool _running = false;
  int _attempt = 0; // 连续失败次数
  int _totalAttempts = 0; // 总轮询次数
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
    _totalAttempts = 0; // 重置总尝试次数
    WidgetsBinding.instance.addObserver(this);
    _loop();
  }

  Future<void> stop() async {
    _running = false;
    _totalAttempts = 0; // 重置总尝试次数
    _cancelToken?.cancel('polling-stopped');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!pauseOnBackground) return;
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // 切后台立即打断当前请求
      _cancelToken?.cancel('app-background');
    }
  }

  Duration _backoffDelay(int attempt) {
    // 指数退避 + full jitter
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
      // 等到任一网络恢复
      await Connectivity().onConnectivityChanged.firstWhere(
        (s) => s != ConnectivityResult.none,
      );
    }
  }

  Future<void> _loop() async {
    while (_running) {
      // 检查是否达到最大尝试次数
      if (maxAttempts != null && _totalAttempts >= maxAttempts!) {
        // 达到最大尝试次数，调用回调并停止轮询
        onMaxAttemptsReached?.call();
        stop();
        return;
      }

      try {
        await _waitForNetworkIfNeeded();

        _totalAttempts++; // 增加总尝试次数
        _cancelToken = CancelToken();
        final value = await fetcher(_cancelToken!);
        if (!_running) break;

        onData(value);
        _attempt = 0; // 成功则清零失败计数

        // 成功后的常规间隔
        await Future.delayed(baseInterval);
      } catch (e, s) {
        if (e is DioException && CancelToken.isCancel(e)) {
          // 主动取消（切后台/stop），给一个极短冷却
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

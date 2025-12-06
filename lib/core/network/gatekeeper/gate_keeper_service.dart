import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class _PendingRequest {
  final RequestOptions options;
  final RequestInterceptorHandler handler;

  _PendingRequest(this.options, this.handler);
}

class GateKeeperService {
  // 使用 UI 监听状态 (true = 锁定/不可用, false = 正常)
  final ValueNotifier<bool> isServiceLockedNotifier = ValueNotifier<bool>(
    false,
  );

  //后端服务是否可用（通过 API 轮询确定）
  bool _isBackendHealthy = true;

  //设备网络是否在线（通过 connectivity_plus 确定）
  bool _isDeviceOnline = true;

  bool get isBackendHealthy => _isBackendHealthy;

  bool get isDeviceOnline => _isDeviceOnline;

  bool get isServiceAvailable => _isBackendHealthy && _isDeviceOnline;

  // 挂起的请求队列
  final List<_PendingRequest> _pendingQueue = [];

  // 专门用于检测状态的 Dio 实例（必须独立，否则会被自己拦截死锁）
  late final Dio _statusCheckDio;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  // 控制轮询是否继续
  bool _isDisposed = false;

  // 用于控制递归轮询的 Future，确保只有一个在运行
  bool _isPolling = false;

  // 状态接口配置
  final String _statusCheckPath = '/api/v1/status';
  final Duration _pollInterval = const Duration(seconds: 3);

  GateKeeperService(String baseUrl) {
    // 初始化一个干净的 Dio，不加任何业务拦截器
    _statusCheckDio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    Connectivity().checkConnectivity().then(_handleConnectivityChange);

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      _handleConnectivityChange,
    );

    // 🚀 初始化立即开始轮询
    _startRecursivePolling();
  }

  // 供拦截器调用：将请求加入等待队列
  void addPendingRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    _pendingQueue.add(_PendingRequest(options, handler));
  }

  // 设备网络状态变化处理
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    // 检查是否有任何有效的连接 (wifi, mobile, ethernet)
    final bool currentlyOnline = results.any(
      (r) => r != ConnectivityResult.none && r != ConnectivityResult.bluetooth,
    );

    if (_isDeviceOnline == currentlyOnline) return;

    _isDeviceOnline = currentlyOnline;

    if (currentlyOnline) {
      // 只要设备网络恢复，立刻尝试检测服务状态
      _checkStatus();
    }

    // 无论设备网络状态如何，都需要更新整体锁定状态
    _updateLockState();
  }

  /// 递归轮询
  Future<void> _startRecursivePolling() async {
    if (_isDisposed || _isPolling) return;

    _isPolling = true;

    while (!_isDisposed) {
      if (_isDeviceOnline) {
        await _checkStatus();
      } else {
        await Future.delayed(const Duration(seconds: 1));
      }

      await Future.delayed(_pollInterval);
    }

    _isPolling = false;
  }

  /// 检测状态接口逻辑
  Future<void> _checkStatus() async {
    if (!_isDeviceOnline) return;
    try {
      final response = await _statusCheckDio.get(_statusCheckPath);

      // 假设后端返回 { "code": 0, "msg": "success" } 代表系统恢复
      // 根据你的实际业务调整判断条件
      final isHealthy =
          response.statusCode == 200 &&
          response.data['code'] == 0 &&
          response.data['data']['status'] == 'healthy';
      debugPrint('checkStatus: ${response.data['data']['status']}');
      if (isHealthy) {
        _markBackendAsHealthy();
      } else {
        _markBackendAsUnhealthy();
      }
    } catch (e) {
      _markBackendAsUnhealthy();
      debugPrint('checkStatus error: ${e.toString()}');
    }
  }

  void _updateLockState() {
    final bool shouldLock = !isServiceAvailable;

    if (isServiceLockedNotifier.value == shouldLock) return;

    isServiceLockedNotifier.value = shouldLock;

    if (!shouldLock) {
      _flushQueue();
    }
  }

  void _markBackendAsHealthy() {
    if (_isBackendHealthy) return;
    _isBackendHealthy = true;
    _updateLockState();
  }

  void _markBackendAsUnhealthy() {
    if (!_isBackendHealthy) return;
    _isBackendHealthy = false;
    _updateLockState();
  }

  /// 🚀 释放队列中的请求
  void _flushQueue() {
    if (_pendingQueue.isEmpty) return;

    // 1. 创建快照并清空原队列
    // 这样做是为了防止在遍历过程中，某个请求立即失败又重新加入队列，导致死循环
    final requestsToProcess = List<_PendingRequest>.from(_pendingQueue);
    _pendingQueue.clear();

    // 2. 逐个放行
    for (final req in requestsToProcess) {
      // 调用 next 让 Dio 继续处理该请求
      req.handler.next(req.options);
    }
  }

  /// 手动触发锁定 (保留该方法，以便 Interceptor 遇到 503 时可以立即通知)
  /// 这样可以减少等待轮询间隔的时间
  void lockService() {
    _markBackendAsUnhealthy();
  }

  // 销毁
  void dispose() {
    _isDisposed = true;
    _connectivitySubscription.cancel();
    isServiceLockedNotifier.dispose();
    _pendingQueue.clear();
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class _PendingRequest {
  final RequestOptions options;
  final RequestInterceptorHandler handler;

  _PendingRequest(this.options, this.handler);
}

class ServiceGatekeeper {
// 使用 ValueNotifier，方便 Flutter UI 监听
  final ValueNotifier<bool> isServiceLockedNotifier =
      ValueNotifier<bool>(false);

  /// 服务是否可用（默认可用）
  bool _isServiceAvailable = true;

  bool get isServiceAvailable => _isServiceAvailable;

  /// 挂起的请求队列
  final List<_PendingRequest> _pendingQueue = [];

  /// 专门用于检测状态的 Dio 实例（必须独立，否则会被自己拦截死锁）
  late final Dio _statusCheckDio;

  /// 控制轮询是否继续
  bool _isDisposed = false;

  // 状态接口配置
  final String _statusCheckPath = '/api/v1/status';
  final Duration _pollInterval = const Duration(seconds: 3);

  ServiceGatekeeper(String baseUrl) {
    // 初始化一个干净的 Dio，不加任何业务拦截器
    _statusCheckDio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ));

    // 🚀 初始化立即开始轮询
    _startRecursivePolling();
  }

  /// ♻️ 递归轮询 (比 Timer.periodic 更安全，防止请求堆叠)
  Future<void> _startRecursivePolling() async {
    if (_isDisposed) return;

    await _checkStatus();

    // 等待间隔后再次执行
    if (!_isDisposed) {
      Future.delayed(_pollInterval, _startRecursivePolling);
    }
  }

  /// 供拦截器调用：将请求加入等待队列
  void addPendingRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    _pendingQueue.add(_PendingRequest(options, handler));
  }

  /// 检测状态接口逻辑
  Future<void> _checkStatus() async {
    try {
      final response = await _statusCheckDio.get(_statusCheckPath);

      // 假设后端返回 { "code": 0, "msg": "success" } 代表系统恢复
      // 根据你的实际业务调整判断条件
      final isHealthy = response.data['code'] == 0 &&
          response.data['data']['status'] == 'healthy';

      if (isHealthy) {
        print('✅ Service is healthy');
        _markAsAvailable();
      } else {
        print('❌ Service is unhealthy');
        _markAsUnavailable();
      }
    } catch (e) {
      _markAsUnavailable();
    }
  }

  /// 🔓 切换为：可用状态
  void _markAsAvailable() {
    // 如果状态没有变，就不做多余操作
    if (_isServiceAvailable) return;

    _isServiceAvailable = true;
    isServiceLockedNotifier.value = false;

    _flushQueue();
  }

  /// 🔒 切换为：不可用状态
  void _markAsUnavailable() {
    // 如果状态没变，不做多余操作
    if (!_isServiceAvailable) return;

    _isServiceAvailable = false;
    isServiceLockedNotifier.value = true;
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
    _markAsUnavailable();
  }

  // 销毁
  void dispose() {
    _isDisposed = true;
    _isServiceAvailable = true; // 销毁时恢复默认，避免内存泄漏影响
    isServiceLockedNotifier.dispose();
    _pendingQueue.clear();
  }
}

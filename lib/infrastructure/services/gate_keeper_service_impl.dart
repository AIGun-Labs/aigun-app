import 'dart:async';
import 'dart:collection';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/services/gate_keeper_service.dart';
import '../../utils/logger.dart';
import '../network/models/pending_request.dart';
import '../network/utils/gate_kepper_service_util.dart';

class GateKeeperServiceImpl
    with WidgetsBindingObserver
    implements GateKeeperService {
  GateKeeperServiceImpl(String baseUrl) {
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

    WidgetsBinding.instance.addObserver(this);
    // 🚀 初始化立即开始轮询
    _startRecursivePolling();
  }

  // 使用 UI 监听状态 (true = 锁定/不可用, false = 正常)
  @override
  final ValueNotifier<bool> isServiceLockedNotifier = ValueNotifier<bool>(
    false,
  );

  //后端服务是否可用（通过 API 轮询确定）
  bool _isBackendHealthy = true;

  //设备网络是否在线（通过 connectivity_plus 确定）
  bool _isDeviceOnline = true;

  @override
  bool get isBackendHealthy => _isBackendHealthy;

  @override
  bool get isDeviceOnline => _isDeviceOnline;

  @override
  bool get isServiceAvailable => _isBackendHealthy && _isDeviceOnline;

  // TODO(LY): 挂起的请求去重队列
  final List<PendingRequest> _pendingQueue = [];

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

  // 连续不健康计数器
  int _consecutiveUnhealthyCount = 0;
  // 不健康阈值
  static const int _unhealthyThreshold = 3;

  final LinkedHashMap<String, _PendingGroup> _pendingByKey =
      LinkedHashMap<String, _PendingGroup>();

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

        _consecutiveUnhealthyCount = 0;
      } else {
        _consecutiveUnhealthyCount++;
        if (_consecutiveUnhealthyCount >= _unhealthyThreshold) {
          _markBackendAsUnhealthy();
        }
      }
    } catch (e) {
      _consecutiveUnhealthyCount++;
      if (_consecutiveUnhealthyCount >= _unhealthyThreshold) {
        _markBackendAsUnhealthy();
      }
      debugPrint('checkStatus error: ${e.toString()}');
    }
  }

  /// 根据当前状态更新锁定状态
  void _updateLockState() {
    final bool shouldLock = !isServiceAvailable;

    if (isServiceLockedNotifier.value == shouldLock) return;

    isServiceLockedNotifier.value = shouldLock;

    if (!shouldLock) {
      _flushQueue();
    }
  }

  /// 标记后端为健康
  void _markBackendAsHealthy() {
    if (_isBackendHealthy) return;
    _isBackendHealthy = true;
    _updateLockState();
  }

  /// 标记后端为不健康
  void _markBackendAsUnhealthy() {
    if (!_isBackendHealthy) return;
    _isBackendHealthy = false;
    _updateLockState();
  }

  /// 🚀 释放队列中的请求
  void _flushQueue() {
    if (_pendingByKey.isEmpty) return;

    for (final group in _pendingByKey.values) {
      if (group.released) continue;
      final leader = group.leader;
      if (leader == null) continue;

      group.released = true;
      leader.handler.next(leader.options);
    }
  }

  Response _cloneResponseFor(Response src, RequestOptions ro) {
    return Response(
      requestOptions: ro,
      data: src.data,
      headers: src.headers,
      statusCode: src.statusCode,
      statusMessage: src.statusMessage,
      isRedirect: src.isRedirect,
      redirects: src.redirects,
      extra: src.extra,
    );
  }

  DioException _cloneExceptionFor(DioException src, RequestOptions ro) {
    return DioException(
      requestOptions: ro,
      response: src.response,
      type: src.type,
      error: src.error,
      stackTrace: src.stackTrace,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 应用恢复前台时，主动检查网络状态
      // 这可以解决 connectivity_plus 在 WiFi 重连时不触发回调的问题
      Logger.info('App resumed, checking connectivity...');
      Connectivity().checkConnectivity().then(_handleConnectivityChange);
    }
  }

  // 供拦截器调用：将请求加入等待队列
  @override
  void addPendingRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final key = dedupKey(options);
    final group = _pendingByKey.putIfAbsent(key, () => _PendingGroup(key));

    if (group.leader == null) {
      group.leader = _PendingWaiter(options, handler);
    } else {
      // 重复请求：不再入“真实放行队列”，只作为 follower 等 leader 的结果
      group.followers.add(_PendingWaiter(options, handler));
    }
  }

  @override
  void notifyRequestFailed(DioException err) {
    final key = dedupKey(err.requestOptions);
    final group = _pendingByKey.remove(key);
    if (group == null) return;

    for (final w in group.followers) {
      w.handler.reject(_cloneExceptionFor(err, w.options));
    }
  }

  @override
  void notifyRequestSucceeded(Response response) {
    final key = dedupKey(response.requestOptions);
    final group = _pendingByKey.remove(key);
    if (group == null) return;

    // leader 自己的 response 走正常 handler.next(response)，无需在此处理
    for (final w in group.followers) {
      w.handler.resolve(_cloneResponseFor(response, w.options));
    }
  }

  @override
  void lockService() {
    _markBackendAsUnhealthy();
  }

  @override
  void dispose() {
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    _connectivitySubscription.cancel();
    isServiceLockedNotifier.dispose();
    for (final group in _pendingByKey.values) {
      final all = <_PendingWaiter>[
        if (group.leader != null) group.leader!,
        ...group.followers,
      ];
      for (final w in all) {
        w.handler.reject(
          DioException(
            requestOptions: w.options,
            type: DioExceptionType.cancel,
            error: 'GateKeeperService disposed',
          ),
        );
      }
    }
    _pendingByKey.clear();
  }
}

class _PendingGroup {
  _PendingGroup(this.key);
  final String key;
  _PendingWaiter? leader;
  final List<_PendingWaiter> followers = <_PendingWaiter>[];
  bool released = false;
}

class _PendingWaiter {
  _PendingWaiter(this.options, this.handler);
  final RequestOptions options;
  final RequestInterceptorHandler handler;
}

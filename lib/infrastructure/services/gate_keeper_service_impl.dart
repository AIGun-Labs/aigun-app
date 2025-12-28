import 'dart:async';
import 'dart:collection';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/services/gate_keeper_service.dart';
import '../../utils/logger.dart';
import '../network/utils/gate_kepper_service_util.dart';

class GateKeeperServiceImpl
    with WidgetsBindingObserver
    implements GateKeeperService {
  GateKeeperServiceImpl(String baseUrl) {
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
    _startRecursivePolling();
  }
  @override
  final ValueNotifier<bool> isServiceLockedNotifier = ValueNotifier<bool>(
    false,
  );
  bool _isBackendHealthy = true;
  bool _isDeviceOnline = true;

  @override
  bool get isBackendHealthy => _isBackendHealthy;

  @override
  bool get isDeviceOnline => _isDeviceOnline;

  @override
  bool get isServiceAvailable => _isBackendHealthy && _isDeviceOnline;
  late final Dio _statusCheckDio;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isDisposed = false;
  bool _isPolling = false;
  final String _statusCheckPath = '/api/v1/status';
  final Duration _pollInterval = const Duration(seconds: 3);
  int _consecutiveUnhealthyCount = 0;
  static const int _unhealthyThreshold = 3;

  final LinkedHashMap<String, _PendingGroup> _pendingByKey =
      LinkedHashMap<String, _PendingGroup>();
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final bool currentlyOnline = results.any(
      (r) => r != ConnectivityResult.none && r != ConnectivityResult.bluetooth,
    );

    if (_isDeviceOnline == currentlyOnline) return;

    _isDeviceOnline = currentlyOnline;

    if (currentlyOnline) {
      _checkStatus();
    }
    _updateLockState();
  }

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

  Future<void> _checkStatus() async {
    if (!_isDeviceOnline) return;
    try {
      final response = await _statusCheckDio.get(_statusCheckPath);
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
      Logger.info('App resumed, checking connectivity...');
      Connectivity().checkConnectivity().then(_handleConnectivityChange);
    }
  }

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

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
  final ValueNotifier<bool> isServiceLockedNotifier = ValueNotifier<bool>(
    false,
  );

  bool _isBackendHealthy = true;

  bool _isDeviceOnline = true;

  bool get isBackendHealthy => _isBackendHealthy;

  bool get isDeviceOnline => _isDeviceOnline;

  bool get isServiceAvailable => _isBackendHealthy && _isDeviceOnline;

  final List<_PendingRequest> _pendingQueue = [];

  late final Dio _statusCheckDio;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool _isDisposed = false;

  bool _isPolling = false;

  final String _statusCheckPath = '/api/v1/status';
  final Duration _pollInterval = const Duration(seconds: 3);

  GateKeeperService(String baseUrl) {
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

    _startRecursivePolling();
  }

  void addPendingRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    _pendingQueue.add(_PendingRequest(options, handler));
  }

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

      if (isHealthy) {
        _markBackendAsHealthy();
      } else {
        _markBackendAsUnhealthy();
      }
    } catch (e) {
      _markBackendAsUnhealthy();
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
    if (_pendingQueue.isEmpty) return;

    final requestsToProcess = List<_PendingRequest>.from(_pendingQueue);
    _pendingQueue.clear();

    for (final req in requestsToProcess) {
      req.handler.next(req.options);
    }
  }

  void lockService() {
    _markBackendAsUnhealthy();
  }

  void dispose() {
    _isDisposed = true;
    _connectivitySubscription.cancel();
    isServiceLockedNotifier.dispose();
    _pendingQueue.clear();
  }
}

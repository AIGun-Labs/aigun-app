import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_aigun/core/enums/server_healthy_status.dart';
import 'package:flutter_aigun/cubits/network/network_state.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/services/network/network_service.dart';
import 'package:flutter_aigun/shared/utils/offline_queue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  final NetworkService _networkService;
  final OfflineQueueManager _manager;

  late final StreamSubscription<List<ConnectivityResult>>
      _connectivitySubscription;

  late final Timer _servicesStatusTimer;

  NetworkCubit({
    required OfflineQueueManager manager,
    required Connectivity connectivity,
    required NetworkService networkService,
  })  : _connectivity = connectivity,
        _networkService = networkService,
        _manager = manager,
        super(const NetworkState()) {
    // 立即检查一次初始网络状态
    _checkInitialConnection();

    // 监听后续的网络状态变化
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      result,
    ) {
      _emitConnectivityState(result.first);
    });

    _servicesStatusTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => getServicesStatus(),
    );
  }

  // 检查初始网络状态
  Future<void> _checkInitialConnection() async {
    final result = (await _connectivity.checkConnectivity()).first;
    _emitConnectivityState(result);
  }

  // 发出网络状态变化
  void _emitConnectivityState(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _manager.isConnected = false;
      emit(state.copyWith(isConnected: false));
    } else {
      _manager.isConnected = true;
      _manager.retryAll();
      emit(state.copyWith(isConnected: true));
    }
  }

  Future<void> getServicesStatus() async {
    // 如果网络未连接上就不显示
    if (state.isConnected == false) {
      return;
    }

    try {
      final result = await _networkService.getServicesStatus();

      if (result.status?.value == ServerHealthyStatus.healthy.value) {
        _manager.isConnected = true;
        _manager.retryAll();
        emit(state.copyWith(isServicesHealthy: true));
        return;
      } else {
        _manager.isConnected = false;
        emit(state.copyWith(isServicesHealthy: false));
        return;
      }
    } catch (e, s) {
      SentryService().reportError(e, s, tags: {"feature": "getServicesStatus"});
      emit(state.copyWith(isServicesHealthy: false));
    }
  }

  // 关闭网络状态监听
  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    _servicesStatusTimer.cancel();
    return super.close();
  }

  // 仅用于测试：模拟网络断开
  void simulateDisconnect() {
    _emitConnectivityState(ConnectivityResult.none);
  }

  // 仅用于测试：模拟网络连接
  void simulateConnect() {
    emit(state.copyWith(isServicesHealthy: false));
  }
}

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_aigun/cubits/network/network_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;

  late final StreamSubscription<List<ConnectivityResult>>
      _connectivitySubscription;

  NetworkCubit({required Connectivity connectivity})
      : _connectivity = connectivity,
        super(NetworkInitial()) {
    // 立即检查一次初始网络状态
    _checkInitialConnection();

    // 监听后续的网络状态变化
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      _emitConnectivityState(result.first);
    });
  }

// 检查初始网络状态
  Future<void> _checkInitialConnection() async {
    final result = (await _connectivity.checkConnectivity()).first;
    _emitConnectivityState(result);
  }

// 发出网络状态变化
  void _emitConnectivityState(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      emit(NetworkFailure());
    } else {
      emit(NetworkSuccess(result: result));
    }
  }

// 关闭网络状态监听
  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}

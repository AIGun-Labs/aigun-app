import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_aigun/core/di/module_repo.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/network/network_cubit.dart';
import 'package:flutter_aigun/services/network/network_service.dart';
import 'package:flutter_aigun/shared/utils/offline_queue.dart';
import 'package:get_it/get_it.dart';

class NetworkModule implements InjectionModule {
  final GetIt _sl;

  NetworkModule(this._sl);

  @override
  Future<void> init() async {
    // 立即创建并注册实例
    _sl.registerSingleton<NetworkService>(NetworkService());
    _sl.registerSingleton<NetworkCubit>(NetworkCubit(
        connectivity: Connectivity(),
        networkService: _sl<NetworkService>(),
        manager: _sl<OfflineQueueManager>()));
  }
}

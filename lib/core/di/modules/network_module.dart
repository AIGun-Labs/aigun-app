import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../../../cubits/network/network_cubit.dart';
import '../../../services/network/network_service.dart';
import '../module_repo.dart';

class NetworkModule implements InjectionModule {
  final GetIt _sl;

  NetworkModule(this._sl);

  @override
  Future<void> init() async {
    // 立即创建并注册实例
    _sl.registerSingleton(NetworkService(_sl()));
    _sl.registerSingleton(NetworkCubit(
        connectivity: Connectivity(), networkService: _sl(), manager: _sl()));
  }
}

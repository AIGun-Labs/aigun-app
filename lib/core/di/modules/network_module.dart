import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../config/app_config.dart';
import '../../../features/anti_spider/domain/anti_spider/anti_spider_service.dart';
import '../../../features/anti_spider/infrastructure/network/anti_spider_key_service_impl.dart';
import '../../../infrastructure/network/dio_client.dart';
import '../../../infrastructure/network/domain/domain_service.dart';
import '../../../infrastructure/network/error/app_error_handler.dart';
import '../../../infrastructure/services/gate_keeper_service_impl.dart';
import '../../../infrastructure/services/logger_service_impl.dart';
import '../../services/gate_keeper_service.dart';
import '../../services/logger_service.dart';
import '../module_repo.dart';

class NetworkModule implements InjectionModule {
  NetworkModule(this._sl, {required this.enableNetworkLog});
  final GetIt _sl;
  final bool enableNetworkLog;

  @override
  Future<void> init() async {
    String baseUrl;
    try {
      baseUrl = await DomainService.pickFastestDomain();
    } catch (e) {
      baseUrl = AppConfig().env.baseApiUrl;
    }
    debugPrint('baseUrl: $baseUrl');
    _sl.registerSingleton<LoggerService>(LoggerServiceImpl());
    _sl.registerSingleton<GateKeeperService>(GateKeeperServiceImpl(baseUrl));
    _sl.registerSingleton<AntiSpiderKeyService>(AntiSpiderKeyServiceImpl());
    _sl.registerSingleton<AppErrorHandler>(AppErrorHandler(_sl()));

    _sl.registerSingleton(
      DioClient(
        _sl(),
        _sl(),
        _sl(),
        _sl(),
        _sl(),
        baseUrl: baseUrl,
        enableNetworkLog: enableNetworkLog,
      ),
    );
  }
}

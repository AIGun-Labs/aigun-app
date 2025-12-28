import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../features/anti_spider/domain/anti_spider/anti_spider_service.dart';
import '../../features/anti_spider/infrastructure/network/anti_spider_key_service_impl.dart';
import '../../infrastructure/network/dio_client.dart';
import '../../infrastructure/network/domain/domain_service.dart';
import '../../infrastructure/network/error/app_error_handler.dart';
import '../../infrastructure/services/gate_keeper_service_impl.dart';
import '../../infrastructure/services/logger_service_impl.dart';
import '../services/gate_keeper_service.dart';
import '../services/logger_service.dart';
import 'modules/auth_module.dart';
import 'modules/candlestick_module.dart';
import 'modules/chain_module.dart';
import 'modules/collect_module.dart';
import 'modules/dynamic_tabs_module.dart';
import 'modules/intelligence_module.dart';
import 'modules/invite_module.dart';
import 'modules/language_module.dart';
import 'modules/token_detail_module.dart';
import 'modules/trending_module.dart';
import 'modules/update_module.dart';

final newGetIt = GetIt.instance;
Future<void> initCore() async {
  newGetIt.registerLazySingleton(() => const FlutterSecureStorage());
  String baseUrl;
  try {
    baseUrl = await DomainService.pickFastestDomain();
  } catch (e) {
    baseUrl = AppConfig().env.baseApiUrl;
  }

  newGetIt.registerSingleton<GateKeeperService>(GateKeeperServiceImpl(baseUrl));
  newGetIt.registerSingleton<LoggerService>(LoggerServiceImpl());
  newGetIt.registerSingleton<AntiSpiderKeyService>(AntiSpiderKeyServiceImpl());
  newGetIt.registerSingleton<AppErrorHandler>(AppErrorHandler(newGetIt()));
  newGetIt.registerSingleton(
    DioClient(
      newGetIt(),
      newGetIt(),
      newGetIt(),
      newGetIt(),
      newGetIt(),
      baseUrl: baseUrl,
      enableNetworkLog: true,
    ),
  );

  LanguageModule(newGetIt).init();

  UpdateModule(newGetIt).init();
  TrendingModule(newGetIt).init();
  InviteModule(newGetIt).init();
  CollectModule(newGetIt).init();
  TokenDetailModule(newGetIt).init();
  ChainModule(newGetIt).init();
  CandlestickModule(newGetIt).init();

  IntelligenceModule(newGetIt).init();

  AuthModule(newGetIt).init();
  DynamicTabsModule(newGetIt).init();
}

Future reset() async {
  newGetIt.reset();
}

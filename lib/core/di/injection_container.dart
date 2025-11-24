import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../network/dio_client.dart';
import '../network/domain/domain_service.dart';
import '../network/gateKeeper/service_gateKeeper.dart';
import 'modules/ai_agent_module.dart';
import 'modules/collect_module.dart' show CollectModule;
import 'modules/invite_module.dart';
import 'modules/network_module.dart';
import 'modules/trending_module.dart';
import 'modules/update_module.dart';

/// TODO: 待重构，先使用 service_locator.dart 中的 getIt
final newGetIt = GetIt.instance;
Future<void> initCore() async {
  // 注册 secure storage
  newGetIt.registerLazySingleton(() => const FlutterSecureStorage());

  // 注册 bestUrl
  String baseUrl;
  try {
    baseUrl = await DomainService.pickFastestDomain();
  } catch (e) {
    baseUrl = AppConfig().env.baseApiUrl;
  }

  newGetIt.registerSingleton(ServiceGatekeeper(baseUrl));

  // 注册 DioClient (单例)，将选中的 URL 注入进去
  newGetIt.registerSingleton(
      NewDioClient(newGetIt(), newGetIt(), baseUrl: baseUrl));

  UpdateModule(newGetIt).init();
  AiAgentModule(newGetIt).init();
  TrendingModule(newGetIt).init();
  NetworkModule(newGetIt).init();
  InviteModule(newGetIt).init();
  CollectModule(newGetIt).init();
}

Future reset() async {
  newGetIt.reset();
}

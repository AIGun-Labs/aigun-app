import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../data/services/index.dart';
import '../utils/storage/local/permission_storage.dart';
import '../utils/storage/local/settings_storage.dart';
import '../utils/storage/local/trade_setting.dart';
import '../utils/storage/secure/secure_storage_service.dart';
import '../utils/storage/secure/token_storage_service.dart';
import '../utils/storage/share_preferences_service.dart';
import 'api_locator.dart';
import 'cubit_locator.dart';
import 'network/domain/domain_service.dart';
import 'network/gatekeeper/gate_keeper_service.dart';

final getIt = GetIt.instance;

Future<void> setupCoreServices() async {
  String baseUrl;
  try {
    baseUrl = await DomainService.pickFastestDomain();
  } catch (e) {
    baseUrl = AppConfig.baseApiUrl;
  }

  print('using baseUrl: $baseUrl');
  getIt.registerSingleton(GateKeeperService(baseUrl));

  getIt.registerSingleton(DioClient(getIt(), baseUrl: baseUrl));

  getIt.registerSingleton(ErrorHandler(getIt()));

  await setupServiceLocator();
}

Future<void> setupServiceLocator() async {
  setupApi();

  await setupServices();

  setupCubits();
}

Future<void> setupServices() async {
  final sharePreferencesService = await SharePreferencesService.getInstance();
  getIt.registerSingleton(sharePreferencesService);

  getIt.registerSingleton(await SharedPreferences.getInstance());

  getIt.registerSingleton(const FlutterSecureStorage());

  getIt.registerSingleton(SettingsStorage(getIt()));

  getIt.registerLazySingleton(() => SecureStorageService(getIt()));

  getIt.registerLazySingleton(() => TokenStorageService(getIt()));

  getIt<DioClient>().initRefreshInterceptor(getIt());

  getIt.registerLazySingleton(() => TradeSettingStorage(getIt()));

  getIt.registerLazySingleton(() => PermissionStorage(getIt()));
}

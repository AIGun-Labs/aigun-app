import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/env/env.dart';
import '../data/services/index.dart';
import '../data/services/sentry_service.dart';
import '../utils/storage/local/permission_storage.dart';
import '../utils/storage/local/settings_storage.dart';
import '../utils/storage/local/token_swap_storage.dart';
import '../utils/storage/local/trade_setting.dart';
import '../utils/storage/local/wallet_storage.dart';
import '../utils/storage/secure/secure_storage_service.dart';
import '../utils/storage/secure/token_storage_service.dart';
import '../utils/storage/secure/user_storage_service.dart';
import '../utils/storage/share_preferences_service.dart';
import 'api_locator.dart';
import 'cubit_locator.dart';
import 'di/modules/collect_module.dart';
import 'di/modules/invite_module.dart';
import 'di/modules/trending_module.dart';
import 'di/modules/update_module.dart';
import 'network/domain/domain_service.dart';
import 'network/gatekeeper/gate_keeper_service.dart';

final getIt = GetIt.instance;

/// 核心服务初始化 - 应用启动时必须
Future<void> setupCoreServices() async {
  // 注册 bestUrl
  String baseUrl;
  try {
    baseUrl = await DomainService.pickFastestDomain();
  } catch (e) {
    baseUrl = EnvConfig().baseApiUrl;
  }

  print('using baseUrl: $baseUrl');
  getIt.registerSingleton(GateKeeperService(baseUrl));

  getIt.registerSingleton(DioClient(getIt(), baseUrl: baseUrl));

  getIt.registerSingleton(ErrorHandler(getIt()));

  // 初始化服务定位器（包括异步服务如 SettingsStorage）
  await setupServiceLocator();
}

/// 非核心服务使用懒加载
Future<void> setupServiceLocator() async {
  // 先设置API服务（同步）
  setupApi();

  // 等待异步服务初始化完成
  await setupServices();

  // 设置Cubits（现在所有依赖都已准备好）
  setupCubits();

  // 设置更新模块
  UpdateModule(getIt).init();

  // 设置Trending模块
  TrendingModule(getIt).init();

  // 设置Invite模块
  InviteModule(getIt).init();

  //设置Collect模块
  CollectModule(getIt).init();
}

Future<void> setupServices() async {
  //有问题需要重构
  //注册 SharePreferencesService
  final sharePreferencesService = await SharePreferencesService.getInstance();
  getIt.registerSingleton(sharePreferencesService);

  //注册 SharedPreferences
  getIt.registerSingleton(await SharedPreferences.getInstance());

  //注册 FlutterSecureStorage
  getIt.registerSingleton(const FlutterSecureStorage());

  // 预先初始化 SettingsStorage，确保 BalanceCubit 依赖可用
  getIt.registerSingleton(SettingsStorage(getIt()));

  // 注册其他同步服务
  getIt.registerLazySingleton(() => SecureStorageService(getIt()));

  getIt.registerLazySingleton(() => UserStorageService(getIt()));

  getIt.registerLazySingleton(() => TokenStorageService(getIt()));

  // 在TokenStorageService注册后初始化RefreshInterceptor
  getIt<DioClient>().initRefreshInterceptor(getIt());

  getIt.registerLazySingleton(() => WalletStorage(getIt()));

  getIt.registerLazySingleton(() => TradeSettingStorage(getIt()));

  getIt.registerLazySingleton(() => TokenSwapStorage(getIt())..init());

  getIt.registerLazySingleton(() => PermissionStorage(getIt()));

  getIt.registerLazySingleton(() => SentryService());
}

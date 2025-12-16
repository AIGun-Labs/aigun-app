import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../data/services/sentry_service.dart';
import '../features/anti_spider/domain/anti_spider/anti_spider_service.dart';
import '../features/anti_spider/infrastructure/network/anti_spider_key_service_impl.dart';
import '../infrastructure/network/dio_client.dart';
import '../infrastructure/network/domain/domain_service.dart';
import '../infrastructure/network/error/app_error_handler.dart';
import '../infrastructure/services/gate_keeper_service_impl.dart';
import '../infrastructure/services/logger_service_impl.dart';
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
import 'di/modules/auth_module.dart';
import 'di/modules/candlestick_module.dart';
import 'di/modules/chain_module.dart';
import 'di/modules/collect_module.dart';
import 'di/modules/dynamic_tabs_module.dart';
import 'di/modules/intelligence_module.dart';
import 'di/modules/invite_module.dart';
import 'di/modules/language_module.dart';
import 'di/modules/swap_module.dart';
import 'di/modules/token_detail_module.dart';
import 'di/modules/trending_module.dart';
import 'di/modules/update_module.dart';
import 'services/gate_keeper_service.dart';
import 'services/logger_service.dart';

final getIt = GetIt.instance;

/// 核心服务初始化 - 应用启动时必须
Future<void> setupCoreServices() async {
  // 注册 bestUrl
  String baseUrl;
  try {
    baseUrl = await DomainService.pickFastestDomain();
  } catch (e) {
    baseUrl = AppConfig().env.baseApiUrl;
  }
  debugPrint('baseUrl: $baseUrl');
  getIt.registerSingleton<LoggerService>(LoggerServiceImpl());
  getIt.registerSingleton<GateKeeperService>(GateKeeperServiceImpl(baseUrl));
  getIt.registerSingleton<AntiSpiderKeyService>(AntiSpiderKeyServiceImpl());
  getIt.registerSingleton<AppErrorHandler>(AppErrorHandler(getIt()));

  getIt.registerSingleton(
    DioClient(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      baseUrl: baseUrl,
      enableNetworkLog: true,
    ),
  );

  // getIt.registerSingleton(ErrorHandler(getIt()));

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

  LanguageModule(getIt).init();

  // 设置更新模块
  UpdateModule(getIt).init();

  // 设置Trending模块
  TrendingModule(getIt).init();

  // 设置Invite模块
  InviteModule(getIt).init();

  //设置Collect模块
  CollectModule(getIt).init();

  SwapModule(getIt).init();
  //设置TokenDetail模块
  TokenDetailModule(getIt).init();

  ChainModule(getIt).init();

  IntelligenceModule(getIt).init();

  AuthModule(getIt).init();

  CandlestickModule(getIt).init();

  //设置DynamicTabs模块
  DynamicTabsModule(getIt).init();
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

  getIt.registerLazySingleton(() => WalletStorage(getIt()));

  getIt.registerLazySingleton(() => TradeSettingStorage(getIt()));

  getIt.registerLazySingleton(() => TokenSwapStorage(getIt())..init());

  getIt.registerLazySingleton(() => PermissionStorage(getIt()));

  getIt.registerLazySingleton(SentryService.new);
}

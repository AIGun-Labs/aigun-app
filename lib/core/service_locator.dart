import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/models/queued_request/queued_request.dart';
import '../data/models/queued_request/queued_request_adapter.dart';
import '../data/services/index.dart';
import '../data/services/sentry_service.dart';
import '../shared/utils/offline_queue.dart';
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
import 'di/modules/ai_agent_module.dart';
import 'di/modules/invite_module.dart';
import 'di/modules/network_module.dart';
import 'di/modules/trending_module.dart';
import 'di/modules/update_module.dart';

final getIt = GetIt.instance;

/// 核心服务初始化 - 应用启动时必须
Future<void> setupCoreServices() async {
  // 初始化Dio（暂不添加拦截器）
  final dioClient = DioClient();
  // 注册 Hive TypeAdapter（如未注册）
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(QueuedRequestAdapter());
  }
  final queueBox = await Hive.openBox<QueuedRequest>("offline_queue");
  final queueManager = OfflineQueueManager(dio: dioClient.dio, box: queueBox);

  // 先注册离线队列管理器，确保拦截器取用时已可用
  getIt.registerSingleton<OfflineQueueManager>(queueManager);

  // 现在初始化 Dio（此时拦截器读取的 OfflineQueueManager 已注册）
  dioClient.init();

  // 只注册真正需要立即初始化的核心服务
  getIt.registerSingleton<DioClient>(dioClient);
  getIt.registerSingleton<Dio>(dioClient.dio);
  getIt.registerSingleton<ErrorHandler>(ErrorHandler(dioClient));

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

  // Initialize TradeSettingCubit after all cubits are registered to avoid circular dependency

  NetworkModule(getIt).init();

  // 设置更新模块
  UpdateModule(getIt).init();

  // 设置AI特工模块
  AiAgentModule(getIt).init();

  // 设置Trending模块
  TrendingModule(getIt).init();

  // 设置Invite模块
  InviteModule(getIt).init();
}

Future<void> setupServices() async {
  // 初始化 SharePreferencesService
  final sharePreferencesService = await SharePreferencesService.getInstance();
  getIt.registerSingleton<SharePreferencesService>(sharePreferencesService);

  // 预先初始化 SettingsStorage，确保 BalanceCubit 依赖可用
  final settingsStorage = await SettingsStorage.create();
  getIt.registerSingleton<SettingsStorage>(settingsStorage);

  // 注册其他同步服务
  getIt.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService());
  getIt.registerLazySingleton<UserStorageService>(() => UserStorageService());
  getIt.registerLazySingleton<TokenStorageService>(() => TokenStorageService());
  getIt.registerLazySingleton<WalletStorage>(() => WalletStorage());
  getIt.registerLazySingleton<TradeSettingStorage>(() => TradeSettingStorage());
  getIt.registerLazySingleton<TokenSwapStorage>(() {
    TokenSwapStorage().init();
    return TokenSwapStorage();
  });
  getIt.registerLazySingleton<PermissionStorage>(() => PermissionStorage());
  getIt.registerLazySingleton<SentryService>(() => SentryService());
}

import 'package:dio/dio.dart';
import 'package:flutter_aigun/core/api_locator.dart';
import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/utils/storage/local/settings_storage.dart';
import 'package:flutter_aigun/utils/storage/local/token_swap_storage.dart';
import 'package:flutter_aigun/utils/storage/local/trade_setting.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/storage/secure/secure_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/token_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/user_storage_service.dart';
import 'package:flutter_aigun/utils/storage/share_preferences_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// 核心服务初始化 - 应用启动时必须
Future<void> setupCoreServices() async {
  // 初始化环境变量
  // EnvConfig 使用单例模式，不需要初始化

  // 初始化服务定位器（包括异步服务如 SettingsStorage）
  await setupServiceLocator();

  // 初始化Dio
  final DioClient dioClient = DioClient()..init();

  // 只注册真正需要立即初始化的核心服务
  getIt.registerLazySingleton<DioClient>(() => DioClient()..init());
  getIt.registerLazySingleton<Dio>(() => dioClient.dio);
  getIt.registerLazySingleton<ErrorHandler>(() => ErrorHandler(dioClient));
}

/// 非核心服务使用懒加载
Future<void> setupServiceLocator() async {
  // 先设置API服务（同步）
  setupApi();

  // 等待异步服务初始化完成
  await setupServices();

  // 设置Cubits（现在所有依赖都已准备好）
  setupCubits();
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

  getIt.registerLazySingleton<SentryService>(() => SentryService());
}

import 'package:dio/dio.dart';
import 'package:flutter_aigun/config/env.dart';
import 'package:flutter_aigun/core/api_locator.dart';
import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/utils/storage/local/settings_storage.dart';
import 'package:flutter_aigun/utils/storage/local/trade_setting.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/storage/secure/secure_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/token_storage_service.dart';
import 'package:flutter_aigun/utils/storage/secure/user_storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// 核心服务初始化 - 应用启动时必须
Future<void> setupCoreServices() async {
  // 初始化环境变量
  Env.initialize();

  // 初始化服务定位器
  setupServiceLocator();

  // 初始化Dio
  final DioClient dioClient = DioClient()..init();

  // 只注册真正需要立即初始化的核心服务
  getIt.registerLazySingleton<Dio>(() => dioClient.dio);
  getIt.registerLazySingleton<ErrorHandler>(() => ErrorHandler(dioClient));
}

/// 非核心服务使用懒加载
void setupServiceLocator() {
  setupApi();
  setupCubits();
  setupServices();
}

void setupServices() {
  getIt.registerSingletonAsync<SettingsStorage>(() async {
    return await SettingsStorage.create();
  });

  getIt.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService());
  getIt.registerLazySingleton<UserStorageService>(() => UserStorageService());
  getIt.registerLazySingleton<TokenStorageService>(() => TokenStorageService());
  getIt.registerLazySingleton<WalletStorage>(() => WalletStorage());
  getIt.registerLazySingleton<DioClient>(() => DioClient()..init());
  getIt.registerLazySingleton<TradeSettingStorage>(() => TradeSettingStorage());
}

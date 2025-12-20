import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/services/api/chain_api.dart';
import '../data/services/api/intel_api.dart';
import '../data/services/api/option_api.dart';
import '../data/services/api/query_token.dart';
import '../data/services/api/token_api.dart';
import '../data/services/api/trade_api.dart';
import '../data/services/api/transfer_api.dart';
import '../data/services/api/user_api.dart';
import '../data/services/api/wallet_api.dart';
import '../data/services/api/wallet_transaction.dart';
import '../data/services/sentry_service.dart';
import '../infrastructure/services/secure_token_storage_service_impl.dart';
import '../infrastructure/services/secure_user_storage_service_impl.dart';
import '../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../utils/storage/local/permission_storage.dart';
import '../utils/storage/local/settings_storage.dart';
import '../utils/storage/local/token_swap_storage.dart';
import '../utils/storage/local/trade_setting.dart';
import '../utils/storage/local/wallet_storage.dart';
import 'cubit_locator.dart';
import 'di/modules/auth_module.dart';
import 'di/modules/candlestick_module.dart';
import 'di/modules/chain_module.dart';
import 'di/modules/collect_module.dart';
import 'di/modules/dynamic_tabs_module.dart';
import 'di/modules/intelligence_module.dart';
import 'di/modules/invite_module.dart';
import 'di/modules/language_module.dart';
import 'di/modules/network_module.dart';
import 'di/modules/swap_module.dart';
import 'di/modules/token_detail_module.dart';
import 'di/modules/trending_module.dart';
import 'di/modules/update_module.dart';
import 'services/secure_token_storage_service.dart';
import 'services/secure_user_storage_service.dart';

final getIt = GetIt.instance;

/// 核心服务初始化 - 应用启动时必须
Future<void> setupCoreServices({required bool enableNetworkLog}) async {
  // 等待异步服务初始化完成
  await setupLocalStorageServices();

  // 初始化用户核心服务
  final userCubit = NewUserCubit(getIt(), getIt());
  await userCubit.init();
  getIt.registerSingleton(userCubit);

  // 初始化网络模块
  await NetworkModule(getIt, enableNetworkLog: enableNetworkLog).init();

  setupApiServices();

  setupCubits();

  await setupServiceLocator();
}

/// 非核心服务使用懒加载
Future<void> setupServiceLocator() async {
  // 设置语言模块
  LanguageModule(getIt).init();
  // 设置Auth模块
  AuthModule(getIt).init();

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

  CandlestickModule(getIt).init();

  //设置DynamicTabs模块
  DynamicTabsModule(getIt).init();
}

void setupApiServices() {
  getIt.registerLazySingleton(() => WalletApi(getIt(), getIt()));

  getIt.registerLazySingleton(() => UserApi(getIt()));

  getIt.registerLazySingleton(() => ChainApi(getIt()));

  getIt.registerLazySingleton(() => TransferApi(getIt()));

  getIt.registerLazySingleton(() => WalletTransactionApi(getIt()));

  getIt.registerLazySingleton(() => IntelApi(getIt()));

  getIt.registerLazySingleton(() => TradeApi(getIt()));

  getIt.registerLazySingleton(() => TokenApi(getIt()));

  getIt.registerLazySingleton(() => OptionsApi(getIt()));

  getIt.registerLazySingleton(() => QueryTokenApi(getIt()));
}

Future<void> setupLocalStorageServices() async {
  //注册 SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  //注册 FlutterSecureStorage
  getIt.registerSingleton(const FlutterSecureStorage());

  // 预先初始化 SettingsStorage，确保 BalanceCubit 依赖可用
  getIt.registerSingleton(SettingsStorage(getIt()));

  final secureUserStorageService = SecureUserStorageServiceImpl(getIt());
  await secureUserStorageService.migrateUser();
  getIt.registerSingleton<SecureUserStorageService>(secureUserStorageService);

  getIt.registerSingleton<SecureTokenStorageService>(
    SecureTokenStorageServiceImpl(getIt()),
  );

  getIt.registerLazySingleton(() => WalletStorage(getIt()));

  getIt.registerLazySingleton(() => TradeSettingStorage(getIt()));

  final tokenSwapStorage = TokenSwapStorage(getIt());
  await tokenSwapStorage.init();
  getIt.registerSingleton(tokenSwapStorage);

  getIt.registerLazySingleton(() => PermissionStorage(getIt()));

  getIt.registerLazySingleton(SentryService.new);
}

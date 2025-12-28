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
Future<void> setupCoreServices({required bool enableNetworkLog}) async {
  await setupLocalStorageServices();
  final userCubit = NewUserCubit(getIt(), getIt());
  await userCubit.init();
  getIt.registerSingleton(userCubit);
  await NetworkModule(getIt, enableNetworkLog: enableNetworkLog).init();

  setupApiServices();

  setupCubits();

  await setupServiceLocator();
}

Future<void> setupServiceLocator() async {
  LanguageModule(getIt).init();
  AuthModule(getIt).init();
  UpdateModule(getIt).init();
  TrendingModule(getIt).init();
  InviteModule(getIt).init();
  CollectModule(getIt).init();

  SwapModule(getIt).init();
  TokenDetailModule(getIt).init();

  ChainModule(getIt).init();

  IntelligenceModule(getIt).init();

  CandlestickModule(getIt).init();
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
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton(const FlutterSecureStorage());
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

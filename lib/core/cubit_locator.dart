import 'package:flutter_aigun/cubits/auth/auth_cubit.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/data/services/api/token_api.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/utils/storage/local/settings_storage.dart';
import 'package:flutter_aigun/utils/storage/local/trade_setting.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupCubits() {
  // BalanceCubit 现在可以安全地同步创建，因为 SettingsStorage 已经在 main() 中预初始化了
  getIt.registerLazySingleton<BalanceCubit>(
      () => BalanceCubit(getIt<WalletCubit>(), getIt<SettingsStorage>()));

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());
  getIt.registerLazySingleton<SearchTokenCubit>(
      () => SearchTokenCubit(getIt<TokenApi>(), getIt<TradeCubit>()));

  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<UserCubit>(() => UserCubit());

  getIt.registerLazySingleton<WalletCubit>(
      () => WalletCubit(getIt<UserCubit>()));

  getIt.registerLazySingleton(() => ChainCubit(getIt<UserCubit>()));

  getIt.registerLazySingleton(() => ForgotPasswordCubit());

  getIt.registerLazySingleton(() => SignUpCubit());

  getIt.registerLazySingleton(() => TransferCubit());
  getIt.registerLazySingleton(() => MonitorGroupCubit());
  getIt.registerLazySingleton(() => MonitorCubit());
  getIt.registerLazySingleton(() => LanguageCubit());

  getIt.registerLazySingleton(() => SwapCubit());
  getIt.registerLazySingleton(() => IntelCubit());
  getIt.registerLazySingleton(() => TradeCubit(
      getIt<BalanceCubit>(), getIt<TradeSettingCubit>(), getIt<TokenApi>()));
  getIt.registerLazySingleton(
      () => TradeSettingCubit(getIt<TradeSettingStorage>()));
  getIt.registerLazySingleton(() => QuickTradeCubit(
      getIt<TradeApi>(),
      getIt<TradeSettingCubit>(),
      getIt<WalletStorage>(),
      getIt<BalanceCubit>()));
  getIt.registerLazySingleton(() => TrendingCubit(getIt<TrendingApi>()));
}

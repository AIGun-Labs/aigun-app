import '../cubits/auth/auth_cubit.dart';
import '../cubits/candle/candle_cubit.dart';
import '../cubits/index.dart';
import '../cubits/language/language_cubit.dart';
import '../cubits/options/option_cubit.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';
import '../data/services/api/candle_api.dart';
import '../data/services/api/index.dart';
import '../data/services/api/option_api.dart';
import '../data/services/api/token_api.dart';
import '../data/services/index.dart';
import '../utils/storage/local/settings_storage.dart';
import '../utils/storage/local/wallet_storage.dart';
import 'service_locator.dart';

void setupCubits() {
  getIt.registerSingleton<UserCubit>(UserCubit(getIt())..init());
  getIt.registerSingleton<AuthCubit>(AuthCubit());
  getIt.registerLazySingleton<BalanceCubit>(
      () => BalanceCubit(getIt<WalletCubit>(), getIt<SettingsStorage>()));

  getIt.registerLazySingleton<SearchTokenCubit>(
      () => SearchTokenCubit(getIt<TokenApi>(), getIt<TradeCubit>()));

  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt()));

  getIt.registerLazySingleton<WalletCubit>(
      () => WalletCubit(getIt<UserCubit>()));

  getIt.registerLazySingleton(() => ChainCubit(getIt<UserCubit>()));

  getIt.registerLazySingleton(() => ForgotPasswordCubit());

  getIt.registerLazySingleton(() => SignUpCubit());

  getIt.registerLazySingleton(
      () => TransferCubit(getIt(), getIt(), getIt())..init());
  getIt.registerLazySingleton(() => MonitorGroupCubit());
  getIt.registerLazySingleton(() => MonitorCubit());
  getIt.registerLazySingleton(() => LanguageCubit());

  getIt.registerLazySingleton(() => SwapCubit());
  getIt.registerLazySingleton(
      () => IntelCubit(optionsCubit: getIt<OptionsCubit>()));
  getIt.registerLazySingleton(() => TradeCubit(
      getIt<BalanceCubit>(),
      getIt<TradeSettingCubit>(),
      getIt<TokenApi>(),
      getIt<TradeApi>(),
      getIt<WalletStorage>()));
  getIt.registerLazySingleton(() => TradeSettingCubit(getIt(), getIt()));
  getIt.registerLazySingleton(() => QuickTradeCubit(
      getIt<TradeApi>(),
      getIt<TradeSettingCubit>(),
      getIt<WalletStorage>(),
      getIt<BalanceCubit>()));
  getIt.registerLazySingleton(() => TrendingCubit(getIt<TrendingApi>()));
  getIt.registerLazySingleton(() => CandleCubit(getIt<CandleApi>()));
  getIt.registerLazySingleton(() => TokenDetailCubit(getIt<CandleCubit>()));

  getIt.registerLazySingleton(() => QueryTokenCubit());

  getIt.registerLazySingleton(() => SoundEffectCubit());

  getIt.registerLazySingleton(() => OptionsCubit(getIt<OptionsApi>()));
}

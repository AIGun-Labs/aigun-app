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
import '../utils/storage/local/trade_setting.dart';
import '../utils/storage/local/wallet_storage.dart';
import 'service_locator.dart';

void setupCubits() {
  // BalanceCubit 现在可以安全地同步创建，因为 SettingsStorage 已经在 main() 中预初始化了
  // UserCubit 和 AuthCubit 的构造函数是同步的,可以直接注册为 Singleton
  // 先注册 UserCubit，因为 AuthCubit 依赖它
  getIt.registerSingleton<UserCubit>(UserCubit());
  getIt.registerSingleton<AuthCubit>(AuthCubit());
  getIt.registerLazySingleton<BalanceCubit>(
      () => BalanceCubit(getIt<WalletCubit>(), getIt<SettingsStorage>()));

  getIt.registerLazySingleton<SearchTokenCubit>(
      () => SearchTokenCubit(getIt<TokenApi>(), getIt<TradeCubit>()));

  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt()));

  // WalletCubit 和 ChainCubit 依赖 UserCubit，但因为是 LazySingleton，
  // 只要在首次访问时 UserCubit 已经准备好即可
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
  getIt.registerLazySingleton(
      () => IntelCubit(optionsCubit: getIt<OptionsCubit>()));
  getIt.registerLazySingleton(() => TradeCubit(
      getIt<BalanceCubit>(),
      getIt<TradeSettingCubit>(),
      getIt<TokenApi>(),
      getIt<TradeApi>(),
      getIt<WalletStorage>()));
  getIt.registerLazySingleton(
      () => TradeSettingCubit(getIt<TradeSettingStorage>()));
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

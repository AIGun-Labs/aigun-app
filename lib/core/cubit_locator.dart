import '../cubits/auth/auth_cubit.dart';
import '../cubits/candle/candle_cubit.dart';
import '../cubits/index.dart';
import '../cubits/language/language_cubit.dart';
import '../cubits/options/option_cubit.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';
import 'service_locator.dart';

void setupCubits() {
  // BalanceCubit 现在可以安全地同步创建，因为 SettingsStorage 已经在 main() 中预初始化了
  // UserCubit 和 AuthCubit 的构造函数是同步的,可以直接注册为 Singleton
  // 先注册 UserCubit，因为 AuthCubit 依赖它
  getIt.registerSingleton(UserCubit(getIt())..init());
  getIt.registerSingleton(AuthCubit(getIt(), getIt()));
  getIt.registerLazySingleton(() => BalanceCubit(getIt(), getIt()));

  getIt.registerLazySingleton(() => SearchTokenCubit(getIt(), getIt()));

  getIt.registerLazySingleton(() => ThemeCubit(getIt()));

  // WalletCubit 和 ChainCubit 依赖 UserCubit，但因为是 LazySingleton，
  // 只要在首次访问时 UserCubit 已经准备好即可
  getIt.registerLazySingleton(() => WalletCubit(getIt()));

  getIt.registerLazySingleton(() => ChainCubit(getIt()));

  getIt.registerLazySingleton(() => ForgotPasswordCubit());

  getIt.registerLazySingleton(() => SignUpCubit());

  getIt.registerLazySingleton(() => TransferCubit(getIt(), getIt())..init());
  getIt.registerLazySingleton(() => LanguageCubit());

  getIt.registerLazySingleton(() => SwapCubit());
  getIt.registerLazySingleton(() => IntelCubit(optionsCubit: getIt()));

  getIt.registerLazySingleton<TradeSettingCubit>(
    () => TradeSettingCubit(getIt())..init(),
  );

  getIt.registerLazySingleton(
    () => TradeCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(
    () => QuickTradeCubit(getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(() => CandleCubit(getIt()));
  getIt.registerLazySingleton(() => TokenDetailCubit(getIt()));

  getIt.registerLazySingleton(() => QueryTokenCubit(getIt(), getIt()));

  getIt.registerLazySingleton(() => SoundEffectCubit());
  getIt.registerLazySingleton(() => OptionsCubit(getIt()));
}

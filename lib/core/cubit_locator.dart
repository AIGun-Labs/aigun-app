import '../cubits/index.dart';
import '../cubits/options/option_cubit.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';
import 'service_locator.dart';

void setupCubits() {
  // BalanceCubit 现在可以安全地同步创建，因为 SettingsStorage 已经在 main() 中预初始化了
  getIt.registerLazySingleton(() => BalanceCubit(getIt(), getIt()));

  getIt.registerLazySingleton(() => SearchTokenCubit(getIt(), getIt()));

  getIt.registerLazySingleton(() => ThemeCubit(getIt()));

  // WalletCubit 和 ChainCubit 依赖 UserCubit，但因为是 LazySingleton，
  // 只要在首次访问时 UserCubit 已经准备好即可
  getIt.registerLazySingleton(() => WalletCubit(getIt()));

  getIt.registerLazySingleton(() => ChainCubit(getIt()));

  getIt.registerLazySingleton(() => TransferCubit(getIt(), getIt())..init());
  getIt.registerLazySingleton(SwapCubit.new);
  getIt.registerLazySingleton(() => IntelCubit(optionsCubit: getIt()));

  getIt.registerLazySingleton<TradeSettingCubit>(
    () => TradeSettingCubit(getIt(), getIt())..init(),
  );

  getIt.registerLazySingleton(
    () => TradeCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(
    () => QuickTradeCubit(getIt(), getIt(), getIt(), getIt())..initialize(),
  );

  getIt.registerLazySingleton(() => QueryTokenCubit(getIt(), getIt()));

  getIt.registerLazySingleton(() => SoundEffectCubit()..init());
  getIt.registerLazySingleton(() => OptionsCubit(getIt()));
}

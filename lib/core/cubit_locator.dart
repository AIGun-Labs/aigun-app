import '../cubits/index.dart';
import '../cubits/options/option_cubit.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';
import 'service_locator.dart';

void setupCubits() {
  getIt.registerLazySingleton(() => BalanceCubit(getIt(), getIt()));

  getIt.registerLazySingleton(() => SearchTokenCubit(getIt(), getIt()));

  getIt.registerLazySingleton(() => ThemeCubit(getIt()));
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

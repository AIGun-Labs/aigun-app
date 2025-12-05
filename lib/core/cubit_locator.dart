import '../cubits/candle/candle_cubit.dart';
import '../cubits/index.dart';
import '../cubits/language/language_cubit.dart';
import '../cubits/options/option_cubit.dart';
import '../cubits/sound_effect/sound_effect_cubit.dart';
import 'service_locator.dart';

void setupCubits() {
  getIt.registerLazySingleton(() => ThemeCubit(getIt()));

  getIt.registerLazySingleton(() => LanguageCubit());

  getIt.registerLazySingleton(() => IntelCubit(optionsCubit: getIt()));

  getIt.registerLazySingleton(() => CandleCubit(getIt()));
  getIt.registerLazySingleton(() => TokenDetailCubit(getIt()));

  getIt.registerLazySingleton(() => SoundEffectCubit());
  getIt.registerLazySingleton(() => OptionsCubit(getIt()));
}

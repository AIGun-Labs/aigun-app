import '../data/services/api/candle_api.dart';
import '../data/services/api/intel_api.dart';
import '../data/services/api/option_api.dart';
import '../data/services/api/token_api.dart';
import '../data/services/api/token_detail_api.dart';
import 'service_locator.dart';

void setupApi() {
  getIt.registerLazySingleton(() => IntelApi(getIt()));

  getIt.registerLazySingleton(() => TokenApi(getIt()));

  getIt.registerLazySingleton(() => TokenDetailApi(getIt()));

  getIt.registerLazySingleton(() => CandleApi(getIt()));

  getIt.registerLazySingleton(() => OptionsApi(getIt()));
}

import '../data/services/api/auth_api.dart';
import '../data/services/api/candle_api.dart';
import '../data/services/api/favorite_api.dart';
import '../data/services/api/index.dart';
import '../data/services/api/intel_api.dart';
import '../data/services/api/option_api.dart';
import '../data/services/api/query_token.dart';
import '../data/services/api/token_api.dart';
import '../data/services/api/token_detail_api.dart';
import '../data/services/api/transfer_api.dart';
import '../data/services/api/trending_api.dart';
import '../data/services/api/wallet_user_api.dart';
import 'service_locator.dart';

void setupApi() {
  getIt.registerLazySingleton(() => WalletApi(getIt()));

  getIt.registerLazySingleton(() => UserApi(getIt()));

  getIt.registerLazySingleton(() => ChainApi(getIt()));


  getIt.registerLazySingleton(() => AuthApi(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => WalletUserApi(getIt(), getIt()));

  getIt.registerLazySingleton(() => TransferApi(getIt()));

  getIt.registerLazySingleton(() => WalletTransactionApi(getIt()));

  getIt.registerLazySingleton(() => IntelApi(getIt()));

  getIt.registerLazySingleton(() => TradeApi(getIt()));

  getIt.registerLazySingleton(() => TokenApi(getIt()));

  getIt.registerLazySingleton(() => TrendingApi(getIt()));

  getIt.registerLazySingleton(() => FavoriteApi(getIt()));

  getIt.registerLazySingleton(() => TokenDetailApi(getIt()));

  getIt.registerLazySingleton(() => CandleApi(getIt()));

  getIt.registerLazySingleton(() => OptionsApi(getIt()));

  getIt.registerLazySingleton(() => QueryTokenApi(getIt()));
}

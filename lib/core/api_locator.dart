import '../data/services/api/auth_api.dart';
import '../data/services/api/candle_api.dart';
import '../data/services/api/favorite_api.dart';
import '../data/services/api/index.dart';
import '../data/services/api/intel_api.dart';
import '../data/services/api/option_api.dart';
import '../data/services/api/token_api.dart';
import '../data/services/api/token_detail_api.dart';
import '../data/services/api/transfer_api.dart';
import '../data/services/api/trending_api.dart';
import '../data/services/api/wallet_user_api.dart';
import 'service_locator.dart';

void setupApi() {
  getIt.registerLazySingleton<WalletApi>(() => WalletApi(getIt()));

  getIt.registerLazySingleton<UserApi>(() => UserApi(getIt()));

  getIt.registerLazySingleton<ChainApi>(() => ChainApi(getIt()));

  getIt.registerLazySingleton<MonitorApi>(() => MonitorApi(getIt()));

  getIt
      .registerLazySingleton<AuthApi>(() => AuthApi(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton<WalletUserApi>(
      () => WalletUserApi(getIt(), getIt()));

  getIt.registerLazySingleton<TransferApi>(() => TransferApi(getIt()));

  getIt.registerLazySingleton<WalletTransactionApi>(
      () => WalletTransactionApi(getIt()));

  getIt.registerLazySingleton<IntelApi>(() => IntelApi(getIt()));

  getIt.registerLazySingleton<TradeApi>(() => TradeApi(getIt()));

  getIt.registerLazySingleton<TokenApi>(() => TokenApi(getIt()));

  getIt.registerLazySingleton<TrendingApi>(() => TrendingApi(getIt()));

  getIt.registerLazySingleton<FavoriteApi>(() => FavoriteApi(getIt()));

  getIt.registerLazySingleton<TokenDetailApi>(() => TokenDetailApi(getIt()));

  getIt.registerLazySingleton<CandleApi>(() => CandleApi(getIt()));

  getIt.registerLazySingleton<OptionsApi>(() => OptionsApi(getIt()));
}

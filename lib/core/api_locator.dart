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
  getIt.registerLazySingleton<WalletApi>(() => WalletApi());
  getIt.registerLazySingleton<UserApi>(() => UserApi());
  getIt.registerLazySingleton<ChainApi>(() => ChainApi());
  getIt.registerLazySingleton<MonitorApi>(() => MonitorApi());
  getIt.registerLazySingleton<AuthApi>(() => AuthApi());
  getIt.registerLazySingleton<WalletUserApi>(() => WalletUserApi());
  getIt.registerLazySingleton<TransferApi>(() => TransferApi());
  getIt.registerLazySingleton<WalletTransactionApi>(
      () => WalletTransactionApi());

  getIt.registerLazySingleton<IntelApi>(() => IntelApi());
  getIt.registerLazySingleton<TradeApi>(() => TradeApi());
  getIt.registerLazySingleton<TokenApi>(() => TokenApi());
  getIt.registerLazySingleton<TrendingApi>(() => TrendingApi());
  getIt.registerLazySingleton<FavoriteApi>(() => FavoriteApi());
  getIt.registerLazySingleton<TokenDetailApi>(() => TokenDetailApi());
  getIt.registerLazySingleton<CandleApi>(() => CandleApi());
  getIt.registerLazySingleton<OptionsApi>(() => OptionsApi());
}

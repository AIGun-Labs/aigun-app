import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/services/api/auth_api.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/data/services/api/intel_api.dart';
import 'package:flutter_aigun/data/services/api/transfer_api.dart';
import 'package:flutter_aigun/data/services/api/wallet_transaction.dart';
import 'package:flutter_aigun/data/services/api/wallet_user_api.dart';

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
}

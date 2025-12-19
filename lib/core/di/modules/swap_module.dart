import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubits/balance/balance_cubit.dart';
import '../../../cubits/trade_setting/trade_setting_cubit.dart';
import '../../../cubits/wallet_backups/wallet_cubit.dart';
import '../../../features/swap/data/repositories/swap_repository_impl.dart';
import '../../../features/swap/data/repositories/token_repository_impl.dart';
import '../../../features/swap/data/sources/swap_local_source.dart';
import '../../../features/swap/data/sources/swap_remote_source.dart';
import '../../../features/swap/data/sources/token_remote_source.dart';
import '../../../features/swap/domain/repositories/swap_repository.dart';
import '../../../features/swap/domain/repositories/token_repository.dart';
import '../../../features/swap/domain/usecases/execute_swap.dart';
import '../../../features/swap/domain/usecases/get_native_tokens.dart';
import '../../../features/swap/domain/usecases/get_quote.dart';
import '../../../features/swap/domain/usecases/get_transaction_status.dart';
import '../../../features/swap/domain/usecases/search_token.dart';
import '../../../features/swap/domain/usecases/validate_swap_params.dart';
import '../../../features/swap/presentation/cubit/quote/quote_cubit.dart';
import '../../../features/swap/presentation/cubit/swap/swap_cubit.dart';
import '../../../features/swap/presentation/cubit/token_selection/token_selection_cubit.dart';
import '../../../features/swap/presentation/cubit/transaction/transaction_cubit.dart';
import '../../../utils/storage/local/token_swap_storage.dart';
import '../../../utils/storage/local/wallet_storage.dart';
import '../module_repo.dart';

/// Swap 模块依赖注入配置
class SwapModule implements InjectionModule {
  SwapModule(this._sl);
  final GetIt _sl;

  @override
  Future<void> init() async {
    // ==================== Data Sources ====================
    _sl.registerLazySingleton(() => SwapLocalSource(_sl<SharedPreferences>()));
    _sl.registerLazySingleton(() => SwapRemoteSource(_sl()));
    _sl.registerLazySingleton(() => TokenRemoteSource(_sl()));

    // ==================== Repositories ====================
    _sl.registerLazySingleton<SwapRepository>(
      () => SwapRepositoryImpl(_sl<SwapRemoteSource>(), _sl<SwapLocalSource>()),
    );
    _sl.registerLazySingleton<TokenRepository>(
      () => TokenRepositoryImpl(_sl<TokenRemoteSource>()),
    );

    // ==================== Use Cases ====================
    _sl.registerLazySingleton(() => ExecuteSwap(_sl<SwapRepository>()));
    _sl.registerLazySingleton(() => GetQuote(_sl<SwapRepository>()));
    _sl.registerLazySingleton(
      () => GetTransactionStatus(_sl<SwapRepository>()),
    );
    _sl.registerLazySingleton(() => GetNativeTokens(_sl<TokenRepository>()));
    _sl.registerLazySingleton(() => SearchTokens(_sl<TokenRepository>()));
    _sl.registerLazySingleton(ValidateSwapParams.new);

    // TokenSelectionCubit - 管理 Token 选择和余额轮询
    _sl.registerFactory(
      () => TokenSelectionCubit(
        balanceCubit: _sl<BalanceCubit>(),
        tokenSwapStorage: _sl<TokenSwapStorage>(),
        getNativeTokens: _sl<GetNativeTokens>(),
        searchTokens: _sl<SearchTokens>(),
      ),
    );

    // QuoteCubit - 管理询价逻辑
    _sl.registerFactory(
      () => QuoteCubit(
        getQuote: _sl<GetQuote>(),
        tradeSettingCubit: _sl<TradeSettingCubit>(),
        validateSwapParams: _sl<ValidateSwapParams>(),
      ),
    );

    // TransactionCubit - 管理交易执行和状态轮询
    _sl.registerFactory(
      () => TransactionCubit(
        executeSwap: _sl<ExecuteSwap>(),
        getTransactionStatus: _sl<GetTransactionStatus>(),
        walletStorage: _sl<WalletStorage>(),
      ),
    );

    // SwapCubit - 协调器模式，整合所有子 Cubit
    _sl.registerFactory(
      () => SwapCubit(
        tokenSelectionCubit: _sl<TokenSelectionCubit>(),
        quoteCubit: _sl<QuoteCubit>(),
        transactionCubit: _sl<TransactionCubit>(),
        tradeSettingCubit: _sl<TradeSettingCubit>(),
        walletCubit: _sl<WalletCubit>(),
        balanceCubit: _sl<BalanceCubit>(),
        validateSwapParams: _sl<ValidateSwapParams>(),
      ),
    );
  }
}

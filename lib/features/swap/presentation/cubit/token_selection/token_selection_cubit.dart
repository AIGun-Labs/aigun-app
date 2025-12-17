import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/count.dart';
import '../../../../../core/polling/polling_service.dart';
import '../../../../../core/types/result.dart';
import '../../../../../cubits/balance/balance_cubit.dart';
import '../../../../../shared/domain/entities/base_token_entity.dart';
import '../../../../../utils/storage/local/token_swap_storage.dart';
import '../../../data/mappers/query_token_mapper.dart';
import '../../../data/mappers/transaction_token_mapper.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/get_native_tokens.dart';
import '../../../domain/usecases/search_token.dart';
import 'token_selection_state.dart';

/// TokenSelectionCubit manages Token selection and balance polling
///
/// Responsibilities:
/// - Manage fromToken / toToken selection
/// - Balance polling (using PollingService)
/// - Load saved tokens from local storage
/// - Listen to BalanceCubit to sync availableTokens
class TokenSelectionCubit extends Cubit<TokenSelectionState> {
  TokenSelectionCubit({
    required BalanceCubit balanceCubit,
    required TokenSwapStorage tokenSwapStorage,
    required GetNativeTokens getNativeTokens,
    required SearchTokens searchTokens,
  }) : _balanceCubit = balanceCubit,
       _tokenSwapStorage = tokenSwapStorage,
       _getNativeTokens = getNativeTokens,
       _searchTokens = searchTokens,
       super(const TokenSelectionState()) {
    _init();
  }
  final BalanceCubit _balanceCubit;
  final TokenSwapStorage _tokenSwapStorage;
  final GetNativeTokens _getNativeTokens;
  final SearchTokens _searchTokens;

  StreamSubscription? _balanceCubitStream;
  PollingService<double?>? _balancePollingService;

  // ==================== Initialization ====================

  Future<void> _init() async {
    await _loadSavedTokens();
    await _loadNativeTokens();
    _startBalancePolling();
    _setupBalanceCubitListener();
    // 立即获取一次余额，避免等待轮询
    await _refreshBalance();
  }

  /// Load saved tokens from local storage
  Future<void> _loadSavedTokens() async {
    final tokens = await _tokenSwapStorage.getTokens();
    if (tokens[0] != null || tokens[1] != null) {
      emit(
        state.copyWith(
          fromToken: tokens[0]?.toTransactionToken(),
          toToken: tokens[1]?.toTransactionToken(),
        ),
      );
    }
  }

  /// Load native tokens list
  Future<void> _loadNativeTokens() async {
    final result = await _getNativeTokens.call();
    result.whenOrNull(
      success: (tokens) {
        emit(state.copyWith(nativeTokens: tokens));
      },
    );
  }

  /// Setup listener for BalanceCubit
  void _setupBalanceCubitListener() {
    _balanceCubitStream = _balanceCubit.stream.listen((balanceCubitState) {
      final availableTokens = balanceCubitState.balances?.tokens
          .map(
            (token) => BaseTokenEntity(
              chainId: token.chainId,
              chainLogo: token.chainLogo,
              tokenLogo: token.tokenAvatar,
              tokenName: token.tokenName,
              price: token.tokenPrice,
              rawBalance: token.balance,
              balance: token.balance,
              decimals: token.decimals,
              symbol: token.symbol,
              chainName: token.chainName,
              network: token.network,
              isNative: token.isNative,
              address: token.tokenAddress,
              priceChange24h: '',
              marketCap: '',
              liquidity: '',
              volume24h: '',
            ),
          )
          .toList();

      emit(state.copyWith(availableTokens: availableTokens ?? []));
    });
  }

  // ==================== Token Selection ====================

  /// Update fromToken
  void updateFromToken(TransactionEntity fromToken) {
    // Check if new fromToken is the same as current toToken
    if (_shouldSwapTokens(fromToken, state.toToken)) {
      // Swap tokens
      emit(state.copyWith(fromToken: fromToken, toToken: state.fromToken));
      // Save swapped toToken
      if (state.fromToken != null) {
        _tokenSwapStorage.saveToToken(state.fromToken!.toToken());
      }
    } else {
      emit(state.copyWith(fromToken: fromToken));
    }

    _tokenSwapStorage.saveFromToken(fromToken.toToken());
    _refreshBalance();
  }

  /// Update toToken
  void updateToToken(TransactionEntity toToken) {
    // Check if new toToken is the same as current fromToken
    if (_shouldSwapTokens(toToken, state.fromToken)) {
      // Swap tokens
      emit(state.copyWith(toToken: toToken, fromToken: state.toToken));
      // Save swapped fromToken
      if (state.toToken != null) {
        _tokenSwapStorage.saveFromToken(state.toToken!.toToken());
      }
    } else {
      emit(state.copyWith(toToken: toToken));
    }

    _tokenSwapStorage.saveToToken(toToken.toToken());
  }

  /// Swap fromToken and toToken
  Future<void> swapTokens() async {
    final currentFromToken = state.fromToken;
    final currentToToken = state.toToken;

    emit(
      state.copyWith(
        fromToken: currentToToken,
        toToken: currentFromToken,
        fromBalance: null,
        balanceStatus: const TokenBalanceStatus.initial(),
      ),
    );

    // Save to local storage
    if (currentToToken != null) {
      _tokenSwapStorage.saveFromToken(currentToToken.toToken());
    }
    if (currentFromToken != null) {
      _tokenSwapStorage.saveToToken(currentFromToken.toToken());
    }

    await _refreshBalance();
  }

  /// Check if tokens should be swapped (same address and network)
  bool _shouldSwapTokens(
    TransactionEntity newToken,
    TransactionEntity? compareToken,
  ) {
    return compareToken != null &&
        newToken.address == compareToken.address &&
        newToken.network == compareToken.network;
  }

  // ==================== Token Search ====================

  /// Search tokens
  Future<void> searchTokens(String keyword, String walletId) async {
    emit(state.copyWith(searchStatus: const TokenSearchStatus.loading()));

    final result = await _searchTokens.call(
      keyword: keyword,
      walletId: walletId,
    );

    result.whenOrNull(
      success: (tokens) {
        emit(
          state.copyWith(
            nativeTokens: tokens.map((e) => e.toTokenEntity()).toList(),
            searchStatus: const TokenSearchStatus.success(),
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(searchStatus: TokenSearchStatus.failure(error)));
      },
    );
  }

  /// Reset search and reload native tokens
  Future<void> resetSearch() async {
    emit(state.copyWith(searchStatus: const TokenSearchStatus.initial()));
    await _loadNativeTokens();
  }

  // ==================== Balance Polling ====================

  /// Start balance polling
  void _startBalancePolling() {
    _stopBalancePolling();

    _balancePollingService = PollingService<double?>(
      baseInterval: Duration(seconds: NumericConstants.ten),
      maxInterval: const Duration(minutes: 1),
      pauseOnBackground: true,
      pauseOnNoNetwork: true,
      fetcher: (cancelToken) async => _fetchBalance(),
      onData: _handleBalanceUpdate,
      onError: (error, stack) {
        emit(state.copyWith(balanceStatus: const TokenBalanceStatus.failure()));
      },
    )..start();
  }

  /// Stop balance polling
  void _stopBalancePolling() {
    _balancePollingService?.stop();
    _balancePollingService = null;
  }

  /// Fetch balance
  Future<double?> _fetchBalance() async {
    final selectedToken = state.fromToken;

    if (selectedToken?.chainId == null || selectedToken?.address == null) {
      return null;
    }

    final tokens = _balanceCubit.state.balances?.tokens;
    final tokenBalance = tokens
        ?.where(
          (balance) =>
              balance.tokenAddress == selectedToken?.address &&
              balance.chainId == selectedToken?.chainId,
        )
        .firstOrNull;

    return double.tryParse(tokenBalance?.balance ?? '0') ?? 0;
  }

  /// Handle balance update
  void _handleBalanceUpdate(double? newBalance) {
    if (newBalance == null) return;

    final selectedToken = state.fromToken;
    final tokens = _balanceCubit.state.balances?.tokens;
    final tokenBalance = tokens
        ?.where(
          (balance) =>
              balance.tokenAddress == selectedToken?.address &&
              balance.chainId == selectedToken?.chainId,
        )
        .firstOrNull;

    emit(
      state.copyWith(
        fromBalance: newBalance,
        balanceStatus: TokenBalanceStatus.success(tokenBalance?.balance ?? ''),
      ),
    );
  }

  /// Manually refresh balance
  Future<void> _refreshBalance() async {
    emit(state.copyWith(balanceStatus: const TokenBalanceStatus.loading()));
    try {
      final balance = await _fetchBalance();
      _handleBalanceUpdate(balance);
    } catch (e) {
      emit(state.copyWith(balanceStatus: const TokenBalanceStatus.failure()));
    }
  }

  /// Public method to refresh balance (called externally)
  Future<void> refreshBalance() async {
    await _refreshBalance();
  }

  // ==================== Lifecycle ====================

  /// Pause polling (when page is not visible)
  void pausePolling() {
    _stopBalancePolling();
  }

  /// Resume polling (when page becomes visible again)
  void resumePolling() {
    _startBalancePolling();
  }

  @override
  Future<void> close() {
    _balanceCubitStream?.cancel();
    _stopBalancePolling();
    return super.close();
  }
}

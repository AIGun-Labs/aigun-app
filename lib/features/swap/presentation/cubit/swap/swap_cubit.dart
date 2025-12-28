import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constant/blockchain_constants.dart';
import '../../../../../core/constant/count.dart';
import '../../../../../core/router/constants.dart';
import '../../../../../core/utils/calculator.dart';
import '../../../../../cubits/balance/balance_cubit.dart';
import '../../../../../cubits/trade_setting/trade_setting_cubit.dart';
import '../../../../../cubits/wallet_backups/wallet_cubit.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../shared/presentation/extensions/string_number_extension.dart';
import '../../../../../utils/extensions/string.dart';
import '../../../../../utils/format/currency.dart';
import '../../../../../utils/logger.dart';
import '../../../../../utils/numeric_utils.dart';
import '../../../../../utils/storage/local/settings_storage.dart';
import '../../../../../widgets/token/models/token.dart';
import '../../../domain/entities/swap_result_entity.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/validate_swap_params.dart';
import '../quote/quote_cubit.dart';
import '../quote/quote_state.dart' as quote_state;
import '../token_selection/token_selection_cubit.dart';
import '../token_selection/token_selection_state.dart';
import '../transaction/transaction_cubit.dart';
import '../transaction/transaction_state.dart';
import 'swap_event.dart';
import 'swap_state.dart';

///
class SwapCubit extends Cubit<SwapState> {
  // ==================== Constructor ====================

  SwapCubit({
    required TokenSelectionCubit tokenSelectionCubit,
    required QuoteCubit quoteCubit,
    required TransactionCubit transactionCubit,
    required TradeSettingCubit tradeSettingCubit,
    required WalletCubit walletCubit,
    required BalanceCubit balanceCubit,
    required ValidateSwapParams validateSwapParams,
    required SettingsStorage settingsStorage,
  }) : _tokenSelectionCubit = tokenSelectionCubit,
       _quoteCubit = quoteCubit,
       _transactionCubit = transactionCubit,
       _tradeSettingCubit = tradeSettingCubit,
       _walletCubit = walletCubit,
       _balanceCubit = balanceCubit,
       _validateSwapParams = validateSwapParams,
       _settingsStorage = settingsStorage,
       super(const SwapState()) {
    _setupSubscriptions();
    _setupTransactionCallbacks();
    _syncInitialState();
  }
  // ==================== Dependencies ====================

  final TokenSelectionCubit _tokenSelectionCubit;
  final QuoteCubit _quoteCubit;
  final TransactionCubit _transactionCubit;
  final TradeSettingCubit _tradeSettingCubit;
  final WalletCubit _walletCubit;
  final BalanceCubit _balanceCubit;
  final ValidateSwapParams _validateSwapParams;
  final SettingsStorage _settingsStorage;

  // ==================== Stream Subscriptions ====================

  StreamSubscription? _tokenSelectionSub;
  StreamSubscription? _quoteSub;
  StreamSubscription? _transactionSub;

  // ==================== Initialization ====================

  void _setupSubscriptions() {
    _tokenSelectionSub = _tokenSelectionCubit.stream.listen(
      _onTokenSelectionChanged,
    );
    _quoteSub = _quoteCubit.stream.listen(_onQuoteChanged);
    _transactionSub = _transactionCubit.stream.listen(_onTransactionChanged);
  }

  void _setupTransactionCallbacks() {
    _transactionCubit.onTransactionSuccess = _onTransactionSuccess;
    _transactionCubit.onTransactionFailure = _onTransactionFailure;
  }

  void _syncInitialState() {
    final tokenState = _tokenSelectionCubit.state;
    final quoteState = _quoteCubit.state;

    emit(
      state.copyWith(
        fromToken: tokenState.fromToken,
        toToken: tokenState.toToken,
        fromBalance: tokenState.fromBalance,
        availableTokens: tokenState.availableTokens,
        nativeTokens: tokenState.nativeTokens,
        amount: quoteState.amount,
        quote: quoteState.quote,
      ),
    );
    _quoteCubit.updateTokens(
      fromToken: tokenState.fromToken,
      toToken: tokenState.toToken,
    );
  }

  // ==================== State Sync Handlers ====================

  void _onTokenSelectionChanged(TokenSelectionState tokenState) {
    emit(
      state.copyWith(
        fromToken: tokenState.fromToken,
        toToken: tokenState.toToken,
        fromBalance: tokenState.fromBalance,
        availableTokens: tokenState.availableTokens,
        nativeTokens: tokenState.nativeTokens,
        fromBalanceStatus: _mapBalanceStatus(tokenState.balanceStatus),
      ),
    );
    _quoteCubit.updateTokens(
      fromToken: tokenState.fromToken,
      toToken: tokenState.toToken,
    );
    _tradeSettingCubit.updateNetwork(tokenState.fromToken?.network ?? '');
  }

  void _onQuoteChanged(quote_state.QuoteState quoteState) {
    emit(
      state.copyWith(
        quote: quoteState.quote,
        amount: quoteState.amount,
        quoteStatus: _mapQuoteStatus(quoteState.status),
        paramsStatus: _mapParamsStatus(quoteState.paramsStatus),
        lastQuoteTimestamp: quoteState.lastQuoteTimestamp,
        slippage: quoteState.slippage,
        priorityFee: quoteState.priorityFee,
      ),
    );
  }

  void _onTransactionChanged(TransactionState txState) {
    emit(
      state.copyWith(
        swapStatus: _mapTransactionStatus(txState.status),
        status: _mapToLegacyStatus(txState),
      ),
    );
  }

  // ==================== Transaction Callbacks ====================

  void _onTransactionSuccess(SwapResultEntity result) {
    final newAmount = NumericUtils.convertFromAtomicUnits(
      state.quote?.outAmount ?? '',
      state.toToken?.decimals ?? 18,
    );

    emit(
      state.copyWith(
        swapStatus: SwapStatus.success(result),
        paramsStatus: const TradeParamsStatus.initial(),
        event: SwapEvent.showSuccess(
          message: 'Transaction Success',
          txHash: result.txHash ?? '',
          symbol: state.toToken?.symbol ?? '',
          amount: CurrencyFormatter.abbreviateTokenPrice(
            double.tryParse(newAmount) ?? 0,
          ),
          txUrl: result.txUrl,
        ),
      ),
    );
    _tokenSelectionCubit.refreshBalance();
  }

  void _onTransactionFailure(String? message, int? code) {
    emit(
      state.copyWith(
        swapStatus: SwapStatus.failure(message ?? 'Transaction failed'),
        paramsStatus: const TradeParamsStatus.initial(),
        event: SwapEvent.showError(message ?? 'Transaction failed', code),
      ),
    );
  }

  // ==================== Public Methods - Token Selection ====================

  /// Set both tokens atomically without triggering auto-swap logic
  ///
  /// This is the preferred method for programmatic token pair setup
  /// to avoid intermediate states and state synchronization issues.
  void setTokenPair({
    required TransactionEntity fromToken,
    required TransactionEntity toToken,
  }) async {
    _tokenSelectionCubit.setTokenPair(fromToken: fromToken, toToken: toToken);
    await _tradeSettingCubit.updateNetwork(fromToken.network ?? '');
  }

  void updateFromToken(TransactionEntity fromToken) async {
    _tokenSelectionCubit.updateFromToken(fromToken);
    await _tradeSettingCubit.updateNetwork(fromToken.network ?? '');
  }

  void updateToToken(TransactionEntity toToken) {
    _tokenSelectionCubit.updateToToken(toToken);
  }

  Future<void> swapToken() async {
    final currentToAmount =
        state.quote?.outAmount.toString().divideByDecimalPower(
          state.toToken?.decimals ?? 18,
        ) ??
        '';

    final nextAmount = currentToAmount.isNotEmpty
        ? currentToAmount
        : state.amount;

    await _tokenSelectionCubit.swapTokens();
    _quoteCubit.updateAmount(nextAmount);
  }

  Future<void> searchTokens(String keyword) async {
    final walletId = _walletCubit.state.wallets.firstOrNull?.id ?? '';
    await _tokenSelectionCubit.searchTokens(keyword, walletId);
  }

  Future<void> resetSearch() async {
    await _tokenSelectionCubit.resetSearch();
  }

  // ==================== Public Methods - Amount ====================

  void updateAmount(String amount) {
    _quoteCubit.updateAmount(amount);
  }

  void updateAmountToMax() {
    final balance = state.fromBalance.toString();

    String maxAmount;
    if (!balance.isNotEmptyAndZeroValue) {
      maxAmount = '0';
    } else if (state.fromToken?.isNative ?? false) {
      final max = Calculator.multiplyTwo(balance, 0.995);
      maxAmount = max.toString();
    } else {
      maxAmount = balance;
    }

    maxAmount = maxAmount.removeTrailingZeros(
      maxDecimals: NumericConstants.twelve,
    );
    emit(state.copyWith(amount: maxAmount));
    _quoteCubit.updateAmount(maxAmount);
  }

  void updateSlippage(String slippage) {
    _quoteCubit.updateSlippage(int.parse(slippage));
  }

  void updatePriorityFee(String priorityFee) {
    _quoteCubit.updatePriorityFee(int.parse(priorityFee));
  }

  Future<void> getQuote() async {
    await _quoteCubit.getQuote();
  }

  ///
  bool _checkSolanaMinimumBalance() {
    if (state.fromToken?.network?.toLowerCase() !=
        BlockchainConstants.networkSolana) {
      return true;
    }
    final solToken = _getNativeToken(BlockchainConstants.networkSolana);
    if (solToken == null) {
      return true; // （）
    }
    final solBalance = NumericUtils.multiplyByDecimalPower(
      solToken.balance,
      solToken.decimals,
    ).toString();

    final fee = state.quote?.fee?.toDouble() ?? 0.0;

    BigInt remaining;
    if (state.fromToken?.isNative ?? false) {
      final atomicAmount = NumericUtils.multiplyByDecimalPower(
        state.amount,
        state.fromToken!.decimals,
      ).toString();
      remaining =
          BigInt.parse(solBalance) -
          BigInt.parse(atomicAmount) -
          BigInt.from(fee);
    } else {
      remaining = BigInt.parse(solBalance) - BigInt.from(fee);
    }
    if (remaining < BigInt.from(BlockchainConstants.minSolanaBalanceLamports)) {
      emit(state.copyWith(event: const SwapEvent.showSolMinimumWarning()));
      return false;
    }

    return true;
  }

  Future<void> swap(BuildContext context) async {
    final validation = _validateSwapParams.call(
      fromToken: state.fromToken,
      toToken: state.toToken,
      amount: state.amount,
      fromBalance: state.fromBalance,
    );

    if (!validation.isSuccess) {
      emit(
        state.copyWith(
          paramsStatus: const TradeParamsStatus.failure(),
          event: const SwapEvent.showParamsInvalid(),
        ),
      );
      return;
    }
    if (!_checkSolanaMinimumBalance()) {
      return; //
    }
    emit(
      state.copyWith(
        swapStatus: const SwapStatus.trading(),
        event: const SwapEvent.showLoading(),
      ),
    );
    final atomicAmount = NumericUtils.multiplyByDecimalPower(
      state.amount,
      state.fromToken!.decimals,
    ).toString();

    if (!atomicAmount.isNotEmptyAndZeroValue) {
      emit(
        state.copyWith(
          swapStatus: const SwapStatus.failure('Invalid amount'),
          event: const SwapEvent.showParamsInvalid(),
        ),
      );
      return;
    }
    final settingOptions = _tradeSettingCubit.getCurrentTradeCustomSetting();
    await _transactionCubit.executeSwap(
      fromToken: state.fromToken!,
      toToken: state.toToken!,
      amount: atomicAmount,
      options: settingOptions,
      mode: _tradeSettingCubit.getTradeMode(),
    );
  }

  // ==================== Public Methods - Navigation ====================

  void toReceivePage(BuildContext context, TransactionEntity? token) {
    if (token == null) return;

    final walletAddress = _walletCubit.getWalletByNetwork(token.network ?? '');

    if (walletAddress == null) return;

    final title = S.of(context).networkReceive(token.chainName);

    Logger.info('walletAddress.chainLogo: ${walletAddress.chainLogo}');

    context.pushNamed(
      RouteNames.receiveAddress,
      extra: {
        'avatar': walletAddress.chainLogo,
        'title': title,
        'symbol': walletAddress.chainName,
        'address': walletAddress.address,
      },
    );
  }

  // ==================== Public Methods - Balance ====================

  Future<void> getBalanceSelectedToken() async {
    await _tokenSelectionCubit.refreshBalance();
  }

  Future<void> getNativeTokens() async {
    await _tokenSelectionCubit.resetSearch();
  }

  // ==================== Public Methods - Utility ====================

  bool isEnoughFee() {
    final fee = state.quote?.fee?.toDouble() ?? 0.0;

    if (state.fromToken == null) return false;

    if (state.fromToken!.isNative) {
      final balance = NumericUtils.multiplyByDecimalPower(
        state.fromBalance.toString(),
        state.fromToken!.decimals,
      ).toString();

      final remainingBalance = balance.toDouble() - fee;
      return remainingBalance >= 0;
    }

    final nativeToken = _getNativeToken(state.fromToken!.network);
    if (nativeToken == null) return false;

    final nativeBalance = NumericUtils.multiplyByDecimalPower(
      nativeToken.balance,
      nativeToken.decimals,
    ).toString();

    final remainingBalance = nativeBalance.toDouble() - fee;
    return remainingBalance >= 0;
  }

  Token? _getNativeToken(String? network) {
    if (network == null) return null;
    final tokens = _balanceCubit.state.balances?.tokens ?? [];

    try {
      final match = tokens.firstWhere(
        (t) => t.network.toLowerCase() == network.toLowerCase() && t.isNative,
      );
      return Token.fromBalance(match);
    } catch (e) {
      return null;
    }
  }

  void clearEvent() {
    emit(state.copyWith(event: null));
  }

  void resetAll() {
    _quoteCubit.clear();
    _transactionCubit.reset();
    emit(
      state.copyWith(
        swapStatus: const SwapStatus.initial(),
        paramsStatus: const TradeParamsStatus.initial(),
        quoteStatus: const QuoteStatus.initial(),
        fromBalanceStatus: const GetTokenBalanceStatus.initial(),
        event: null,
        fromBalance: 0,
        amount: '0.0',
      ),
    );
  }

  void clear() {
    _quoteCubit.clear();
    emit(state.copyWith(quote: null, amount: '', fromBalance: null));
  }

  // ==================== Lifecycle ====================

  void pauseTimers() {
    _tokenSelectionCubit.pausePolling();
    _quoteCubit.pause();
  }

  void resumeTimers() {
    _tokenSelectionCubit.resumePolling();
    _quoteCubit.resume();
  }

  @override
  Future<void> close() {
    _tokenSelectionSub?.cancel();
    _quoteSub?.cancel();
    _transactionSub?.cancel();
    return super.close();
  }

  // ==================== Status Mappers ====================

  GetTokenBalanceStatus _mapBalanceStatus(TokenBalanceStatus status) {
    return status.when(
      initial: () => const GetTokenBalanceStatus.initial(),
      loading: () => const GetTokenBalanceStatus.loading(),
      success: GetTokenBalanceStatus.success,
      failure: (_) => const GetTokenBalanceStatus.failure(),
    );
  }

  TradeParamsStatus _mapParamsStatus(quote_state.QuoteParamsStatus status) {
    return status.when(
      initial: () => const TradeParamsStatus.initial(),
      valid: () => const TradeParamsStatus.success(),
      invalid: (_) => const TradeParamsStatus.failure(),
    );
  }

  QuoteStatus _mapQuoteStatus(quote_state.QuoteStatus status) {
    return status.when(
      initial: () => const QuoteStatus.initial(),
      loading: () => const QuoteStatus.loading(),
      success: QuoteStatus.success,
      failure: (_) => const QuoteStatus.failure(),
    );
  }

  SwapStatus _mapTransactionStatus(TransactionStatus status) {
    return status.when(
      initial: () => const SwapStatus.initial(),
      submitting: () => const SwapStatus.trading(),
      polling: (txHash, txUrl) => const SwapStatus.trading(),
      success: SwapStatus.success,
      failure: (message) => SwapStatus.failure(message ?? 'Unknown error'),
    );
  }

  TradeStatusMessage _mapToLegacyStatus(TransactionState txState) {
    return txState.status.when(
      initial: () => const TradeStatusMessage.initial(),
      submitting: () => const TradeStatusMessage.loading(),
      polling: (txHash, txUrl) => const TradeStatusMessage.loading(),
      success: TradeStatusMessage.success,
      failure: (message) => const TradeStatusMessage.failure(TradeStatus.none),
    );
  }
}

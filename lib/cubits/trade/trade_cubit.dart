import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/transfer/transaction/transaction.dart';
import '../../data/services/api/index.dart';
import '../../data/services/api/token_api.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/debouncer.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../../widgets/token/models/token.dart';
import '../index.dart' hide QuoteStatus;
import 'trade_state.dart';

class TradeCubit extends Cubit<TradeState> {
  StreamSubscription? _balanceCubitStream;
  final BalanceCubit balanceCubit;
  final TradeSettingCubit tradeSettingCubit;
  Timer? _quoteTimer;
  TradeApi tradeApi;
  WalletStorage walletStorage;
  final TokenApi tokenApi;
  Timer? _transactionStatusTimer;
  Timer? _balanceTimer;
  TradeCubit(
    this.balanceCubit,
    this.tradeSettingCubit,
    this.tokenApi,
    this.tradeApi,
    this.walletStorage,
  ) : super(const TradeState());
  void resetAll() {}
  final Debouncer _quoteDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  final Debouncer _getFormBalance = Debouncer(
    delay: const Duration(milliseconds: 300),
  );
  bool _shouldSwapTokens(TradeToken newToken, TradeToken? compareToken) {
    return false;
  }

  void _swapTokens({
    required TradeToken newToken,
    required TradeToken? previousToken,
    required bool isUpdatingFrom,
  }) {}
  void updateFromToken(TradeToken fromToken) {}
  void updateTradeSettingChainName() {}
  void toReceivePage(BuildContext context, TradeToken? token) {}
  void updateToToken(TradeToken toToken) {}
  void updateSlippage(String slippage) {}
  void updatePriorityFee(String priorityFee) {}
  void updateAmount(String amount) {}
  void _startQuoteTimer() {}
  void _updateQuoteTimestamp() {}
  void updateAmountToMax() {}
  bool checkAmount(String amount, String balance) {
    return false;
  }

  Future<void> init() async {
    return;
  }

  Future<void> getNativeTokens() async {
    return;
  }

  Future<void> searchTokens(String keyword) async {
    return;
  }

  Future<void> swap(BuildContext context) async {
    return;
  }

  Future<void> getTransactionStatus(
    TransferTransaction transaction,
    BuildContext context,
  ) async {
    return;
  }

  Future<void> swapToken() async {}
  Future<void> getBalanceSelectedToken() async {}
  Future<void> getQuote() async {
    return;
  }

  void clear() {}

  @override
  Future<void> close() {
    _quoteTimer?.cancel();
    _balanceCubitStream?.cancel();
    state.amountController?.dispose();
    _quoteDebouncer.dispose();
    _balanceTimer?.cancel();
    _transactionStatusTimer?.cancel();

    return super.close();
  }

  void pauseTimers() {}
  void resumeTimers() {}
  void cancelTransactionStatusTimer() {}
  bool isEnoughFee() {
    return false;
  }

  Token? _getNativeToken(String? network) {
    return null;
  }

  TradeButtonState get buttonState {
    return const TradeButtonState.disabled(
      reason: TradeButtonDisabledReason.noAmount(),
    );
  }
}

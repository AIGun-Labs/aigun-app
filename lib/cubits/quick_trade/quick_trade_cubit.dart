import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/polling/polling_service.dart';
import '../../data/models/transfer/index.dart';
import '../../data/services/api/index.dart';
import '../../shared/trade/trade_button_state.dart';
import '../../utils/debouncer.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../../widgets/token/models/token.dart';
import '../index.dart';

class QuickTradeCubit extends Cubit<QuickTradeState> {
  QuickTradeCubit(
    this._tradeApi,
    this._tradeSettingCubit,
    this._walletStorage,
    this._balanceCubit,
  ) : super(const QuickTradeState());
  late final StreamSubscription<BalanceState> _balanceCubitStream;

  Timer? _transactionStatusTimer;

  final TradeApi _tradeApi;
  final TradeSettingCubit _tradeSettingCubit;
  final WalletStorage _walletStorage;

  final BalanceCubit _balanceCubit;
  final Debouncer _buyQuoteDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );
  final Debouncer _sellQuoteDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );
  PollingService<TransferQuote?>? _buyQuotePollingService;
  PollingService<TransferQuote?>? _sellQuotePollingService;
  bool _isPollingTransaction = false;
  int _buyQuoteRequestVersion = 0;
  int _sellQuoteRequestVersion = 0;
  bool _isPollingActive = false;
  void updateFromToken(Token fromToken) {}
  void startPollingQuote() {
    return;
  }

  void stopPollingQuote() {}
  void updateSelectedToken(Token toToken) {}
  void updateMode(QuickTradeMode mode) {}
  void updateBuyAmount(String buyAmount) {}
  void updateSellPercent(String sellPercent) {}
  void _onUpdateSelectedToken(Token selectedToken) {}
  void initialize() {
    return;
  }

  Future<TransferQuote?> getBuyQuote() async {
    return null;
  }

  Future<TransferQuote?> getSellQuote() async {
    return null;
  }

  Future<bool> _checkSolanaMinimumBalance(BuildContext context) async {
    return true;
  }

  Future<void> buyToken(BuildContext context) async {
    return;
  }

  Future<void> sellToken(BuildContext context) async {
    return;
  }

  Future<String?> _percentageToAmount(String percentage, String balance) async {
    return null;
  }

  void _handleTradeSuccess(
    TransferTransaction result,
    BuildContext context,
    QuickTradeMode mode,
  ) {}
  void _handleTradeFailure(QuickTradeMode mode, {String? errorMessage}) {}
  Future<void> getTransactionStatus(
    TransferTransaction transaction,
    String chainId,
    int decimals,
    Function(TransferTransaction) success,
    VoidCallback failure,
  ) async {}
  Future<String> getBalanceByAddress(String address, String network) async {
    return '0';
  }

  @override
  Future<void> close() {
    _buyQuoteDebouncer.cancel();
    _sellQuoteDebouncer.cancel();

    _balanceCubitStream.cancel();
    _transactionStatusTimer?.cancel();
    stopPollingQuote();
    return super.close();
  }

  void clear() {}
  bool balanceIsEnough({required Token? token, required String fee}) {
    return false;
  }

  bool isBuyAmountValid() {
    return false;
  }

  TradeButtonState get buyButtonState {
    return const TradeButtonState.disabled(
      reason: TradeButtonDisabledReason.noAmount(),
    );
  }

  TradeButtonState get sellButtonState {
    return const TradeButtonState.disabled(
      reason: TradeButtonDisabledReason.noAmount(),
    );
  }
}

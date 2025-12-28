import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/polling/polling_service.dart';
import '../../data/models/index.dart';
import '../../data/models/transfer/index.dart';
import '../../data/services/api/transfer_api.dart';
import '../../utils/web3/address.dart';
import '../../widgets/token/models/token.dart';
import '../index.dart';

class TransferCubit extends Cubit<TransferState> {
  final TransferApi _transferApi;
  Timer? _gasUpdateTimer;
  final WalletCubit _walletCubit;
  Timer? _transactionStatusTimer;

  PollingService<Gas?>? _gasPollingService;
  PollingService<TransferTransaction?>? _transactionStatusPollingService;

  TransferCubit(this._transferApi, this._walletCubit)
    : super(TransferState.initial());
  void init() {
    return;
  }

  void _startGasPolling() {
    return;
  }

  void _startTransactionStatusPolling(String txHash) {
    return;
  }

  void _stopGasPolling() {
    _gasPollingService?.stop();
    _gasPollingService = null;
  }

  void _stopTransactionStatusPolling() {
    _transactionStatusPollingService?.stop();
    _transactionStatusPollingService = null;
  }

  @override
  Future<void> close() {
    state.toAddressController.dispose();
    state.amountController.dispose();
    _gasUpdateTimer?.cancel();
    _transactionStatusTimer?.cancel();
    return super.close();
  }

  void updateToken(Token token) {
    resetAll();
    emit(
      state.copyWith(
        tokenAddress: token.address,
        chainId: token.chainId,
        decimals: token.decimals,
        selectedToken: token,
      ),
    );

    updateAmount('');
    updateToAddress('');

    // Restart gas polling with the new token
    _startGasPolling();
  }

  void updatePaymentPin(String? paymentPin) {
    if (paymentPin != null) {
      emit(state.copyWith(paymentPin: paymentPin));
    }
  }

  void updateToAddress(String address) {
    if (state.toAddressController.text != address) {
      state.toAddressController.text = address;
    }
    emit(state.copyWith(toAddress: address));
  }

  void updateAmount(String amount) {
    if (state.amountController.text != amount) {
      state.amountController.text = amount;
    }
    emit(state.copyWith(amount: amount));
  }

  void setAllAmount() {
    final balance = state.selectedToken?.balance ?? '0';
    updateAmount(balance);
    checkAmount(balance, balance);
  }

  String getAvailableAmount() {
    final balance = state.selectedToken?.balance ?? '0';
    final balanceValue = double.tryParse(balance) ?? 0.0;
    final amountValue = double.tryParse(state.amount) ?? 0.0;
    final availableAmount = (balanceValue - amountValue).toString();

    return availableAmount;
  }

  void checkAddress(String address) {
    if (address.isEmpty || !Web3Address.isValidAddress(address)) {
      emit(state.copyWith(addressError: true));
    } else {
      emit(state.copyWith(addressError: false));
    }
  }

  void checkAmount(String amount, String balance) {
    if (amount.isEmpty ||
        double.tryParse(amount) == null ||
        (double.tryParse(amount) ?? 0.0) > (double.tryParse(balance) ?? 0.0)) {
      emit(state.copyWith(amountError: true));
    } else {
      emit(state.copyWith(amountError: false));
    }
  }

  Future<void> getTransactionQuote() async {
    emit(state.copyWith(loadingGas: true));
  }

  Future<void> getTransactionStatus(String chainId, String txHash) async {
    return;
  }

  Future<void> transferToken(VoidCallback callback) async {
    callback();
    return;
  }

  void updateSelectedToken(Token token) {
    emit(state.copyWith(selectedToken: token));

    // Restart gas polling with the new token
    _startGasPolling();
    resetStatus();
  }

  void resetStatus() {
    emit(
      state.copyWith(
        isSent: false,
        isFailed: false,
        isSuccess: false,
        amount: '',
        toAddress: '',
        gas: null,
        transaction: null,
      ),
    );
  }

  void resetInput() {
    emit(TransferState.initial());
  }

  void resetAll() {
    state.toAddressController.clear();
    state.amountController.clear();
    _stopTransactionStatusPolling();
    _stopGasPolling();
    resetStatus();
    resetInput();
  }
}

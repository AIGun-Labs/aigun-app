import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/enums/trade_status.dart';
import '../../core/polling/polling_service.dart';
import '../../data/models/index.dart';
import '../../data/models/transfer/index.dart';
import '../../data/services/api/transfer_api.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/decimal.dart';
import '../../utils/logger.dart';
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
    // 启动定时更新 gas
    _startGasPolling();
  }

  void _startGasPolling() {
    _stopGasPolling();
    _gasPollingService = PollingService(
        pauseOnBackground: true,
        pauseOnNoNetwork: true,
        fetcher: (cancelToken) async {
          // Check if selectedToken is available before making the API call
          if (state.selectedToken == null ||
              state.selectedToken?.chainId == null ||
              state.selectedToken?.chainId.isEmpty == true ||
              state.selectedToken?.address == null ||
              state.selectedToken?.address.isEmpty == true) {
            Logger.info(
                'Transfer Cubit: Skipping gas fee polling - no token selected');
            return null;
          }

          Logger.info(
              'Transfer Cubit: Start gas fee polling for chainId: ${state.selectedToken?.chainId}, address: ${state.selectedToken?.address}');

          return await _transferApi.getGasFee(
              chainId: state.selectedToken!.chainId,
              address: state.selectedToken!.address);
        },
        onData: (gas) {
          emit(state.copyWith(gas: gas));
        },
        onError: (error, stack) async {
          emit(state.copyWith(gas: null));
        })
      ..start();
  }

  void _startTransactionStatusPolling(String txHash) {
    _stopTransactionStatusPolling();

    _transactionStatusPollingService = PollingService<TransferTransaction?>(
        baseInterval: const Duration(seconds: TWO),
        maxInterval: const Duration(seconds: TWENTY),
        maxAttempts: TEN, // 设置最大轮询次数为10
        fetcher: (cancelToken) async {
          if (state.selectedToken == null) {
            throw Exception('No Selected token for transaction status check');
          }

          final response = await _transferApi.getTransactionStatus(
              chainId: state.selectedToken!.chainId,
              txHash: txHash,
              network: state.selectedToken?.network ?? '');

          return response;
        },
        onData: (response) {
          if (response == null) return;
          Logger.info('Transaction status update: ${response.status}');

          if (response.status == TradeStatus.success.value) {
            Logger.info('transaction status success');
            emit(state.copyWith(
                isSending: false,
                isSuccess: true,
                isSent: true,
                transaction:
                    state.transaction?.copyWith(status: response.status),
                transferStatus: TransferStatus.success(response)));
            _stopTransactionStatusPolling();
          }

          if (response.status == TradeStatus.failed.value) {
            Logger.info('transaction status failed');
            emit(state.copyWith(
                isSending: false,
                isFailed: true,
                isSent: false,
                failedReason: response.status ?? '',
                transaction:
                    state.transaction?.copyWith(status: response.status),
                transferStatus: const TransferStatus.failure()));
            _stopTransactionStatusPolling();
          }

          // 处理 pending 状态 - 只更新状态，继续轮询
          if (response.status == TradeStatus.pending.value) {
            Logger.info('Transaction status: pending, continuing to poll...');
            // 更新 transaction 但继续轮询
            emit(state.copyWith(
              transaction: state.transaction?.copyWith(status: response.status),
            ));
          }
        },
        onMaxAttemptsReached: () {
          // 达到最大轮询次数，将 pending 视为成功
          Logger.info(
              'Max polling attempts (10) reached with pending status, treating as success');

          // 使用最后一次的 transaction 数据，如果没有则创建新的
          final successResponse = state.transaction?.copyWith(
                status: TradeStatus.success.value,
              ) ??
              TransferTransaction(
                txHash: txHash,
                status: TradeStatus.success.value,
              );

          emit(state.copyWith(
              isSending: false,
              isSuccess: true,
              isSent: true,
              transaction: successResponse,
              transferStatus: TransferStatus.success(successResponse)));
        },
        onError: (error, stack) {
          Logger.error('Transaction status update error: $error');
          emit(state.copyWith(
            isSending: false,
            isFailed: true,
            isSent: false,
            transaction: null,
            transferStatus: const TransferStatus.failure(),
            failedReason: error.toString(),
          ));
        })
      ..start();
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

// 更新选中的token
  void updateToken(Token token) {
    resetAll();
    emit(state.copyWith(
      tokenAddress: token.address,
      chainId: token.chainId,
      decimals: token.decimals,
      selectedToken: token,
    ));

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

// 更新接收地址
  void updateToAddress(String address) {
    state.toAddressController.text = address;
    emit(state.copyWith(toAddress: address));
  }

  void updateAmount(String amount) {
    state.amountController.text = amount;
    emit(state.copyWith(amount: amount));
  }

// 设置所有金额
  void setAllAmount() {
    final balance = state.selectedToken?.balance ?? '0';
    updateAmount(balance);
    checkAmount(balance, balance);
  }

// 获取可用金额
  String getAvailableAmount() {
    final balance = state.selectedToken?.balance ?? '0';
    final balanceValue = double.tryParse(balance) ?? 0.0;
    final amountValue = double.tryParse(state.amount) ?? 0.0;
    final availableAmount = (balanceValue - amountValue).toString();

    return availableAmount;
  }

// 检查接受地址
  void checkAddress(String address) {
    if (address.isEmpty || !Web3Address.isValidAddress(address)) {
      emit(state.copyWith(addressError: true));
    } else {
      emit(state.copyWith(addressError: false));
    }
  }

// 检查金额
  void checkAmount(String amount, String balance) {
    if (amount.isEmpty ||
        double.tryParse(amount) == null ||
        (double.tryParse(amount) ?? 0.0) > (double.tryParse(balance) ?? 0.0)) {
      emit(state.copyWith(amountError: true));
    } else {
      emit(state.copyWith(amountError: false));
    }
  }

  // 获取交易报价
  Future<void> getTransactionQuote() async {
    emit(state.copyWith(loadingGas: true));
  }

  Future<void> getTransactionStatus(String chainId, String txHash) async {
    try {
      final response = await _transferApi.getTransactionStatus(
          chainId: chainId,
          txHash: txHash,
          network: state.selectedToken?.network ?? '');

      if (response.status == TradeStatus.success.value) {
        Logger.info('getTransactionStatus success');
        emit(state.copyWith(
            isSending: false,
            isSuccess: true,
            isSent: true,
            transaction: state.transaction?.copyWith(status: response.status),
            transferStatus: TransferStatus.success(response)));

        _transactionStatusTimer?.cancel();
      }
      if (response.status == TradeStatus.failed.value) {
        Logger.error('getTransactionStatus failed');
        emit(state.copyWith(
            isSending: false,
            isFailed: true,
            isSent: false,
            failedReason: response.status ?? '',
            transaction: state.transaction?.copyWith(status: response.status),
            transferStatus: const TransferStatus.failure()));

        _transactionStatusTimer?.cancel();
      }
    } catch (e, s) {
      emit(state.copyWith(
        isSending: false,
        isFailed: true,
        isSent: false,
        failedReason: e.toString(),
        transaction: null,
        transferStatus: const TransferStatus.failure(),
      ));
      Logger.error('getTransactionStatus error: $e');

      await SentryService().reportError(e, s, tags: {
        'feature': 'getTransactionStatus'
      }, extra: {
        'chainId': chainId,
        'txHash': txHash,
        'network': state.selectedToken?.network ?? '',
      });

      _transactionStatusTimer?.cancel();
    }
  }

// 转账
  Future<void> transferToken(VoidCallback callback) async {
    emit(state.copyWith(
        isSending: true,
        transferStatus: const TransferStatus.loading(),
        riskChallenge: const RiskChallenge.initial()));
    final walletAddress = _walletCubit.getWalletAddress(
        state.selectedToken?.network ?? '', state.selectedToken?.address ?? '');
    final newAmount =
        multiplyByDecimalPower(state.amount, state.selectedToken!.decimals)
            .toString();
    try {
      final transaction = await _transferApi.transferToken(
        chainId: state.selectedToken?.chainId ?? '',
        walletId: _walletCubit.state.wallets.first.id ?? '',
        fromAddress: walletAddress?.address ?? '',
        toAddress: state.toAddress,
        network: state.selectedToken?.network ?? '',
        amount: newAmount.toString(),
        tokenMint: state.selectedToken?.address ?? '',
      );

      emit(state.copyWith(
        transferStatus: TransferStatus.success(transaction),
        riskChallenge: const RiskChallenge.success(),
        isSending: true,
        isSuccess: false,
        isSent: false,
        transaction: transaction,
      ));

      _startTransactionStatusPolling(transaction.txHash ?? '');
    } catch (e, s) {
      emit(state.copyWith(
        transferStatus: const TransferStatus.failure(), // 转账失败
        riskChallenge: const RiskChallenge.failure(), // 挑战失败
        isSending: false,
        isSuccess: false,
        isSent: false,
      ));

      await SentryService().reportError(e, s, tags: {
        'feature': 'transferToken'
      }, extra: {
        'chainId': state.chainId,
        'fromAddress': walletAddress,
        'toAddress': state.toAddress,
        'amount': newAmount,
        'network': state.selectedToken?.network ?? '',
        'tokenMint': state.selectedToken!.address,
      });
    } finally {
      callback();
    }
  }

// 更新选中的token
  void updateSelectedToken(Token token) {
    emit(state.copyWith(selectedToken: token));

    // Restart gas polling with the new token
    _startGasPolling();
    resetStatus();
  }

  void resetStatus() {
    emit(state.copyWith(
        isSent: false,
        isFailed: false,
        isSuccess: false,
        amount: '',
        toAddress: '',
        gas: null,
        transaction: null));
  }

  void resetInput() {
    emit(TransferState.initial());
  }

  void resetAll() {
    // 清理控制器
    state.toAddressController.clear();
    state.amountController.clear();
    _stopTransactionStatusPolling();
    _stopGasPolling();
    resetStatus();
    resetInput();
  }
}

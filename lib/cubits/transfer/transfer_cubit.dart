import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/count.dart';
import '../../core/enums/trade_status.dart';
import '../../core/polling/polling_service.dart';
import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/services/api/index.dart';
import '../../data/services/api/transfer_api.dart';
import '../../data/services/sentry_service.dart';
import '../../utils/decimal.dart';
import '../../utils/extensions/string.dart';
import '../../utils/logger.dart';
import '../../utils/web3/address.dart';
import '../../widgets/token/models/token.dart';
import '../index.dart';

class TransferCubit extends Cubit<TransferState> {
  final WalletApi _walletApi = getIt<WalletApi>();

  final TransferApi _transferApi = getIt<TransferApi>();
  Timer? _gasUpdateTimer;
  final WalletCubit _walletCubit = getIt<WalletCubit>();
  Timer? _transactionStatusTimer; // 交易状态定时器

  PollingService<Gas?>? _gasPollingService;
  PollingService<TransactionStatus?>? _transactionStatusPollingService;

  TransferCubit() : super(TransferState.initial()) {
    init();
  }

  void init() {
    // 启动定时更新 gas
    _startGasUpdate();
  }

  void _startGasPolling() {
    _stopGasPolling();
    _gasPollingService = PollingService(fetcher: (cancelToken) async {
      if (!state.chainId.toString().isNotEmptyAndZeroValue) {
        return null;
      }

      return await _transferApi.getGasFee(
          chainId: state.selectedToken?.chainId ?? '',
          address: state.selectedToken?.address ?? '');
    }, onData: (gas) {
      emit(state.copyWith(gas: gas));
    }, onError: (error, stack) async {
      emit(state.copyWith(gas: null));
    });
  }

  void _startTransactionStatusPolling() {}

  void _stopGasPolling() {}

  void _startTransactionStatusTimer(String txHash) {
    _stopTransactionStatusTimer();
    _transactionStatusTimer =
        Timer.periodic(const Duration(seconds: 2), (timer) {
      getTransactionStatus(
        state.selectedToken?.chainId ?? '',
        txHash,
      );
    });
  }

  void _stopTransactionStatusTimer() {
    _transactionStatusTimer?.cancel();
    _transactionStatusTimer = null;
  }

  void _startGasUpdate() {
    // 立即执行一次
    if (state.chainId.toString().isNotEmptyAndZeroValue) {
      getGas();
    }
    _stopGasUpdate();

    // 每10秒更新一次
    _gasUpdateTimer = Timer.periodic(const Duration(seconds: FIVE), (timer) {
      getGas();
    });
  }

  void _stopGasUpdate() {
    _gasUpdateTimer?.cancel();
    _gasUpdateTimer = null;
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

// 获取 gasFee
  Future<void> getGas() async {
    emit(state.copyWith(loadingGas: true));
    try {
      // 获取 gas 费用
      final gas = await _transferApi.getGasFee(
        chainId: state.selectedToken?.chainId ?? '',
        address: state.selectedToken?.address ?? '',
      );

      emit(state.copyWith(
        gas: gas,
      ));
    } catch (e, s) {
      // 获取 gas 费用失败
      emit(state.copyWith(loadingGas: false));
      await SentryService().reportError(e, s, tags: {
        'feature': 'transferToken'
      }, extra: {
        'chainId': state.chainId,
      });
    } finally {
      emit(state.copyWith(loadingGas: false));
    }
  }

  Future<void> getTransactionStatus(String chainId, String txHash) async {
    try {
      final response = await _transferApi.getTransactionStatus(
          chainId: chainId,
          txHash: txHash,
          network: state.selectedToken?.network ?? '');

      Logger.info('getTransactionStatus response: $response');

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

      _startTransactionStatusTimer(transaction.txHash ?? '');
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

    getGas();
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
        calculatedGas: null,
        transaction: null));
  }

  void resetInput() {
    emit(TransferState.initial());
  }

  void resetAll() {
    // 清理控制器
    state.toAddressController.clear();
    state.amountController.clear();
    _stopTransactionStatusTimer();
    _stopGasUpdate();
    resetStatus();
    resetInput();
  }
}

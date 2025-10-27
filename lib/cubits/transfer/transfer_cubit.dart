import 'dart:async';
import 'dart:math';

import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/data/services/api/transfer_api.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/utils/decimal.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/validators/risk_validator.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/utils/web3/gas_calculator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';

import '../../core/service_locator.dart';

class TransferCubit extends Cubit<TransferState> {
  final WalletApi walletApi = getIt<WalletApi>();

  final TransferApi transferApi = getIt<TransferApi>();
  Timer? _gasUpdateTimer;
  final WalletCubit walletCubit = getIt<WalletCubit>();

  TransferCubit() : super(TransferState.initial()) {
    init();
  }

  init() {
    // 启动定时更新 gas
    _startGasUpdate();
  }

  void _startGasUpdate() {
    // 立即执行一次
    if (state.chainId.toString().isNotEmptyAndZeroValue) {
      getGas();
    }

    if (_gasUpdateTimer != null) {
      _gasUpdateTimer?.cancel();
    }

    // 每10秒更新一次
    _gasUpdateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getGas();
    });
  }

  @override
  Future<void> close() {
    state.toAddressController.dispose();
    state.amountController.dispose();
    _gasUpdateTimer?.cancel();
    return super.close();
  }

// 更新选中的token
  void updateToken(Token token) {
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
      final gas = await transferApi.getGasFee(
        chainId: state.selectedToken?.chainId ?? '',
      );

      // 计算实际的 gas 费用
      final calculatedGas = GasCalculator.calculateGasFee(
        gasPrice: gas.gas,
      );

      emit(state.copyWith(
        gas: gas,
        calculatedGas: calculatedGas,
      ));
    } catch (e, s) {
      // 获取 gas 费用失败
      emit(state.copyWith(loadingGas: false));
      await SentryService().reportError(e, s, tags: {
        "feature": "transferToken"
      }, extra: {
        "chainId": state.chainId,
      });
    } finally {
      emit(state.copyWith(loadingGas: false));
    }
  }

// 转账
  Future<void> transferToken(
    Function(bool) callback,
  ) async {
    emit(state.copyWith(
        isSending: true,
        transferStatus: const TransferStatus.loading(),
        riskChallenge: const RiskChallenge.initial()));
    final walletAddress =
        walletCubit.getWalletAddressByChainId(state.chainId.toString()) ?? '';
    final newAmount =
        multiplyByDecimalPower(state.amount, state.selectedToken!.decimals)
            .toString();
    try {
      final transaction = await transferApi.transferToken(
        chainId: state.chainId,
        fromAddress: walletAddress,
        toAddress: state.toAddress,
        network: state.selectedToken?.network ?? '',
        amount: newAmount.toString(),
        tokenMint: state.selectedToken!.address,
      );

      emit(state.copyWith(
        transferStatus: TransferStatus.success(transaction),
        riskChallenge: const RiskChallenge.success(),
        isSending: false,
        isSuccess: true,
        // isSent: true,
        transaction: transaction,
      ));

      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(isSent: true));
      });
    } catch (e, s) {
      emit(state.copyWith(
        transferStatus: const TransferStatus.failure(), // 转账失败
        riskChallenge: const RiskChallenge.failure(), // 挑战失败
        isSending: false,
        isSuccess: false,
        isSent: false,
      ));

      await SentryService().reportError(e, s, tags: {
        "feature": "transferToken"
      }, extra: {
        "chainId": state.chainId,
        "fromAddress": walletAddress,
        "toAddress": state.toAddress,
        "amount": newAmount,
        "network": state.selectedToken?.network ?? '',
        "tokenMint": state.selectedToken!.address,
      });
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
    ));
  }

  void resetInput() {
    emit(TransferState.initial());
  }

  void resetAll() {
    // 清理控制器
    state.toAddressController.clear();
    state.amountController.clear();

    // 重置所有状态
    emit(TransferState.initial());
  }
}

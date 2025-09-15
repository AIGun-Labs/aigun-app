import 'dart:async';
import 'dart:math';

import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:flutter_aigun/data/services/api/transfer_api.dart';
import 'package:flutter_aigun/utils/validators/risk_validator.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/utils/web3/gas_calculator.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (state.chainId > 0) {
      getGas(state.chainId);
    }

    if (_gasUpdateTimer != null) {
      _gasUpdateTimer?.cancel();
    }

    // 每10秒更新一次
    _gasUpdateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (state.chainId > 0) {
        getGas(state.chainId);
      }
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
  void updateToken(String tokenAddress, int chainId, {int decimals = 18}) {
    emit(state.copyWith(
      tokenAddress: tokenAddress,
      chainId: chainId,
      decimals: decimals,
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
  Future<void> getGas(int chainId) async {
    emit(state.copyWith(loadingGas: true));
    try {
      // 获取 gas 费用
      final gas = await transferApi.getGasFee(
        chainId: chainId.toString(),
      );

      // 添加调试日志

      // 计算实际的 gas 费用
      final calculatedGas = GasCalculator.calculateGasFee(
        gasPrice: gas.gas,
      );

      emit(state.copyWith(
        gas: gas,
        calculatedGas: calculatedGas,
      ));
    } catch (e) {
      // 获取 gas 费用失败
      emit(state.copyWith(loadingGas: false));
    } finally {
      emit(state.copyWith(loadingGas: false));
    }
  }

// 转账
  Future<void> transferToken(
    int chainId,
    String fromAddress,
    String toAddress,
    String amount,
    String tokenMint,
    // String paymentPin,
    Function(bool) callback,
  ) async {
    emit(state.copyWith(
        isSending: true,
        transferStatus: const TransferStatus.loading(),
        riskChallenge: const RiskChallenge.initial()));

    try {
// 普通的转账接口
      // 修复：使用double.parse处理带小数点的金额，然后乘以10^decimals得到正确精度
      final amountValue = double.parse(amount);
      final newAmount =
          (amountValue * pow(10, state.selectedToken!.decimals)).toInt();

      final transaction = await transferApi.transferToken(
        chainId: chainId,
        fromAddress: fromAddress,
        toAddress: toAddress,
        amount: newAmount.toString(),
        tokenMint: tokenMint,
        // organizationId: organizationId,
        // walletUserId: walletUserId,
        // paymentPin: paymentPin,
        // challenge: challenge,
      );

// 根据挑战类型设置挑战类型
      switch (transaction.type) {
        case "CAPTCHA":
          // 设置图形点选文字验证码
          emit(state.copyWith(
              riskChallenge: RiskChallenge.captcha(transaction.captcha)));
          break;
        case "SMS":
          // 设置短信验证码
          emit(state.copyWith(
              riskChallenge: RiskChallenge.sms(transaction.sms)));
          break;
        default:
          // 否则直接转账成功
          emit(state.copyWith(isSending: false, isSuccess: true, isSent: true));
          emit(state.copyWith(
              transferStatus: TransferStatus.success(transaction)));
          callback(true);
          break;
      }
      emit(state.copyWith(
        transferStatus: TransferStatus.success(transaction),
        riskChallenge: const RiskChallenge.success(),
        isSending: false,
        isSuccess: true,
        // isSent: true,
        transaction: transaction,
      ));

// TODO：先延迟两秒成功，后续等后端的轮询接口成功之后显示成功
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(isSent: true));
      });
    } catch (e) {
      showSimpleToast("转账失败，err: ${e.toString()}");
      emit(state.copyWith(
        transferStatus: const TransferStatus.failure(), // 转账失败
        riskChallenge: const RiskChallenge.failure(), // 挑战失败
        isSending: false,
        isSuccess: false,
        isSent: false,
      ));
    }
  }

  String getWalletAddress() {
    return walletCubit.state.wallets.first.addresses!
        .firstWhere(
            (address) => address.chainId == state.selectedToken?.chainId)
        .address!;
  }

// 携带短信验证码的转账接口
  Future<void> transferTokenWithSmsChallenge(String smsCode) async {
    // 校验短信验证码
    if (!RiskValidator.validateSmsCode(smsCode).isValid) {
      emit(state.copyWith(riskChallenge: const RiskChallenge.failure()));
      return;
    }

    await transferWithChallenge({
      "sms": {"code": smsCode}
    });
  }

  // 携带图形点选文字验证码的转账接口
  Future<void> transferTokenWithCaptchaChallenge(
      String? captchaKey, String? captchaDots) async {
    await transferWithChallenge({
      "captcha": {
        "key": captchaKey ?? "",
        "dots": captchaDots ?? "",
      },
    });
  }

// 公共转账接口
  Future<void> transferWithChallenge(Map<String, dynamic> challenge) async {
    emit(state.copyWith(
        riskChallenge: const RiskChallenge.loading(),
        transferStatus: const TransferStatus.loading(),
        isSending: true));

    try {
      final transaction = await transferApi.transferToken(
        chainId: state.chainId,
        fromAddress: state.selectedToken?.tokenAddress ?? "",
        toAddress: state.toAddress,
        amount: state.amount,
        tokenMint: state.tokenAddress,
        // organizationId: "baa83bed-f411-4660-ace9-c663d57e9830",
        // walletUserId: "ff16d13b-2611-53d6-b171-5044a6b0eac2",
        // paymentPin: state.paymentPin,
        // challenge: challenge,
      );

// 转账成功
      emit(state.copyWith(
        transferStatus: TransferStatus.success(transaction),
        riskChallenge: const RiskChallenge.success(),
        isSending: false,
        isSuccess: true,
        isSent: true,
      ));
    } catch (e) {
      // 转账失败
      emit(state.copyWith(
          transferStatus: const TransferStatus.failure(),
          riskChallenge: const RiskChallenge.failure(),
          isSending: false,
          isFailed: true));
    }
  }

// 更新选中的token
  void updateSelectedToken(Token token) {
    emit(state.copyWith(selectedToken: token));

// if(token.chainType == 'EVM')  {
//   walletCubit.selectWallet()
// }

    getGas(token.chainId);
    updateAmount('');
    updateToAddress('');
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

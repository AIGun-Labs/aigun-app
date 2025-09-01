import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/data/models/wallet/token/token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';

part 'transfer_state.freezed.dart';

@freezed
sealed class TransferStatus with _$TransferStatus {
  const factory TransferStatus.initial() = _Initial;
  const factory TransferStatus.loading() = _Loading;
  const factory TransferStatus.success(TransferTransaction transaction) =
      _Success;
  const factory TransferStatus.failure() = _Failure;
}

@freezed
sealed class RiskChallenge with _$RiskChallenge {
  const factory RiskChallenge.initial() = _RiskChallengeInitial;
  const factory RiskChallenge.loading() = _RiskChallengeLoading;
  const factory RiskChallenge.captcha(Captcha? captcha) = _RiskChallengeCaptcha;
  const factory RiskChallenge.sms(Sms? sms) = _RiskChallengeSms;
  const factory RiskChallenge.success() = _RiskChallengeSuccess;
  const factory RiskChallenge.failure() = _RiskChallengeFailure;
}

@freezed
class TransferState with _$TransferState {
  const factory TransferState({
    @Default('') String tokenAddress,
    @Default(0) int chainId,
    @Default('') String toAddress,
    @Default('') String amount,
    @Default(null) Gas? gas,
    @Default(null) EtherAmount? calculatedGas,
    @Default(18) int decimals,
    @Default(false) bool gasError,
    @Default(false) bool addressError,
    @Default(false) bool amountError,
    @Default(false) bool loadingGas,
    @Default(false) bool isSending,
    @Default(false) bool isSent,
    @Default(false) bool isFailed,
    @Default('') String failedReason,
    @Default(false) bool isSuccess,
    @Default(null) Token? selectedToken,
    @Default(TransferStatus.initial()) TransferStatus transferStatus, // 转出的发送状态
    @Default(RiskChallenge.initial()) RiskChallenge riskChallenge,
    @Default("") String paymentPin,
    TransferTransaction? transaction,
    // 不要直接在这里初始化 TextEditingController
    required TextEditingController toAddressController,
    required TextEditingController amountController,
  }) = _TransferState;

  // 使用工厂构造函数来正确初始化 TextEditingController
  factory TransferState.initial() => TransferState(
        toAddressController: TextEditingController(),
        amountController: TextEditingController(),
      );
}

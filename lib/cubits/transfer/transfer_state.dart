import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/index.dart';
import '../../data/models/transfer/index.dart';
import '../../widgets/token/models/token.dart';

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
sealed class TransferState with _$TransferState {
  const factory TransferState({
    @Default('') String tokenAddress,
    @Default('0') String chainId,
    @Default('') String toAddress,
    @Default('') String amount,
    @Default(null) Gas? gas,
    @Default(18) int decimals,
    @Default(false) bool gasError,
    @Default(true) bool addressError, //  address  amount
    @Default(true) bool amountError,
    @Default(false) bool loadingGas,
    @Default(false) bool isSending,
    @Default(false) bool isSent,
    @Default(false) bool isFailed,
    @Default('') String failedReason,
    @Default(false) bool isSuccess,
    @Default(null) Token? selectedToken,
    @Default(TransferStatus.initial()) TransferStatus transferStatus, //
    @Default(RiskChallenge.initial()) RiskChallenge riskChallenge,
    @Default('') String paymentPin,
    TransferTransaction? transaction,
    required TextEditingController toAddressController,
    required TextEditingController amountController,
  }) = _TransferState;
  factory TransferState.initial() => TransferState(
    toAddressController: TextEditingController(),
    amountController: TextEditingController(),
  );
}

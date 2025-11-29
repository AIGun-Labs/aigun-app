import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

enum SignUpStatus { initial, signUpSuccess, signUpFail }

enum PaymentPinStatus { inital, paymentPinInvalid, paymentPinValid }

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String paymentPin,
    @Default('') String inviteCode,
    @Default('') String nickname,
    @Default(SignUpStatus.initial) SignUpStatus signUpStatus,
    @Default(PaymentPinStatus.inital) PaymentPinStatus paymentPinStatus,
  }) = _SignUpState;
}

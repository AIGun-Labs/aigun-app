import "package:freezed_annotation/freezed_annotation.dart";

part "sign_in_state.freezed.dart";

enum SignInStatus {
  initial,
  loading,
  failure,
  success,
}

enum NicknameStatus { initial, failure, success }

enum PaymentPinStatus { initial, failure, success }

enum InviteCodeStatus { initial, failure, success }

// signin 登录状态

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    // @Default("") String email,
    // @Default("") String verificationCode,
    // @Default("") String emailError,
    // @Default("") String verificationCodeError,
    // @Default(false) bool isLoading,
    @Default("") String inviteCode,
    @Default("") String paymentPin,
    @Default("") String email,
    @Default("") String verificationCode,
    @Default(SignInStatus.initial) SignInStatus status,
    @Default(NicknameStatus.initial) NicknameStatus nicknameStatus,
    @Default(PaymentPinStatus.initial) PaymentPinStatus paymentPinStatus,
    @Default(InviteCodeStatus.initial) InviteCodeStatus inviteCodeStatus,
  }) = _SignInState;
}

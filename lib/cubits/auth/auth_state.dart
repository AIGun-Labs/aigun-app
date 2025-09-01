import "package:flutter_aigun/cubits/network/network_state.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "auth_state.freezed.dart";

@freezed
sealed class SingleShotEvent with _$SingleShotEvent {
  // 修改：传递 key，而不是 message
  const factory SingleShotEvent.showDialog({
    required String titleKey,
    required String messageKey,
  }) = _ShowDialog;

  const factory SingleShotEvent.loginSuccess() = _LoginSuccess;

  const factory SingleShotEvent.userExists() = _UserExists;
}

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default("") String email,
    @Default("") String code,
    @Default("") String nickname,
    @Default("") String inviteCode,
    @Default(NetworkState.initial()) NetworkState<void> sendCodeStatus,
    @Default(NetworkState.initial()) NetworkState<void> verifyCodeStatus,
    @Default(NetworkState.initial()) NetworkState<void> registerStatus,
    @Default(true) bool isCodeValid,
    @Default(true) bool isNicknameValid,
    @Default(true) bool isInviteCodeValid,
    @Default(true) bool isEmailValid,
    @Default(false) bool isUserExists,
    @Default(false) bool isLoading,
    @Default(0) int thanksMessageId,
    @Default("") String paymentPin,
    @Default(true) bool isPaymentPinValid,
    @Default(false) bool isLoggedIn,
    SingleShotEvent? event,
  }) = _AuthState;
}

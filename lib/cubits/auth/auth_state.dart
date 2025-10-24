import "package:freezed_annotation/freezed_annotation.dart";

part "auth_state.freezed.dart";

enum SendCodeFailure { unknown, sendCodeFail, emailInvalid, sendCodeMany }

enum VerifyCodeFailure {
  unknown,
  verifyCodeInvalidFormat,
  verifyCodeFail,
  verifyCodeExpired,
  userNotExist,
  userExist
}

enum RegisterFailure {
  unknow,
  registerFail,
  nicknameInvalid,
  inviteCodeInvalid,
  paymentPinInvalid,
  userExist,
  createWalletFail,
  walletUserExist,
  walletPinInvalid,
  ageNotConfirmed,
}

enum CreateThanksMessageFailure {
  unknown,
  createThanksMessageFail,
  userNotExist,
  inviteCodeInvalid,
  messageIdInvalid,
}

@freezed
sealed class CreateThanksMessageStatus with _$CreateThanksMessageStatus {
  const CreateThanksMessageStatus._();

  const factory CreateThanksMessageStatus.initial() =
      _CreateThanksMessageInitial;
  const factory CreateThanksMessageStatus.loading() =
      _CreateThanksMessageLoading;
  const factory CreateThanksMessageStatus.success() =
      _CreateThanksMessageSuccess;
  const factory CreateThanksMessageStatus.failure(
      CreateThanksMessageFailure failure) = _CreateThanksMessageError;

  bool get isCreatingThanksMessage => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}

@freezed
sealed class RegisterStatus with _$RegisterStatus {
  const RegisterStatus._();

  const factory RegisterStatus.initial() = _RegisterInitial;
  const factory RegisterStatus.loading() = _RegisterLoading;
  const factory RegisterStatus.success() = _RegisterSuccess;
  const factory RegisterStatus.failure(RegisterFailure failure) =
      _RegisterError;

  bool get isRegistering => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}

@freezed
sealed class SendCodeStatus with _$SendCodeStatus {
  const SendCodeStatus._();

  const factory SendCodeStatus.initial() = _SendCodeInitial;
  const factory SendCodeStatus.loading() = _SendCodeLoading;
  const factory SendCodeStatus.success() = _SendCodeSuccess;
  const factory SendCodeStatus.failure(SendCodeFailure failure) =
      _SendCodeError;

  bool get isSendingCode => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}

@freezed
sealed class VerifyCodeStatus with _$VerifyCodeStatus {
  const VerifyCodeStatus._();

  const factory VerifyCodeStatus.initial() = _VerifyCodeInitial;
  const factory VerifyCodeStatus.loading() = _VerifyCodeLoading;
  const factory VerifyCodeStatus.success() = _VerifyCodeSuccess;
  const factory VerifyCodeStatus.failure(VerifyCodeFailure failure) =
      _VerifyCodeError;

  bool get isVerifyingCode => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}

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
    @Default(SendCodeStatus.initial()) SendCodeStatus sendCodeState,
    @Default(VerifyCodeStatus.initial()) VerifyCodeStatus verifyCodeState,
    @Default(RegisterStatus.initial()) RegisterStatus registerState,
    @Default(CreateThanksMessageStatus.initial())
    CreateThanksMessageStatus createThanksMessageState,
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
    @Default(false) bool isAgeConfirmed,
    @Default(false) bool isAgeConfirmedValid,
    SingleShotEvent? event,
  }) = _AuthState;
}

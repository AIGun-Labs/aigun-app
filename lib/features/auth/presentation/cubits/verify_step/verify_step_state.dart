import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_step_state.freezed.dart';

/// Verify step failure types
enum VerifyStepFailure {
  /// Unknown error
  unknown,

  /// Code format is invalid (not 6 digits)
  codeInvalidFormat,

  /// Verification code is incorrect
  codeFail,

  /// Verification code has expired
  codeExpired,

  /// User does not exist (new user)
  userNotExist,

  /// User already exists (existing user)
  userExist,
}

/// Verify Step Status - Sealed union for verify step states
@freezed
sealed class VerifyStepStatus with _$VerifyStepStatus {
  const VerifyStepStatus._();

  const factory VerifyStepStatus.initial() = VerifyStepInitial;
  const factory VerifyStepStatus.loading() = VerifyStepLoading;
  const factory VerifyStepStatus.success() = VerifyStepSuccess;
  const factory VerifyStepStatus.failure(VerifyStepFailure failure,
      {int? errorCode}) = VerifyStepError;

  bool get isVerifying => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}

/// Verify Step State
@freezed
sealed class VerifyStepState with _$VerifyStepState {
  const VerifyStepState._();

  const factory VerifyStepState({
    /// Current verification code input
    @Default('') String code,

    /// Current status
    @Default(VerifyStepStatus.initial()) VerifyStepStatus status,

    /// Error code from business exception
    int? errorCode,
  }) = _VerifyStepState;

  /// Check if currently verifying
  bool get isVerifying => status is VerifyStepLoading;

  /// Check if verification was successful
  bool get isSuccess => status is VerifyStepSuccess;

  /// Check if there is an error
  bool get hasError => status is VerifyStepError;

  /// Check if code is valid format (6 digits)
  bool get isCodeValid => code.length == 6 && RegExp(r'^\d{6}$').hasMatch(code);

  /// Check if can submit (valid code and not loading)
  bool get canSubmit => isCodeValid && !isVerifying;
}

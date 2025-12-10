import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

/// Countdown duration for resend code (in seconds)
const int kResendCodeCountdownSeconds = 60;

/// Authentication step in the login flow
enum AuthStep {
  /// Email input step
  email,

  /// Verification code input step
  verifyCode,

  /// Profile registration step (for new users)
  profile,

  /// Success/thanks message step (after registration with invite code)
  success,
}

/// Main Auth State - Coordinates the overall authentication flow
@freezed
sealed class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    /// Current step in the auth flow
    @Default(AuthStep.email) AuthStep currentStep,

    /// Email address being used for authentication
    @Default('') String email,

    /// Verification code entered by user
    @Default('') String verificationCode,

    /// Invite code entered by user (for profile step)
    @Default('') String inviteCode,

    /// Whether any operation is in progress
    @Default(false) bool isLoading,

    /// Error message if any
    String? errorMessage,

    /// Whether user is authenticated
    @Default(false) bool isAuthenticated,

    /// Timestamp when verification code was last sent (for countdown)
    DateTime? lastCodeSentAt,

    /// Selected thanks message index for success step
    @Default(0) int thanksMessageIndex,

    /// Whether thanks message was submitted successfully
    @Default(false) bool thanksMessageSubmitted,
  }) = _AuthState;

  /// Check if user is on email step
  bool get isEmailStep => currentStep == AuthStep.email;

  /// Check if user is on verify code step
  bool get isVerifyCodeStep => currentStep == AuthStep.verifyCode;

  /// Check if user is on profile step
  bool get isProfileStep => currentStep == AuthStep.profile;

  /// Check if user is on success step
  bool get isSuccessStep => currentStep == AuthStep.success;

  /// Check if there is an error
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  /// Get step index for PageView
  int get stepIndex => currentStep.index;

  /// Calculate remaining seconds for resend code countdown
  int get remainingSeconds {
    if (lastCodeSentAt == null) return 0;
    final elapsed = DateTime.now().difference(lastCodeSentAt!).inSeconds;
    final remaining = kResendCodeCountdownSeconds - elapsed;
    return remaining > 0 ? remaining : 0;
  }

  /// Check if user can resend code (countdown finished)
  bool get canResendCode => remainingSeconds <= 0;
}

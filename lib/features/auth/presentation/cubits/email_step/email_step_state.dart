import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_step_state.freezed.dart';

/// Resend code countdown interval in seconds
const int kResendCodeInterval = 60;

/// Email step failure types
enum EmailStepFailure {
  /// Unknown error
  unknown,

  /// Email format is invalid
  emailInvalid,

  /// Send code failed
  sendCodeFail,

  /// Too many send code requests
  sendCodeTooMany,
}

/// Email Step Status - Sealed union for email step states
@freezed
sealed class EmailStepStatus with _$EmailStepStatus {
  const EmailStepStatus._();

  const factory EmailStepStatus.initial() = EmailStepInitial;
  const factory EmailStepStatus.sending() = EmailStepSending;
  const factory EmailStepStatus.sent() = EmailStepSent;
  const factory EmailStepStatus.failure(EmailStepFailure failure,
      {int? errorCode}) = EmailStepError;

  bool get isSending => maybeWhen(
        orElse: () => false,
        sending: () => true,
      );
}

/// Email Step State
@freezed
sealed class EmailStepState with _$EmailStepState {
  const EmailStepState._();

  const factory EmailStepState({
    /// Current email input
    @Default('') String email,

    /// Current status
    @Default(EmailStepStatus.initial()) EmailStepStatus status,

    /// Error code from business exception
    int? errorCode,

    /// Timestamp when code was last sent (for countdown)
    DateTime? lastSentAt,
  }) = _EmailStepState;

  /// Check if currently sending code
  bool get isSending => status is EmailStepSending;

  /// Check if code was sent successfully
  bool get isSent => status is EmailStepSent;

  /// Check if there is an error
  bool get hasError => status is EmailStepError;

  /// Check if can send code (not currently sending)
  bool get canSend => !isSending;

  /// Check if can resend code (countdown finished)
  bool get canResend {
    if (lastSentAt == null) return true;
    final elapsed = DateTime.now().difference(lastSentAt!).inSeconds;
    return elapsed >= kResendCodeInterval;
  }

  /// Get remaining seconds for countdown
  int get remainingSeconds {
    if (lastSentAt == null) return 0;
    final elapsed = DateTime.now().difference(lastSentAt!).inSeconds;
    final remaining = kResendCodeInterval - elapsed;
    return remaining > 0 ? remaining : 0;
  }

  /// Check if email is valid format
  bool get isEmailValid {
    if (email.isEmpty) return false;
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}

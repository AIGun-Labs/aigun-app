import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_exceptions.dart';
import '../../../../../core/types/result.dart';
import '../../../application/usecases/send_verification_code.dart';
import '../../../domain/constants/auth_error_codes.dart';
import 'email_step_state.dart';

/// Email Step Cubit
///
/// Manages the email input step of the authentication flow.
/// Handles sending verification codes and countdown timer.
class EmailStepCubit extends Cubit<EmailStepState> {
  final SendVerificationCode _sendVerificationCode;

  /// Callback when code is sent successfully
  void Function()? onCodeSent;

  /// Callback when error occurs (with failure type and optional error code)
  void Function(EmailStepFailure failure, int? code)? onSendError;

  EmailStepCubit({required SendVerificationCode sendVerificationCode})
    : _sendVerificationCode = sendVerificationCode,
      super(const EmailStepState());

  // ==================== Input Handling ====================

  /// Update email value
  void emailChanged(String email) {
    emit(
      state.copyWith(
        email: email.trim(),
        status: const EmailStepStatus.initial(),
        errorCode: null,
      ),
    );
  }

  /// Clear email input
  void clearEmail() {
    emit(
      state.copyWith(
        email: '',
        status: const EmailStepStatus.initial(),
        errorCode: null,
      ),
    );
  }

  // ==================== Send Verification Code ====================

  /// Send verification code to the email
  Future<void> sendCode() async {
    // Validate email
    if (!state.isEmailValid) {
      emit(
        state.copyWith(
          status: const EmailStepStatus.failure(EmailStepFailure.emailInvalid),
        ),
      );
      onSendError?.call(EmailStepFailure.emailInvalid, null);
      return;
    }

    emit(
      state.copyWith(
        status: const EmailStepStatus.sending(),
        errorCode: null,
      ),
    );

    final result = await _sendVerificationCode.call(email: state.email);

    result.whenOrNull(
      success: (_) {
        emit(
          state.copyWith(
            status: const EmailStepStatus.sent(),
            lastSentAt: DateTime.now(),
          ),
        );
        onCodeSent?.call();
      },
      failure: (message) {
        emit(
          state.copyWith(
            status: const EmailStepStatus.failure(EmailStepFailure.sendCodeFail),
          ),
        );
        onSendError?.call(EmailStepFailure.sendCodeFail, null);
      },
      be: (be) {
        _handleBusinessException(be);
      },
    );
  }

  /// Handle business exception with specific error codes
  void _handleBusinessException(BusinessException be) {
    EmailStepFailure failure = EmailStepFailure.unknown;

    // Map error codes to failure types
    switch (be.code) {
      case AuthErrorCodes.emailInvalid:
        failure = EmailStepFailure.emailInvalid;
        break;
      case AuthErrorCodes.sendCodeTooFrequently:
      case AuthErrorCodes.sendCodeTooMany:
        failure = EmailStepFailure.sendCodeTooMany;
        break;
      default:
        failure = EmailStepFailure.unknown;
    }

    emit(
      state.copyWith(
        status: EmailStepStatus.failure(failure, errorCode: be.code),
        errorCode: be.code,
      ),
    );
    onSendError?.call(failure, be.code);
  }

  // ==================== State Reset ====================

  /// Reset to initial state
  void reset() {
    emit(const EmailStepState());
  }

  /// Reset error state only
  void clearError() {
    emit(
      state.copyWith(
        status: const EmailStepStatus.initial(),
        errorCode: null,
      ),
    );
  }
}

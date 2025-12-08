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

  /// Callback when error occurs (with optional error code)
  void Function(String message, int? code)? onSendError;

  EmailStepCubit({
    required SendVerificationCode sendVerificationCode,
  })  : _sendVerificationCode = sendVerificationCode,
        super(const EmailStepState());

  // ==================== Input Handling ====================

  /// Update email value
  void emailChanged(String email) {
    emit(state.copyWith(
      email: email.trim(),
      status: const EmailStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }

  /// Clear email input
  void clearEmail() {
    emit(state.copyWith(
      email: '',
      status: const EmailStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }

  // ==================== Send Verification Code ====================

  /// Send verification code to the email
  Future<void> sendCode() async {
    // Validate email
    if (!state.isEmailValid) {
      emit(state.copyWith(
        status: const EmailStepStatus.error('Please enter a valid email'),
        errorMessage: 'Please enter a valid email',
      ));
      onSendError?.call('Please enter a valid email', null);
      return;
    }

    // Check if can send (not in cooldown)
    if (!state.canResend) {
      return;
    }

    emit(state.copyWith(
      status: const EmailStepStatus.sending(),
      errorMessage: null,
      errorCode: null,
    ));

    final result = await _sendVerificationCode.call(email: state.email);

    result.when(
      success: (_) {
        emit(state.copyWith(
          status: const EmailStepStatus.sent(),
          lastSentAt: DateTime.now(),
        ));
        onCodeSent?.call();
      },
      failure: (message) {
        emit(state.copyWith(
          status: EmailStepStatus.error(message),
          errorMessage: message,
        ));
        onSendError?.call(message, null);
      },
      loading: () {
        // Already handled above
      },
      be: (be) {
        _handleBusinessException(be);
      },
    );
  }

  /// Handle business exception with specific error codes
  void _handleBusinessException(BusinessException be) {
    String message = be.msg;

    // Map error codes to user-friendly messages
    switch (be.code) {
      case AuthErrorCodes.emailInvalid:
        message = 'Invalid email format';
        break;
      case AuthErrorCodes.sendCodeTooFrequently:
      case AuthErrorCodes.sendCodeTooMany:
        message = 'Too many requests. Please wait and try again.';
        break;
    }

    emit(state.copyWith(
      status: EmailStepStatus.error(message, errorCode: be.code),
      errorMessage: message,
      errorCode: be.code,
    ));
    onSendError?.call(message, be.code);
  }

  // ==================== State Reset ====================

  /// Reset to initial state
  void reset() {
    emit(const EmailStepState());
  }

  /// Reset error state only
  void clearError() {
    emit(state.copyWith(
      status: const EmailStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }
}

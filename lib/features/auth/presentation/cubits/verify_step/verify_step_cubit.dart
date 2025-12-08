import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_exceptions.dart';
import '../../../../../core/types/result.dart';
import '../../../application/usecases/verify_code.dart';
import '../../../domain/constants/auth_error_codes.dart';
import '../../../domain/entities/auth_result_entity.dart';
import 'verify_step_state.dart';

/// Verify Step Cubit
///
/// Manages the verification code step of the authentication flow.
/// Handles code verification and result processing.
class VerifyStepCubit extends Cubit<VerifyStepState> {
  final VerifyCode _verifyCode;

  /// Callback when verification is successful
  /// Returns the auth result (existing user or new user required)
  void Function(AuthResultEntity result)? onVerifySuccess;

  /// Callback when verification fails (with optional error code)
  void Function(String message, int? code)? onVerifyError;

  VerifyStepCubit({
    required VerifyCode verifyCode,
  })  : _verifyCode = verifyCode,
        super(const VerifyStepState());

  // ==================== Input Handling ====================

  /// Update code value
  void codeChanged(String code) {
    // Only allow digits and max 6 characters
    final sanitized = code.replaceAll(RegExp(r'[^\d]'), '');
    final trimmed = sanitized.length > 6 ? sanitized.substring(0, 6) : sanitized;

    emit(state.copyWith(
      code: trimmed,
      status: const VerifyStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }

  /// Clear code input
  void clearCode() {
    emit(state.copyWith(
      code: '',
      status: const VerifyStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }

  // ==================== Verify Code ====================

  /// Verify the code for the given email
  Future<void> verify(String email) async {
    // Validate code
    if (!state.isCodeValid) {
      emit(state.copyWith(
        status: const VerifyStepStatus.error('Please enter a valid 6-digit code'),
        errorMessage: 'Please enter a valid 6-digit code',
      ));
      onVerifyError?.call('Please enter a valid 6-digit code', null);
      return;
    }

    emit(state.copyWith(
      status: const VerifyStepStatus.loading(),
      errorMessage: null,
      errorCode: null,
    ));

    final result = await _verifyCode.call(email: email, code: state.code);

    result.when(
      success: (authResult) {
        emit(state.copyWith(status: const VerifyStepStatus.success()));
        onVerifySuccess?.call(authResult);
      },
      failure: (message) {
        emit(state.copyWith(
          status: VerifyStepStatus.error(message),
          errorMessage: message,
        ));
        onVerifyError?.call(message, null);
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
      case AuthErrorCodes.codeExpired:
        message = 'Verification code has expired. Please request a new one.';
        break;
      case AuthErrorCodes.codeInvalid:
        message = 'Invalid verification code. Please try again.';
        break;
      case AuthErrorCodes.userExists:
        // User exists - this might be handled differently
        message = 'User already exists';
        break;
    }

    emit(state.copyWith(
      status: VerifyStepStatus.error(message, errorCode: be.code),
      errorMessage: message,
      errorCode: be.code,
    ));
    onVerifyError?.call(message, be.code);
  }

  // ==================== State Reset ====================

  /// Reset to initial state
  void reset() {
    emit(const VerifyStepState());
  }

  /// Reset error state only
  void clearError() {
    emit(state.copyWith(
      status: const VerifyStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }
}

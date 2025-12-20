import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/types/result.dart';
import '../../../../../infrastructure/network/error/app_exception.dart';
import '../../../../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../../../application/usecases/verify_code.dart';
import '../../../domain/constants/auth_error_codes.dart';
import 'verify_step_state.dart';

/// Verify Step Cubit
///
/// Manages the verification code step of the authentication flow.
/// Handles code verification and result processing.
class VerifyStepCubit extends Cubit<VerifyStepState> {
  VerifyStepCubit({
    required VerifyCode verifyCode,
    required NewUserCubit newUserCubit,
  }) : _verifyCode = verifyCode,
       _newUserCubit = newUserCubit,
       super(const VerifyStepState());
  final VerifyCode _verifyCode;
  final NewUserCubit _newUserCubit;
  // ==================== Input Handling ====================

  /// Update code value
  void codeChanged(String code) {
    // Only allow digits and max 6 characters
    final sanitized = code.replaceAll(RegExp(r'[^\d]'), '');
    final trimmed = sanitized.length > 6
        ? sanitized.substring(0, 6)
        : sanitized;

    emit(
      state.copyWith(
        code: trimmed,
        status: const VerifyStepStatus.initial(),
        errorCode: null,
      ),
    );
  }

  /// Clear code input
  void clearCode() {
    emit(
      state.copyWith(
        code: '',
        status: const VerifyStepStatus.initial(),
        errorCode: null,
      ),
    );
  }

  // ==================== Verify Code ====================

  /// Verify the code for the given email
  Future<void> verify(String email) async {
    // Always emit loading first to ensure state change triggers UI update
    emit(
      state.copyWith(status: const VerifyStepStatus.loading(), errorCode: null),
    );

    // Validate code
    if (!state.isCodeValid) {
      emit(
        state.copyWith(
          status: const VerifyStepStatus.failure(
            VerifyStepFailure.codeInvalidFormat,
          ),
        ),
      );
      return;
    }

    final result = await _verifyCode.call(email: email, code: state.code);

    result.whenOrNull(
      success: (authResult) {
        emit(
          state.copyWith(
            status: const VerifyStepStatus.success(),
            authResult: authResult,
          ),
        );
      },
      failure: (message) {
        emit(
          state.copyWith(
            status: const VerifyStepStatus.failure(VerifyStepFailure.codeFail),
          ),
        );
      },
      loading: () {},
      be: (be) {
        _handleBusinessException(be);
      },
    );
  }

  /// Handle business exception with specific error codes
  void _handleBusinessException(BusinessException be) {
    VerifyStepFailure failure = VerifyStepFailure.unknown;

    // Map error codes to failure types
    switch (be.code) {
      case AuthErrorCodes.codeExpired:
        failure = VerifyStepFailure.codeExpired;
        break;
      case AuthErrorCodes.codeInvalid:
        failure = VerifyStepFailure.codeFail;
        break;
      case AuthErrorCodes.userNotExists:
        failure = VerifyStepFailure.userNotExist;
        break;
      case AuthErrorCodes.userExists:
        failure = VerifyStepFailure.userExist;
        break;
      default:
        failure = VerifyStepFailure.unknown;
    }

    emit(
      state.copyWith(
        status: VerifyStepStatus.failure(failure, errorCode: be.code),
        errorCode: be.code,
      ),
    );
  }

  // ==================== State Reset ====================

  /// Reset to initial state
  void reset() {
    emit(const VerifyStepState());
  }

  /// Reset error state only
  void clearError() {
    emit(
      state.copyWith(status: const VerifyStepStatus.initial(), errorCode: null),
    );
  }
}

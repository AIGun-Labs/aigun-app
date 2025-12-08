import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_exceptions.dart';
import '../../../../../core/types/result.dart';
import '../../../application/usecases/register_user.dart';
import '../../../application/usecases/submit_thanks_message.dart';
import '../../../domain/constants/auth_error_codes.dart';
import '../../../domain/entities/auth_result_entity.dart';
import 'profile_step_state.dart';

/// Profile Step Cubit
///
/// Manages the profile registration step of the authentication flow.
/// Handles user registration and thanks message submission.
class ProfileStepCubit extends Cubit<ProfileStepState> {
  final RegisterUser _registerUser;
  final SubmitThanksMessage _submitThanksMessage;

  /// Callback when registration is successful
  /// Returns the auth result with hasInviteCode flag
  void Function(AuthResultEntity result)? onRegisterSuccess;

  /// Callback when registration fails (with optional error code)
  void Function(String message, int? code)? onRegisterError;

  ProfileStepCubit({
    required RegisterUser registerUser,
    required SubmitThanksMessage submitThanksMessage,
  })  : _registerUser = registerUser,
        _submitThanksMessage = submitThanksMessage,
        super(const ProfileStepState());

  // ==================== Input Handling ====================

  /// Update nickname value
  void nicknameChanged(String nickname) {
    emit(state.copyWith(
      nickname: nickname,
      status: const ProfileStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }

  /// Update invite code value
  void inviteCodeChanged(String inviteCode) {
    // Convert to uppercase and limit to 6 characters
    final sanitized = inviteCode.toUpperCase();
    final trimmed =
        sanitized.length > 6 ? sanitized.substring(0, 6) : sanitized;

    emit(state.copyWith(
      inviteCode: trimmed,
      status: const ProfileStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }

  /// Toggle agreement to terms
  void toggleAgreement() {
    emit(state.copyWith(
      hasAgreedToTerms: !state.hasAgreedToTerms,
      status: const ProfileStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }

  /// Set agreement value directly
  void setAgreement(bool value) {
    emit(state.copyWith(
      hasAgreedToTerms: value,
      status: const ProfileStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }

  /// Alias for setAgreement - used by UI widgets
  void termsAgreementChanged(bool value) => setAgreement(value);

  /// Randomize thanks message ID (1-10)
  void randomizeThanksMessage() {
    final random = Random();
    emit(state.copyWith(thanksMessageId: random.nextInt(10) + 1));
  }

  // ==================== Register ====================

  /// Register the user
  Future<void> register({
    required String email,
    required String code,
  }) async {
    // Validate form
    if (!state.isFormValid) {
      String message = 'Please fill in all required fields';
      if (!state.isNicknameValid) {
        message = 'Please enter a valid nickname (1-20 characters)';
      } else if (!state.isInviteCodeValid) {
        message = 'Invite code must be 6 characters or less';
      } else if (!state.hasAgreedToTerms) {
        message = 'Please agree to the terms and conditions';
      }

      emit(state.copyWith(
        status: ProfileStepStatus.error(message),
        errorMessage: message,
      ));
      onRegisterError?.call(message, null);
      return;
    }

    emit(state.copyWith(
      status: const ProfileStepStatus.loading(),
      errorMessage: null,
      errorCode: null,
    ));

    final result = await _registerUser.call(
      email: email,
      code: code,
      nickname: state.nickname.trim(),
      inviteCode: state.hasInviteCode ? state.inviteCode.trim() : null,
    );

    result.when(
      success: (authResult) {
        emit(state.copyWith(status: const ProfileStepStatus.success()));
        onRegisterSuccess?.call(authResult);
      },
      failure: (message) {
        emit(state.copyWith(
          status: ProfileStepStatus.error(message),
          errorMessage: message,
        ));
        onRegisterError?.call(message, null);
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
      case AuthErrorCodes.inviteCodeInvalid:
        message = 'Invalid invite code';
        break;
      case AuthErrorCodes.userExists:
        message = 'User already exists';
        break;
      case AuthErrorCodes.codeExpired:
        message = 'Verification code has expired. Please start over.';
        break;
      case AuthErrorCodes.createWalletFail:
        message = 'Failed to create wallet. Please try again.';
        break;
      case AuthErrorCodes.walletUserExists:
        message = 'Wallet already exists for this user.';
        break;
    }

    emit(state.copyWith(
      status: ProfileStepStatus.error(message, errorCode: be.code),
      errorMessage: message,
      errorCode: be.code,
    ));
    onRegisterError?.call(message, be.code);
  }

  // ==================== Thanks Message ====================

  /// Submit thanks message for invite code
  Future<void> submitThanksMessage() async {
    if (!state.hasInviteCode) return;

    // Use current thanks message ID or random if not set
    final messageId =
        state.thanksMessageId > 0 ? state.thanksMessageId : Random().nextInt(10) + 1;

    await _submitThanksMessage.call(
      messageId: messageId,
      inviteCode: state.inviteCode.trim(),
    );
    // We don't need to handle the result here, it's just a best-effort submission
  }

  // ==================== State Reset ====================

  /// Reset to initial state
  void reset() {
    emit(const ProfileStepState());
  }

  /// Reset error state only
  void clearError() {
    emit(state.copyWith(
      status: const ProfileStepStatus.initial(),
      errorMessage: null,
      errorCode: null,
    ));
  }
}

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_exceptions.dart';
import '../../../../../core/types/result.dart';
import '../../../application/usecases/register_user.dart';
import '../../../application/usecases/submit_thanks_message.dart';
import '../../../domain/constants/auth_error_codes.dart';
import 'profile_step_state.dart';

/// Profile Step Cubit
///
/// Manages the profile registration step of the authentication flow.
/// Handles user registration and thanks message submission.
class ProfileStepCubit extends Cubit<ProfileStepState> {
  final RegisterUser _registerUser;
  final SubmitThanksMessage _submitThanksMessage;

  ProfileStepCubit({
    required RegisterUser registerUser,
    required SubmitThanksMessage submitThanksMessage,
  }) : _registerUser = registerUser,
       _submitThanksMessage = submitThanksMessage,
       super(const ProfileStepState());

  // ==================== Input Handling ====================

  /// Update nickname value
  void nicknameChanged(String nickname) {
    emit(
      state.copyWith(
        nickname: nickname,
        status: const ProfileStepStatus.initial(),
        errorCode: null,
      ),
    );
  }

  /// Update invite code value
  void inviteCodeChanged(String inviteCode) {
    // Convert to uppercase and limit to 6 characters
    final sanitized = inviteCode.toUpperCase();
    final trimmed = sanitized.length > 6
        ? sanitized.substring(0, 6)
        : sanitized;

    emit(
      state.copyWith(
        inviteCode: trimmed,
        status: const ProfileStepStatus.initial(),
        errorCode: null,
      ),
    );
  }

  /// Toggle agreement to terms
  void toggleAgreement() {
    emit(
      state.copyWith(
        hasAgreedToTerms: !state.hasAgreedToTerms,
        status: const ProfileStepStatus.initial(),
        errorCode: null,
      ),
    );
  }

  /// Set agreement value directly
  void setAgreement(bool value) {
    emit(
      state.copyWith(
        hasAgreedToTerms: value,
        status: const ProfileStepStatus.initial(),
        errorCode: null,
      ),
    );
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
  Future<void> register({required String email, required String code}) async {
    // Validate form
    if (!state.isFormValid) {
      ProfileStepFailure failure = ProfileStepFailure.formIncomplete;
      if (!state.isNicknameValid) {
        failure = ProfileStepFailure.nicknameInvalid;
      } else if (!state.isInviteCodeValid) {
        failure = ProfileStepFailure.inviteCodeInvalid;
      } else if (!state.hasAgreedToTerms) {
        failure = ProfileStepFailure.termsNotAgreed;
      }

      emit(state.copyWith(status: ProfileStepStatus.failure(failure)));
      return;
    }

    emit(
      state.copyWith(
        status: const ProfileStepStatus.loading(),
        errorCode: null,
      ),
    );

    final result = await _registerUser.call(
      email: email,
      code: code,
      nickname: state.nickname.trim(),
      inviteCode: state.hasInviteCode ? state.inviteCode.trim() : null,
    );

    result.when(
      success: (authResult) {
        emit(
          state.copyWith(
            status: const ProfileStepStatus.success(),
            authResult: authResult,
          ),
        );
      },
      failure: (message) {
        emit(
          state.copyWith(
            status: const ProfileStepStatus.failure(
              ProfileStepFailure.registerFail,
            ),
          ),
        );
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
    ProfileStepFailure failure = ProfileStepFailure.unknown;

    // Map error codes to failure types
    switch (be.code) {
      case AuthErrorCodes.inviteCodeInvalid:
        failure = ProfileStepFailure.inviteCodeInvalid;
        break;
      case AuthErrorCodes.userExists:
        failure = ProfileStepFailure.userExists;
        break;
      case AuthErrorCodes.codeExpired:
        failure = ProfileStepFailure.codeExpired;
        break;
      case AuthErrorCodes.createWalletFail:
        failure = ProfileStepFailure.createWalletFail;
        break;
      case AuthErrorCodes.walletUserExists:
        failure = ProfileStepFailure.walletUserExists;
        break;
      case AuthErrorCodes.walletPinInvalid:
        failure = ProfileStepFailure.walletPinInvalid;
        break;
      default:
        failure = ProfileStepFailure.unknown;
    }

    emit(
      state.copyWith(
        status: ProfileStepStatus.failure(failure, errorCode: be.code),
        errorCode: be.code,
      ),
    );
  }

  // ==================== Thanks Message ====================

  /// Submit thanks message for invite code
  Future<void> submitThanksMessage() async {
    if (!state.hasInviteCode) return;

    // Use current thanks message ID or random if not set
    final messageId = state.thanksMessageId > 0
        ? state.thanksMessageId
        : Random().nextInt(10) + 1;

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
    emit(
      state.copyWith(
        status: const ProfileStepStatus.initial(),
        errorCode: null,
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/business_code.dart';
import '../../../../../core/types/result.dart';
import '../../../../../core/utils/business_code_handler.dart';
import '../../../../../utils/toast.dart';
import '../../../application/usecases/submit_thanks_message.dart';
import '../../../domain/entities/auth_result_entity.dart';
import '../email_step/email_step_cubit.dart';
import '../profile_step/profile_step_cubit.dart';
import '../verify_step/verify_step_cubit.dart';
import 'auth_state.dart';

/// Main Auth Cubit - Coordinates the overall authentication flow
///
/// This cubit acts as a coordinator/orchestrator for the auth flow,
/// managing the step transitions and sub-cubit interactions.
class AuthCubit extends Cubit<AuthState> {
  final EmailStepCubit emailStepCubit;
  final VerifyStepCubit verifyStepCubit;
  final ProfileStepCubit profileStepCubit;
  final SubmitThanksMessage _submitThanksMessage;

  /// Callback when authentication is complete
  void Function(AuthResultEntity result)? onAuthComplete;

  /// Callback when user needs to navigate to home/wallet
  void Function()? onNavigateToHome;

  AuthCubit({
    required this.emailStepCubit,
    required this.verifyStepCubit,
    required this.profileStepCubit,
    required SubmitThanksMessage submitThanksMessage,
  }) : _submitThanksMessage = submitThanksMessage,
       super(const AuthState()) {
    _setupCallbacks();
  }

  // ==================== Setup ====================

  void _setupCallbacks() {
    // Email step callbacks
    emailStepCubit.onCodeSent = _onCodeSent;

    // Verify step callbacks
    verifyStepCubit.onVerifySuccess = _onVerifySuccess;

    // Profile step callbacks
    profileStepCubit.onRegisterSuccess = _onRegisterSuccess;
  }

  // ==================== Step Navigation ====================

  /// Go to a specific step
  void goToStep(AuthStep step) {
    emit(state.copyWith(currentStep: step, errorMessage: null));
  }

  /// Go to next step
  void nextStep() {
    final nextIndex = state.currentStep.index + 1;
    if (nextIndex < AuthStep.values.length) {
      goToStep(AuthStep.values[nextIndex]);
    }
  }

  /// Go to previous step
  void previousStep() {
    final prevIndex = state.currentStep.index - 1;
    if (prevIndex >= 0) {
      goToStep(AuthStep.values[prevIndex]);
    }
  }

  // ==================== Email Step Handlers ====================

  /// Called when email is changed
  void emailChanged(String email) {
    emailStepCubit.emailChanged(email);
    emit(state.copyWith(email: email));
  }

  /// Send verification code
  Future<void> sendCode() async {
    await emailStepCubit.sendCode();
  }

  /// Called when email is sent successfully (from widget)
  void onEmailSent(String email) {
    emit(state.copyWith(email: email, lastCodeSentAt: DateTime.now()));
    goToStep(AuthStep.verifyCode);
  }

  void _onCodeSent() {
    // Move to verify code step and update countdown
    emit(state.copyWith(lastCodeSentAt: DateTime.now()));
    goToStep(AuthStep.verifyCode);
  }

  // ==================== Verify Step Handlers ====================

  /// Called when code is changed
  void codeChanged(String code) {
    verifyStepCubit.codeChanged(code);
    emit(state.copyWith(verificationCode: code));
  }

  /// Verify the code
  Future<void> verifyCode() async {
    await verifyStepCubit.verify(state.email);
  }

  /// Called when verification is successful (from widget)
  void onVerifySuccess(AuthResultEntity result) {
    _onVerifySuccess(result);
  }

  void _onVerifySuccess(AuthResultEntity result) {
    result.when(
      existingUser: (user, tokens) {
        // User exists - authentication complete
        emit(state.copyWith(isAuthenticated: true, user: user));
        onAuthComplete?.call(result);
        onNavigateToHome?.call();
      },
      newUserRequired: () {
        // New user - go to profile step
        goToStep(AuthStep.profile);
      },
      registered: (user, tokens, hasInviteCode) {
        // This shouldn't happen from verify, but handle it
        emit(state.copyWith(isAuthenticated: true, user: user));
        onAuthComplete?.call(result);
        if (hasInviteCode) {
          goToStep(AuthStep.success);
        } else {
          onNavigateToHome?.call();
        }
      },
    );
  }

  // ==================== Profile Step Handlers ====================

  /// Called when nickname is changed
  void nicknameChanged(String nickname) {
    profileStepCubit.nicknameChanged(nickname);
  }

  /// Called when invite code is changed
  void inviteCodeChanged(String inviteCode) {
    profileStepCubit.inviteCodeChanged(inviteCode);
    emit(state.copyWith(inviteCode: inviteCode));
  }

  /// Toggle agreement to terms
  void toggleAgreement() {
    profileStepCubit.toggleAgreement();
  }

  /// Set agreement value
  void setAgreement(bool value) {
    profileStepCubit.setAgreement(value);
  }

  /// Register the user
  Future<void> register() async {
    await profileStepCubit.register(
      email: state.email,
      code: state.verificationCode,
    );
  }

  /// Called when registration is successful (from widget)
  void onRegisterSuccess(AuthResultEntity result) {
    _onRegisterSuccess(result);
  }

  void _onRegisterSuccess(AuthResultEntity result) {
    result.when(
      existingUser: (user, tokens) {
        // Shouldn't happen from register, but handle it
        emit(state.copyWith(isAuthenticated: true, user: user));
        onAuthComplete?.call(result);
        onNavigateToHome?.call();
      },
      newUserRequired: () {
        // Shouldn't happen, ignore
      },
      registered: (user, tokens, hasInviteCode) {
        emit(
          state.copyWith(
            isAuthenticated: true,
            user: user,
            inviteCode: hasInviteCode ? state.inviteCode : '',
          ),
        );
        onAuthComplete?.call(result);
        if (hasInviteCode) {
          goToStep(AuthStep.success);
        } else {
          onNavigateToHome?.call();
        }
      },
    );
  }

  // ==================== Success Step Handlers ====================

  /// Randomize thanks message
  void randomizeThanksMessage() {
    profileStepCubit.randomizeThanksMessage();
  }

  /// Submit thanks message and navigate home
  Future<void> submitThanksAndNavigate() async {
    await profileStepCubit.submitThanksMessage();
    onNavigateToHome?.call();
  }

  /// Submit thanks message with specific message ID
  Future<void> submitThanksMessage(int messageId) async {
    if (state.inviteCode.isEmpty) return;

    final result = await _submitThanksMessage.call(
      messageId: messageId,
      inviteCode: state.inviteCode,
    );

    result.whenOrNull(
      success: (_) {
        // Success - navigation handled by widget
      },
      failure: (message) {
        emit(state.copyWith(errorMessage: message));
      },
      be: (be) {
        emit(state.copyWith(errorMessage: be.msg));
      },
    );
  }

  // ==================== State Management ====================

  /// Reset all state
  void reset() {
    emailStepCubit.reset();
    verifyStepCubit.reset();
    profileStepCubit.reset();
    emit(const AuthState());
  }

  /// Set error message
  void setError(String message) {
    emit(state.copyWith(errorMessage: message));
  }

  /// Clear error
  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  // ==================== Lifecycle ====================

  @override
  Future<void> close() {
    // Note: Sub-cubits are managed by DI, so we don't close them here
    return super.close();
  }

  /// 处理业务异常，根据状态码执行不同操作
  Future<void> handleBusinessException({
    required BuildContext context,
    required int code,
    required String message,
  }) async {
    final message = BusinessCodeHandler.getErrorMessageFromBusinessCode(
      context,
      code,
    );

    switch (BusinessCode.fromCode(code)) {
      case BusinessCode.userExist: // 用户已存在
        ToastUtils.showSuccessToast(context, message: message);
        break;

      case BusinessCode.emailVerifyCodeCheckSuccess:
        ToastUtils.showSuccessToast(context, message: message);
        break;
      default:
        ToastUtils.showFailureToast(context, message: message);
        break;
    }
  }
}

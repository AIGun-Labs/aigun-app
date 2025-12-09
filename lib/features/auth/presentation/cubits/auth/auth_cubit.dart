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

  void onCodeResent() {
    emit(state.copyWith(lastCodeSentAt: DateTime.now()));
  }

  AuthCubit({
    required this.emailStepCubit,
    required this.verifyStepCubit,
    required this.profileStepCubit,
    required SubmitThanksMessage submitThanksMessage,
  }) : _submitThanksMessage = submitThanksMessage,
       super(const AuthState());

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
        emit(state.copyWith(isAuthenticated: true));
        onAuthComplete?.call(result);
        onNavigateToHome?.call();
      },
      newUserRequired: () {
        // New user - go to profile step
        goToStep(AuthStep.profile);
      },
      registered: (user, tokens, hasInviteCode) {
        // This shouldn't happen from verify, but handle it
        emit(state.copyWith(isAuthenticated: true));
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
        emit(state.copyWith(isAuthenticated: true));
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

  /// Randomize thanks message index
  void randomizeThanksMessage({int totalMessages = 10}) {
    final newIndex = DateTime.now().millisecondsSinceEpoch % totalMessages;
    emit(state.copyWith(thanksMessageIndex: newIndex));
  }

  /// Submit thanks message and navigate home
  Future<void> submitThanksAndNavigate() async {
    if (state.inviteCode.isEmpty) {
      onNavigateToHome?.call();
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _submitThanksMessage.call(
      messageId: state.thanksMessageIndex,
      inviteCode: state.inviteCode,
    );

    result.whenOrNull(
      loading: () {
        // Should not happen, but handle gracefully
      },
      success: (_) {
        emit(state.copyWith(isLoading: false, thanksMessageSubmitted: true));
        onNavigateToHome?.call();
      },
      failure: (message) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: message,
            thanksMessageSubmitted:
                true, // Still mark as submitted to allow navigation
          ),
        );
        onNavigateToHome?.call();
      },
      be: (be) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: be.msg,
            thanksMessageSubmitted: true,
          ),
        );
        onNavigateToHome?.call();
      },
    );
  }

  /// Submit thanks message with specific message ID (legacy method)
  @Deprecated('Use submitThanksAndNavigate instead')
  Future<void> submitThanksMessage(int messageId) async {
    emit(state.copyWith(thanksMessageIndex: messageId));
    await submitThanksAndNavigate();
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

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  AuthCubit({
    required this.emailStepCubit,
    required this.verifyStepCubit,
    required this.profileStepCubit,
    required SubmitThanksMessage submitThanksMessage,
  }) : _submitThanksMessage = submitThanksMessage,
       super(const AuthState());
  final EmailStepCubit emailStepCubit;
  final VerifyStepCubit verifyStepCubit;
  final ProfileStepCubit profileStepCubit;
  final SubmitThanksMessage _submitThanksMessage;

  /// Callback when authentication is complete
  void Function(AuthResultEntity result)? onAuthComplete;

  /// Callback when user needs to navigate to home/wallet
  void Function()? onNavigateToHome;
  void onCodeResent() {}
  void goToStep(AuthStep step) {}
  void nextStep() {}
  void previousStep() {}
  void emailChanged(String email) {}
  Future<void> sendCode() async {
    return;
  }

  void onEmailSent(String email) {}
  void codeChanged(String code) {}
  Future<void> verifyCode() async {
    return;
  }

  void onVerifySuccess(AuthResultEntity result) {}
  void _onVerifySuccess(AuthResultEntity result) {}
  void nicknameChanged(String nickname) {}
  void inviteCodeChanged(String inviteCode) {}
  void toggleAgreement() {}
  void setAgreement(bool value) {}
  Future<void> register() async {
    return;
  }

  void onRegisterSuccess(AuthResultEntity result) {}
  void _onRegisterSuccess(AuthResultEntity result) {}
  void randomizeThanksMessage({int totalMessages = 10}) {}
  Future<void> submitThanksAndNavigate() async {
    onNavigateToHome?.call();
    return;
  }

  /// Submit thanks message with specific message ID (legacy method)
  // @Deprecated('Use submitThanksAndNavigate instead')
  // Future<void> submitThanksMessage(int messageId) async {
  //   emit(state.copyWith(thanksMessageIndex: messageId));
  //   await submitThanksAndNavigate();
  // }
  void reset() {}
  void setError(String message) {}
  void clearError() {}

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> handleBusinessException({
    required BuildContext context,
    required int code,
    required String message,
  }) async {}
}

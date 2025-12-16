import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/services/index.dart';
import '../../enums/index.dart';
import '../../infrastructure/network/error/app_exception.dart';
import '../../utils/form_validators.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  final UserApi _userApi = GetIt.instance<UserApi>();

  void updateEmail(String value) {
    final emailError = FormValidators.isEmailValid(value);
    emit(
      state.copyWith(email: value, emailError: emailError, isEmailExists: true),
    );
  }

  void updateIsEmailCheckLoading(bool value) {
    emit(state.copyWith(isEmailCheckLoading: value));
  }

  void updateCode(String value) {
    emit(state.copyWith(code: value));
  }

  void updateNewPassword(String value) {
    final newPasswordError = FormValidators.isPasswordValid(value);
    emit(
      state.copyWith(newPassword: value, newPasswordError: newPasswordError),
    );
  }

  void updateConfirmPassword(String value) {
    final confirmPasswordError = FormValidators.isConfirmPasswordValid(
      value,
      state.newPassword,
    );
    emit(
      state.copyWith(
        confirmPassword: value,
        confirmPasswordError: confirmPasswordError,
      ),
    );
  }

  bool validateEmail() {
    final emailError = FormValidators.isEmailValid(state.email);
    emit(state.copyWith(emailError: emailError));
    return emailError == null;
  }

  bool validatePasswords() {
    final newPasswordError = FormValidators.isPasswordValid(state.newPassword);
    final confirmPasswordError = FormValidators.isConfirmPasswordValid(
      state.confirmPassword,
      state.newPassword,
    );

    emit(
      state.copyWith(
        newPasswordError: newPasswordError,
        confirmPasswordError: confirmPasswordError,
      ),
    );

    return newPasswordError == null && confirmPasswordError == null;
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      emit(
        state.copyWith(
          email: email,
          code: code,
          newPassword: newPassword,
          isLoading: true,
          queryStatus: QueryStatus.loading,
        ),
      );

      await _userApi.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
      );

      emit(const ForgotPasswordState(isSuccess: true));
    } catch (e) {
      emit(ForgotPasswordState(isError: true, errorMessage: e.toString()));
    }
  }

  Future<bool> checkEmailExists() async {
    try {
      emit(state.copyWith(isEmailCheckLoading: true));
      final emailStatus = await _userApi.checkEmailStatus(email: state.email);
      emit(state.copyWith(isEmailExists: emailStatus));
      return emailStatus;
    } catch (e) {
      emit(
        state.copyWith(
          isError: true,
          errorMessage: e is AppException ? e.message : 'An error occurred',
        ),
      );
      return false;
    } finally {
      emit(state.copyWith(isEmailCheckLoading: false));
    }
  }

  Future<void> sendVerificationCode({required String email}) async {
    try {
      emit(
        state.copyWith(
          email: email,
          isLoading: true,
          queryStatus: QueryStatus.loading,
        ),
      );

      await _userApi.sendVerificationCode(email: email, type: 'reset_password');

      emit(const ForgotPasswordState(isSuccess: true));
    } catch (e) {
      emit(ForgotPasswordState(isError: true, errorMessage: e.toString()));
    }
  }

  void reset() {
    emit(const ForgotPasswordState());
  }

  Future<void> sendResetPassword() async {
    if (!validatePasswords()) return;

    await resetPassword(
      email: state.email,
      code: state.code,
      newPassword: state.newPassword,
    );
  }
}

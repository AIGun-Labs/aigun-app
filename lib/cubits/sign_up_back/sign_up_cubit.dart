import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/utils/form_validators.dart';
import 'package:flutter_aigun/utils/storage/index.dart';
import 'package:get_it/get_it.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final UserCubit userCubit = GetIt.instance<UserCubit>();
  final SecureStorageService storage = GetIt.instance<SecureStorageService>();
  final UserApi _userApi = GetIt.instance<UserApi>();

  SignUpCubit() : super(const SignUpState());

  void updateEmail(String value) {
    emit(state.copyWith(email: value, emailError: null, isEmailExists: false));
  }

  void updateNickname(String value) {
    emit(state.copyWith(nickname: value));
  }

  void updatePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void updateConfirmPassword(String value) {
    emit(state.copyWith(confirmPassword: value));
  }

  void updateIsEmailCheckLoading(bool value) {
    emit(state.copyWith(isEmailCheckLoading: value));
  }

  void updateCode(String value) {
    emit(state.copyWith(code: value));
  }

  bool validateForm(void Function() navigateTo) {
    final isEmailValid = FormValidators.isEmailValid(state.email);
    final isNicknameValid = FormValidators.isNicknameValid(state.nickname);
    final isPasswordValid = FormValidators.isPasswordValid(state.password);
    final isConfirmPasswordValid = FormValidators.isConfirmPasswordValid(
      state.confirmPassword,
      state.password,
    );

    if (isEmailValid != null) {
      emit(state.copyWith(emailError: isEmailValid));
      return false;
    }

    if (isNicknameValid != null) {
      emit(state.copyWith(nicknameError: isNicknameValid));
      return false;
    }

    if (isPasswordValid != null) {
      emit(state.copyWith(passwordError: isPasswordValid));
      return false;
    }

    if (isConfirmPasswordValid != null) {
      emit(state.copyWith(confirmPasswordError: isConfirmPasswordValid));
      return false;
    }

    navigateTo();
    return true;
  }

  Future<void> signUp() async {
    try {
      emit(state.copyWith(isLoading: true));

      // await storage.saveToken(user.accessToken);
      await userCubit.getUserInfo();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      if (e is ServerException) {
        emit(state.copyWith(
          isLoading: false,
          errorCode: 500,
          message: e.message,
        ));
        return;
      }

      emit(state.copyWith(
        isLoading: false,
        errorCode: e is ApiException ? e.code : null,
        message: e is ApiException ? e.message : 'An error occurred',
      ));
    }
  }

  Future<bool> checkEmailExists() async {
    updateIsEmailCheckLoading(true);
    try {
      final emailStatus = await _userApi.checkEmailStatus(email: state.email);
      emit(state.copyWith(isEmailExists: emailStatus));
      return emailStatus;
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        message: e is ApiException ? e.message : 'An error occurred',
      ));
      return false;
    } finally {
      updateIsEmailCheckLoading(false);
    }
  }

  void reset() {
    emit(const SignUpState());
  }

  void resetError() {
    emit(state.copyWith(
      errorCode: null,
      message: null,
    ));
  }

  Future<void> sendVerificationCode({
    required String email,
  }) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _userApi.sendVerificationCode(
        email: email,
        type: 'register',
      );
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        message: e is ApiException ? e.message : 'An error occurred',
      ));
    }
  }
}

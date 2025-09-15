import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/user/user_cubit.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/enums/index.dart';
import 'package:flutter_aigun/screens/sign_in/cubit/sign_in_state.dart';
import 'package:flutter_aigun/utils/form_validators.dart';
import 'package:get_it/get_it.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserApi _userApi = GetIt.instance<UserApi>();
  final UserCubit userCubit = GetIt.instance<UserCubit>();

  SignInCubit()
      : super(const SignInState(
          email: '',
          password: '',
          emailError: null,
          passwordError: null,
        ));

  bool _validateForm() {
    final bool isEmailValid = _validateEmail();
    final bool isPasswordValid = _validatePassword();

    if (!isEmailValid || !isPasswordValid) {
      return false;
    }

    return true;
  }

  bool _validateEmail() {
    final ValidationError? emailError =
        FormValidators.isEmailValid(state.email);
    if (emailError != null) {
      emit(state.copyWith(emailError: emailError));
      return false;
    }
    return true;
  }

  bool _validatePassword() {
    final ValidationError? passwordError =
        FormValidators.isPasswordValid(state.password);
    if (passwordError != null) {
      emit(state.copyWith(passwordError: passwordError));
      return false;
    }
    return true;
  }

  void updateEmail(String value) {
    emit(state.copyWith(email: value, emailError: null, passwordError: null));
  }

  void updatePassword(String value) {
    emit(
        state.copyWith(password: value, emailError: null, passwordError: null));
  }

  Future<void> signIn() async {
    if (!_validateForm()) return;

    emit(state.copyWith(isLoading: true));
    try {
      await _userApi.signIn(
        username: state.email,
        password: state.password,
      );

      // await _storage.saveToken(user.accessToken);
      await userCubit.getUserInfo();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        message: e is ApiException ? e.message : 'An error occurred',
      ));
    }
  }

  void reset() {
    emit(const SignInState());
  }
}

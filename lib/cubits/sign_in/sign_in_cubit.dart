import 'package:flutter_bloc/flutter_bloc.dart';
import "package:flutter_aigun/cubits/sign_in/sign_in_state.dart";

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void updateEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void updateVerificationCode(String value) {
    emit(state.copyWith(verificationCode: value));
  }

  Future<void> sendVerificationCode() async {}
}

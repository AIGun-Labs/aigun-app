import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_aigun/enums/index.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? message,
    String? errorCode,
    ValidationError? emailError,
    ValidationError? passwordError,
  }) = _SignInState;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../enums/index.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String email,
    @Default('') String nickname,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default('') String code,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? message,
    int? errorCode,
    ValidationError? emailError,
    ValidationError? nicknameError,
    ValidationError? passwordError,
    ValidationError? confirmPasswordError,
    @Default(false) bool isEmailCheckLoading,
    @Default(false) bool isEmailExists,
  }) = _SignUpState;
}

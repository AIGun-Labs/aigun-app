import 'package:freezed_annotation/freezed_annotation.dart';
import '../../enums/index.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default('') String email,
    @Default('') String code,
    @Default('') String newPassword,
    @Default('') String confirmPassword,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool isError,
    String? errorMessage,
    ValidationError? emailError,
    ValidationError? codeError,
    ValidationError? newPasswordError,
    ValidationError? confirmPasswordError,
    QueryStatus? queryStatus,
    @Default(false) bool isEmailCheckLoading,
    @Default(true) bool isEmailExists,
  }) = _ForgotPasswordState;
}

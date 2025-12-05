import '../enums/index.dart';
import 'logger.dart';

class FormValidators {
  static ValidationError? isEmailValid(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationError.emailEmpty;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return ValidationError.emailInvalid;
    }
    return null;
  }

  static ValidationError? isEmailFormatValid(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationError.emailEmpty;
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!emailRegex.hasMatch(value)) {
      return ValidationError.emailInvalid;
    }
    return null;
  }

  static ValidationError? isCodeValid(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationError.codeEmpty;
    }

    if (value.length != 6) {
      return ValidationError.codeInvalidFormat;
    }

    Logger.info(value.length != 6);

    if (!RegExp(r'^[0-9]{0,6}$').hasMatch(value)) {
      return ValidationError.codeInvalidFormat;
    }

    return null;
  }

  static ValidationError? isNicknameValid(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationError.nicknameEmpty;
    }
    return null;
  }

  static ValidationError? isPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationError.passwordEmpty;
    }

    if (value.length < 8) {
      return ValidationError.passwordTooShort;
    }

    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
    bool hasDigits = value.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = value.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );

    if (!hasUpperCase || !hasLowerCase || !hasDigits || !hasSpecialCharacters) {
      return ValidationError.passwordTooSimple;
    }

    return null;
  }

  static ValidationError? isConfirmPasswordValid(
    String? value,
    String password,
  ) {
    if (value == null || value.isEmpty) {
      return ValidationError.confirmPasswordEmpty;
    }
    if (value != password) {
      return ValidationError.passwordsDoNotMatch;
    }
    return null;
  }
}

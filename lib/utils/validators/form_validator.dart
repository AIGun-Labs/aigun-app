import 'email_validator.dart';
import 'validator_result.dart';

class FormValidator {
  static ValidationResult validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  static ValidationResult validateVerificationCode(String code) {
    if (code.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_codeEmpty',
      );
    }

    if (code.length != 6) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_codeLength',
      );
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(code)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_codeFormat',
      );
    }

    return const ValidationResult(isValid: true);
  }

  static ValidationResult validateNickname(String nickname) {
    if (nickname.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_nicknameEmpty',
      );
    }

    if (nickname.length > 20) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_nicknameTooLong',
      );
    }

    // if (RegExp(r'[<>:"/\\|?*]').hasMatch(nickname)) {
    //   return const ValidationResult(
    //     isValid: false,
    //     errorMessage: 'validation_nicknameInvalidChars',
    //   );
    // }

    return const ValidationResult(isValid: true);
  }

  static ValidationResult validateInviteCode(String inviteCode) {
    if (inviteCode.isEmpty) {
      return const ValidationResult(isValid: true);
    }

    if (inviteCode.length < 4 || inviteCode.length > 10) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_inviteCodeLength',
      );
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(inviteCode)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_inviteCodeFormat',
      );
    }

    return const ValidationResult(isValid: true);
  }

  static ValidationResult validatePassword(String password) {
    if (password.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_passwordEmpty',
      );
    }

    if (password.length < 8) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_passwordTooShort',
      );
    }

    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    final hasNumbers = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChars = RegExp(
      r'[!@#$%^&*(),.?":{}|<>]',
    ).hasMatch(password);

    if (!hasUpperCase || !hasLowerCase || !hasNumbers || !hasSpecialChars) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_passwordTooSimple',
      );
    }

    return const ValidationResult(isValid: true);
  }

  static ValidationResult validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_confirmPasswordEmpty',
      );
    }

    if (password != confirmPassword) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_passwordsDoNotMatch',
      );
    }

    return const ValidationResult(isValid: true);
  }
}

import 'email_validator.dart';
import 'validator_result.dart';

/// 通用表单校验器
class FormValidator {
  /// 校验邮箱
  static ValidationResult validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  /// 校验验证码
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

  /// 校验用户昵称
  static ValidationResult validateNickname(String nickname) {
    if (nickname.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_nicknameEmpty',
      );
    }

    if (nickname.length < 2) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_nicknameTooShort',
      );
    }

    if (nickname.length > 20) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_nicknameTooLong',
      );
    }

    // 检查是否包含特殊字符
    // if (RegExp(r'[<>:"/\\|?*]').hasMatch(nickname)) {
    //   return const ValidationResult(
    //     isValid: false,
    //     errorMessage: 'validation_nicknameInvalidChars',
    //   );
    // }

    return const ValidationResult(isValid: true);
  }

  /// 校验邀请码
  static ValidationResult validateInviteCode(String inviteCode) {
    if (inviteCode.isEmpty) {
      // 邀请码可以为空
      return const ValidationResult(isValid: true);
    }

    if (inviteCode.length < 4 || inviteCode.length > 10) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_inviteCodeLength',
      );
    }

    // 检查是否只包含字母和数字
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(inviteCode)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_inviteCodeFormat',
      );
    }

    return const ValidationResult(isValid: true);
  }

  /// 校验密码
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

    // 检查是否包含大小写字母、数字和特殊字符
    final hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    final hasNumbers = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChars =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    if (!hasUpperCase || !hasLowerCase || !hasNumbers || !hasSpecialChars) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_passwordTooSimple',
      );
    }

    return const ValidationResult(isValid: true);
  }

  /// 校验确认密码
  static ValidationResult validateConfirmPassword(
      String password, String confirmPassword) {
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

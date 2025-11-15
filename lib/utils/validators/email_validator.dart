import 'validator_result.dart';

/// 邮箱校验器
class EmailValidator {
  /// 邮箱格式正则表达式
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// 校验邮箱格式
  /// [email] 邮箱地址
  /// 返回校验结果
  static ValidationResult validate(String email) {
    if (email.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_emailEmpty',
      );
    }

    if (!_emailRegex.hasMatch(email)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_emailInvalid',
      );
    }

    return const ValidationResult(isValid: true);
  }

  /// 校验邮箱是否为空
  static bool isEmpty(String email) => email.trim().isEmpty;

  /// 校验邮箱格式是否正确
  static bool hasValidFormat(String email) => _emailRegex.hasMatch(email);

  /// 获取邮箱域名
  static String? getDomain(String email) {
    if (!hasValidFormat(email)) return null;
    final parts = email.split('@');
    return parts.length == 2 ? parts[1] : null;
  }

  /// 获取邮箱用户名部分
  static String? getUsername(String email) {
    if (!hasValidFormat(email)) return null;
    final parts = email.split('@');
    return parts.length == 2 ? parts[0] : null;
  }
}

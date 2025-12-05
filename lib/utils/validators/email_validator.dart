import 'validator_result.dart';

class EmailValidator {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

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

  static bool isEmpty(String email) => email.trim().isEmpty;

  static bool hasValidFormat(String email) => _emailRegex.hasMatch(email);

  static String? getDomain(String email) {
    if (!hasValidFormat(email)) return null;
    final parts = email.split('@');
    return parts.length == 2 ? parts[1] : null;
  }

  static String? getUsername(String email) {
    if (!hasValidFormat(email)) return null;
    final parts = email.split('@');
    return parts.length == 2 ? parts[0] : null;
  }
}

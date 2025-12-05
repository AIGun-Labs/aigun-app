import 'index.dart';

class RiskValidator {
  static ValidationResult validateSmsCode(String code) {
    if (code.isEmpty) {
      return const ValidationResult(
          isValid: false, errorMessage: 'validation_codeEmpty');
    }

    if (code.length != 6) {
      return const ValidationResult(
          isValid: false, errorMessage: 'validation_codeLength');
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(code)) {
      return const ValidationResult(
          isValid: false, errorMessage: 'validation_codeFormat');
    }

    return const ValidationResult(isValid: true);
  }
}

import 'package:flutter_aigun/utils/validators/index.dart';

class RiskValidator {
  static ValidationResult validateSmsCode(String code) {
    if (code.isEmpty) {
      return ValidationResult(
          isValid: false, errorMessage: 'validation_codeEmpty');
    }

    if (code.length != 6) {
      return ValidationResult(
          isValid: false, errorMessage: 'validation_codeLength');
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(code)) {
      return ValidationResult(
          isValid: false, errorMessage: 'validation_codeFormat');
    }

    return ValidationResult(isValid: true);
  }
}

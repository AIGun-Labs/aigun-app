import 'package:flutter_aigun/utils/validators/validator_result.dart';

class WalletValidator {
  static ValidationResult validatePaymentPin(String pin) {
    if (pin.isEmpty) {
      return ValidationResult(
          isValid: false, errorMessage: "Payment Pin is required");
    }

    if (pin.length != 6) {
      return ValidationResult(
          isValid: false, errorMessage: "Payment Pin must be 6 digits");
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(pin)) {
      return ValidationResult(
          isValid: false, errorMessage: "Payment Pin must be a number");
    }

    return ValidationResult(isValid: true);
  }
}

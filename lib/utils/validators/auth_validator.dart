import 'index.dart';

class AuthValidator {
  static ValidationResult validatePaymentPin(String paymentPin) {
    if (paymentPin.isEmpty) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_paymentPinEmpty',
      );
    }

    if (paymentPin.length != 6) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_paymentPinLength',
      );
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(paymentPin)) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_paymentPinFormat',
      );
    }

    // Check for consecutive increasing or decreasing numbers
    bool isConsecutiveIncreasing = true;
    bool isConsecutiveDecreasing = true;
    for (int i = 0; i < paymentPin.length - 1; i++) {
      if (int.parse(paymentPin[i + 1]) != int.parse(paymentPin[i]) + 1) {
        isConsecutiveIncreasing = false;
      }
      if (int.parse(paymentPin[i + 1]) != int.parse(paymentPin[i]) - 1) {
        isConsecutiveDecreasing = false;
      }
    }

    if (isConsecutiveIncreasing || isConsecutiveDecreasing) {
      return const ValidationResult(
        isValid: false,
        errorMessage: 'validation_paymentPinConsecutive',
      );
    }

    return const ValidationResult(isValid: true);
  }
}

import "../../l10n/l10n.dart";

class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult({required this.isValid, this.errorMessage});

  String? getLocalizedErrorMessage(S s) {
    if (errorMessage == null) return null;

    switch (errorMessage) {
      case 'validation_emailEmpty':
        return s.validation_emailEmpty;
      case 'validation_emailInvalid':
        return s.validation_emailInvalid;
      default:
        return errorMessage;
    }
  }
}

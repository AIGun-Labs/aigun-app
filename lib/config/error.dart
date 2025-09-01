import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';

class ErrorConfig {
  static String getErrorMessage(BuildContext context, String? error) {
    String errorMessage = '';

    switch (error) {
      case 'Network error':
        errorMessage = S.of(context).errors_networkError;
      case 'timeout':
        errorMessage = S.of(context).errors_timeout;
      case 'Server error':
        errorMessage = S.of(context).errors_serverError;
      default:
        errorMessage = error ?? S.of(context).errors_unknownError;
    }

    return errorMessage;
  }
}

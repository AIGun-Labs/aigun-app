import 'package:flutter/services.dart';

class InputFormatters {
  static List<TextInputFormatter> numberInputFormatters({
    int maxDecimalPlaces = 8,
  }) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),

      TextInputFormatter.withFunction((oldValue, newValue) {
        return _formatNumberInput(newValue, oldValue, maxDecimalPlaces);
      }),
    ];
  }

  static List<TextInputFormatter> tradeAmountInputFormatters({
    int maxDecimalPlaces = 8,
  }) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      TextInputFormatter.withFunction((oldValue, newValue) {
        return _formatTradeAmountInput(newValue, oldValue, maxDecimalPlaces);
      }),
    ];
  }

  static List<TextInputFormatter> nicknameInputFormatters() {
    return [LengthLimitingTextInputFormatter(20)];
  }

  static List<TextInputFormatter> integerInputFormatters() {
    return [FilteringTextInputFormatter.digitsOnly];
  }

  static List<TextInputFormatter> percentageInputFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      TextInputFormatter.withFunction((oldValue, newValue) {
        if (newValue.text.isEmpty) {
          return newValue;
        }

        final int? value = int.tryParse(newValue.text);

        if (value == null) {
          return oldValue;
        }

        if (value > 100) {
          return oldValue;
        }

        if (newValue.text.length > 1 && newValue.text.startsWith('0')) {
          return oldValue;
        }
        return newValue;
      }),
    ];
  }

  static List<TextInputFormatter> amountInputFormatters({
    int maxDecimalPlaces = 2,
    bool allowNegative = false,
  }) {
    final pattern = allowNegative ? r'^-?\d*\.?\d*$' : r'^\d*\.?\d*$';

    return [
      FilteringTextInputFormatter.allow(
        RegExp(allowNegative ? r'[0-9.-]' : r'[0-9.]'),
      ),
      TextInputFormatter.withFunction((oldValue, newValue) {
        if (newValue.text.isEmpty) {
          return newValue;
        }

        if (!RegExp(pattern).hasMatch(newValue.text)) {
          return oldValue;
        }

        final text = newValue.text;
        final parts = text.replaceFirst('-', '').split('.');

        if (parts.length > 2) {
          return oldValue;
        }

        if (parts.length == 2 && parts[1].length > maxDecimalPlaces) {
          final integerPart = text.contains('-') ? '-${parts[0]}' : parts[0];
          final truncated =
              '$integerPart.${parts[1].substring(0, maxDecimalPlaces)}';
          return TextEditingValue(
            text: truncated,
            selection: TextSelection.collapsed(offset: truncated.length),
          );
        }

        return newValue;
      }),
    ];
  }

  static List<TextInputFormatter> passwordInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(
        RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{}|;:,.<>?]'),
      ),
    ];
  }

  static List<TextInputFormatter> usernameInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_-]')),

      LengthLimitingTextInputFormatter(50),
    ];
  }

  static List<TextInputFormatter> emailInputFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
      LengthLimitingTextInputFormatter(254),
    ];
  }

  static TextEditingValue _formatNumberInput(
    TextEditingValue newValue,
    TextEditingValue oldValue,
    int maxDecimalPlaces,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final text = newValue.text;

    if (text == '.') {
      return const TextEditingValue(
        text: '0.',
        selection: TextSelection.collapsed(offset: 2),
      );
    }

    final parts = text.split('.');
    if (parts.length > 2) {
      return oldValue;
    }

    if (parts.length == 2 && parts[1].length > maxDecimalPlaces) {
      final truncated =
          '${parts[0]}.${parts[1].substring(0, maxDecimalPlaces)}';
      return TextEditingValue(
        text: truncated,
        selection: TextSelection.collapsed(offset: truncated.length),
      );
    }

    if (!RegExp(r'^\d*\.?\d*$').hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }

  static TextEditingValue _formatTradeAmountInput(
    TextEditingValue newValue,
    TextEditingValue oldValue,
    int maxDecimalPlaces,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final double? value = double.tryParse(newValue.text);

    if (value == null) {
      return oldValue;
    }

    if (value < 0) {
      return oldValue;
    }

    if ('.'.allMatches(newValue.text).length > 1) {
      return oldValue;
    }

    final parts = newValue.text.split('.');

    if (parts.length == 2 && parts[1].length > maxDecimalPlaces) {
      final truncated =
          "${parts[0]}.${parts[1].substring(0, maxDecimalPlaces)}";

      return TextEditingValue(
        text: truncated,
        selection: TextSelection.collapsed(offset: truncated.length),
      );
    }

    if (parts.length == 2 &&
        parts[1].length == maxDecimalPlaces &&
        parts[1].endsWith('0')) {
      return oldValue;
    }

    if (newValue.text.startsWith('0') &&
        !newValue.text.startsWith("0.") &&
        newValue.text.length > 1 &&
        value != 0) {
      return oldValue;
    }

    if (newValue.text == '00') {
      return oldValue;
    }

    return newValue;
  }
}

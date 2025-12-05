class NumericFormatter {
  static String formatToWei(String numberString) {
    try {
      final number = double.parse(numberString);

      if (number < 1000) {
        return numberString;
      }

      return _formatWithCommas(numberString);
    } catch (e) {
      return numberString;
    }
  }

  static String formatPercent(
    double value, {
    bool keepDecimal = true,
    int decimalPlaces = 2,
  }) {
    if (!keepDecimal) {
      return '${value.truncate()}%';
    }

    if (value % 1 == 0) {
      return '${value.toInt()}%';
    } else {
      String formatted = value.toStringAsFixed(decimalPlaces);

      formatted = formatted.replaceAll(RegExp(r'\.?0+$'), '');
      return '$formatted%';
    }
  }

  static String formatWithSign(double value, {suffix = ''}) {
    if (value.toString().startsWith("-")) {
      return "$value$suffix";
    }
    if (value.toString().startsWith("+")) {
      return "$value$suffix";
    }

    if (value > 0) {
      return '+$value$suffix';
    } else if (value < 0) {
      return '$value$suffix';
    } else {
      return "$value$suffix";
    }
  }

  static String _formatWithCommas(String numberString) {
    final parts = numberString.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

    final buffer = StringBuffer();
    final length = integerPart.length;

    for (int i = 0; i < length; i++) {
      if (i > 0 && (length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(integerPart[i]);
    }

    return buffer.toString() + decimalPart;
  }

  /// 123345 => 123345

  static String formatValuesDecimalDigits(
    num amount,
    String symbol,
    int decimalDigits,
  ) {
    if (amount % 1 == 0) {
      return amount.toStringAsFixed(0);
    } else {
      return amount.toStringAsFixed(decimalDigits);
    }
  }
}

import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

String formatLargeNumberStrict(String? number, {int decimals = 2}) {
  if (number == null || number.isEmpty) return number ?? "";
  final newNumber = Decimal.tryParse(number)?.toDouble();
  if (newNumber == null) return number;
  String prefix = newNumber < 0 ? '-' : '';
  num absNumber = newNumber.abs();

  const int YI = 100000000;
  const int QIAN_WAN = 10000000;
  const int BAI_WAN = 1000000;
  const int WAN = 10000;
  String result;
  // Note: Check order must be from largest to smallest
  if (absNumber >= YI) {
    double value = absNumber / YI;
    result = '${_removeTrailingZeros(value.toStringAsFixed(decimals))}B';
  } else if (absNumber >= QIAN_WAN) {
    double value = absNumber / QIAN_WAN;
    result = '${_removeTrailingZeros(value.toStringAsFixed(decimals))}TenM';
  } else if (absNumber >= BAI_WAN) {
    double value = absNumber / BAI_WAN;
    result = '${_removeTrailingZeros(value.toStringAsFixed(decimals))}M';
  } else if (absNumber >= WAN) {
    double value = absNumber / WAN;
    result = '${_removeTrailingZeros(value.toStringAsFixed(decimals))}K';
  } else {
    result = _removeTrailingZeros(absNumber.toString());
  }
  return prefix + result;
}

/// Keep two decimal places for floating point numbers
/// Support String, double, int and other types as input
/// [decimals] Specify the number of decimal places to keep, default is 2
/// [removeTrailingZeros] Whether to remove trailing zeros, default is true
String formatDecimal(dynamic value,
    {int decimals = 2, bool removeTrailingZeros = true}) {
  if (value == null) return '0.00';

  // Convert to double
  double? numValue;
  if (value is String) {
    numValue = double.tryParse(value);
  } else if (value is num) {
    numValue = value.toDouble();
  }

  if (numValue == null) return '0.00';

  // Format to specified decimal places
  String result = numValue.toStringAsFixed(decimals);

  // Whether to remove trailing zeros
  if (removeTrailingZeros) {
    result = _removeTrailingZeros(result);
  }

  return result;
}

// _removeTrailingZeros function is the same as option one
String _removeTrailingZeros(String n) {
  if (!n.contains('.')) return n;
  String trimmed = n.replaceAll(RegExp(r'0+$'), '');
  if (trimmed.endsWith('.')) {
    return trimmed.substring(0, trimmed.length - 1);
  }
  return trimmed;
}

String convertMillisecondToSecond(double millisecond) {
  return (millisecond / 1000).toStringAsFixed(2);
}

/// Format price with abbreviation for multiple zeros
///
/// [price] Price value.
/// [maxDecimals] Maximum number of decimal places, default is 4.
///
/// Returns the formatted price string.
///
/// Examples:
///   formatPrice(0.000123) => "0.0001"
///   formatPrice(0.0000176) => "0.0₄176" (4 zeros)
///   formatPrice(0.000000000123) => "0.0₉123" (9 zeros)
///   formatPrice(1.23) => "1.23"
///   formatPrice(0.1234567890) => "0.1234"
String formatPrice(dynamic price, {int maxDecimals = 4}) {
  // Convert input value to number
  double? numPrice;
  if (price is String) {
    numPrice = double.tryParse(price);
  } else if (price is num) {
    numPrice = price.toDouble();
  }

  // Handle invalid values
  if (numPrice == null ||
      numPrice.isNaN ||
      numPrice == 0 ||
      !numPrice.isFinite) {
    // If input is string but parsing failed, return '0'
    if (price is String) {
      final parsed = double.tryParse(price);
      return parsed == null ? '0' : '0';
    }
    // Other cases (null, NaN, infinity, etc.)
    return '0';
  }
  if (numPrice < 0) {
    return '0';
  }

  // Handle large numbers
  if (numPrice.abs() >= 100000) {
    final result = numPrice.toStringAsFixed(0);
    return result;
  } else if (numPrice.abs() >= 10000) {
    final result = numPrice.toStringAsFixed(1);
    return result.replaceAll(RegExp(r'\.0$'), '');
  } else if (numPrice.abs() >= 1000) {
    final result = numPrice.toStringAsFixed(2);
    return result
        .replaceAll(RegExp(r'\.0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  } else if (numPrice.abs() >= 1) {
    final result = numPrice.toStringAsFixed(maxDecimals);
    return result
        .replaceAll(RegExp(r'\.0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }

  // For numbers less than 1, check if zeros need to be abbreviated
  // Use toStringAsFixed to avoid scientific notation issues
  final priceStr = numPrice.toStringAsFixed(20);
  final parts = priceStr.split('.');
  final decimalPart = parts.length > 1 ? parts[1] : '';

  // No decimal point
  if (decimalPart.isEmpty) {
    return numPrice.toString();
  }

  // Find the position of the first non-zero digit
  final match = RegExp(r'^(0+)([1-9]\d*)$').firstMatch(decimalPart);
  if (match == null) {
    return _formatLargeNumber(numPrice, maxDecimals);
  }

  final zeroCount = match.group(1)!.length;
  final tail = match.group(2)!;

  // If the number of consecutive zeros is less than 4, do not abbreviate
  if (zeroCount < 4) {
    return double.parse(numPrice.toStringAsFixed(maxDecimals)).toString();
  }

  // Take the first maxDecimals significant digits
  final trimmedSignificant =
      tail.substring(0, maxDecimals > tail.length ? tail.length : maxDecimals);
  // Remove trailing zeros
  final cleanSignificant = trimmedSignificant.replaceAll(RegExp(r'0+$'), '');

  // Generate subscript digits
  const subscriptDigits = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'];
  final subscriptZeroCount = zeroCount
      .toString()
      .split('')
      .map((digit) => subscriptDigits[int.parse(digit)])
      .join('');

  final result = '0.0$subscriptZeroCount$cleanSignificant';

  return result;
}

/// Helper function: Format large numbers
String _formatLargeNumber(double number, int decimals) {
  // For numbers less than 1, return formatted result directly
  if (number.abs() < 1) {
    return number.toStringAsFixed(decimals);
  }

  // For integers, use default string representation
  if (number == number.toInt().toDouble()) {
    return number.toInt().toString();
  }

  // Simple formatting implementation
  final formatter = number.toStringAsFixed(decimals);
  // Remove trailing zeros
  final cleanFormatter = formatter.replaceAll(RegExp(r'0+$'), '');
  return cleanFormatter.replaceAll(RegExp(r'\.$'), '');
}

/// Format price with support for billion, ten million, million, thousand
String formatPriceAdvanced(num price,
    {int decimals = 2, String currencySymbol = ''}) {
  if (price < 10000) {
    return formatPrice(price);
  }

  if (price >= 100000000) {
    double num = price / 100000000;
    // Floor to avoid rounding up
    int factor = 1;
    for (int i = 0; i < decimals; i++) {
      factor *= 10;
    }
    num = (num * factor).floor() / factor;
    return '$currencySymbol${num.toStringAsFixed(decimals)}B'; // B for billion
  } else if (price >= 10000000) {
    // Support for ten million level
    double num = price / 10000000;
    // Floor to avoid rounding up
    int factor = 1;
    for (int i = 0; i < decimals; i++) {
      factor *= 10;
    }
    num = (num * factor).floor() / factor;
    return '$currencySymbol${num.toStringAsFixed(decimals)}千W'; // Ten million
  } else if (price >= 1000000) {
    // Support for million level
    double num = price / 1000000;
    // Floor to avoid rounding up
    int factor = 1;
    for (int i = 0; i < decimals; i++) {
      factor *= 10;
    }
    num = (num * factor).floor() / factor;
    return '$currencySymbol${num.toStringAsFixed(decimals)}M'; // M for million
  } else if (price >= 10000) {
    double num = price / 10000;
    // Floor to avoid rounding up
    int factor = 1;
    for (int i = 0; i < decimals; i++) {
      factor *= 10;
    }
    num = (num * factor).floor() / factor;
    return '$currencySymbol${num.toStringAsFixed(decimals)}W'; // W for ten thousand
  } else {
    // For numbers less than 10,000, use NumberFormat to add thousand separators
    final formatter = NumberFormat('#,##0.##');
    return '$currencySymbol${formatter.format(price)}';
  }
}

/// Formats a number into a compact English representation (K, M, B).
///
/// [price] The number to format.
/// [decimals] The number of decimal places to keep, defaults to 2.
/// [currencySymbol] The currency symbol to prepend, defaults to '$'.
String formatPriceEnglish(num price,
    {int decimals = 2, String currencySymbol = '\$'}) {
  if (price <= 1000) {
    return formatPrice(price);
  }

  if (price >= 1000000000) {
    // Billion
    double num = price / 1000000000;
    String result = num.toStringAsFixed(decimals)
        .replaceAll(RegExp(r'\.0+$'), '')
        .replaceAll(RegExp(r'\.00$'), '');
    return '$currencySymbol${result}B';
  } else if (price >= 1000000) {
    // Million
    double num = price / 1000000;
    String result = num.toStringAsFixed(decimals)
        .replaceAll(RegExp(r'\.0+$'), '')
        .replaceAll(RegExp(r'\.00$'), '');
    return '$currencySymbol${result}M';
  } else if (price >= 1000) {
    // Thousand
    double num = price / 1000;
    String result = num.toStringAsFixed(decimals)
        .replaceAll(RegExp(r'\.0+$'), '')
        .replaceAll(RegExp(r'\.00$'), '');
    return '$currencySymbol${result}K';
  } else {
    // Less than a thousand
    return '$currencySymbol${price.toString()}';
  }
}

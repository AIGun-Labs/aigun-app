import 'dart:math';

import 'package:decimal/decimal.dart';

class NumericUtils {
  static bool isInteger(int value) {
    return value.toInt() == value.toDouble().toInt().toDouble();
  }

  static bool isWholeNumber(dynamic value) {
    if (value == null) return false;

    try {
      if (value is String) {
        final numValue = num.tryParse(value);
        if (numValue == null) return false;
        return numValue == numValue.toInt();
      } else if (value is int) {
        return true;
      } else if (value is double) {
        return value == value.toInt();
      } else if (value is Decimal) {
        return value == Decimal.fromInt(value.toBigInt().toInt());
      } else if (value is num) {
        return value == value.toInt();
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static double divideStringByNumber(String numeratorString, num divisor) {
    if (numeratorString.isEmpty) {
      return 0;
    }
    final numerator = Decimal.parse(numeratorString);

    final result = numerator.toDouble() / divisor;
    return result;
  }

  static String formatIncreaseRateDisplay(String increaseRate) {
    final rate = Decimal.tryParse(increaseRate)?.toDouble() ?? 0.0;

    if (rate <= 0) {
      return "<1x";
    } else if (rate < 1) {
      final percentage = (rate * 100).round();
      return "$percentage%";
    } else {
      if (rate % 1 == 0) {
        return "${rate.toInt()}x";
      } else {
        final formatted = rate.toStringAsFixed(1);

        return "${formatted.replaceAll(RegExp(r'\.0$'), '')}x";
      }
    }
  }

  static ({String value, String suffix}) formatIncreaseRateDisplayWithSuffix(
    String increaseRate,
  ) {
    final rate = Decimal.tryParse(increaseRate)?.toDouble() ?? 0.0;

    if (rate <= 0) {
      return (value: "<1", suffix: "x");
    } else if (rate < 1) {
      final percentage = (rate * 100).round();
      return (value: "$percentage", suffix: "%");
    } else {
      final valueStr = rate % 1 == 0
          ? "${rate.toInt()}"
          : rate.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
      return (value: valueStr, suffix: "x");
    }
  }

  static BigInt multiplyByDecimalPower(String value, int decimals) {
    final amount = Decimal.tryParse(value) ?? Decimal.zero;

    if (amount == Decimal.zero) return BigInt.zero;

    final factor = Decimal.parse(pow(10, decimals).toString());

    final result = amount * factor;

    return result.toBigInt();
  }

  static int getRandomInt(int min, int max) {
    final random = Random();

    if (min >= max) {
      throw ArgumentError('min must be less than max');
    }

    return min + random.nextInt(max - min + 1);
  }

  static String convertFromAtomicUnits(String atomicAmount, int decimals) {
    if (atomicAmount.isEmpty) {
      return "0";
    }
    final amount = Decimal.parse(atomicAmount);
    final factor = Decimal.parse(pow(10, decimals).toString());

    final result = amount / factor;
    final decimalResult = result.toDecimal();
    return decimalResult.toStringAsFixed(decimals);
  }

  static int multiply(dynamic value, int multiplier) {
    if (value is String) {
      return int.parse(value) * multiplier;
    }
    if (value is num) {
      return value.toInt() * multiplier;
    }
    if (value is int) {
      return value * multiplier;
    }
    throw ArgumentError('value must be a number');
  }

  static num multiplyTwoNumbers(dynamic a, dynamic b) {
    num numA;
    num numB;

    if (a is String) {
      numA = num.tryParse(a) ?? 0;
    } else if (a is num) {
      numA = a;
    } else {
      throw ArgumentError(' a ');
    }

    if (b is String) {
      numB = num.tryParse(b) ?? 0;
    } else if (b is num) {
      numB = b;
    } else {
      throw ArgumentError(' b ');
    }

    return numA * numB;
  }

  static int compareNumbers(dynamic a, dynamic b) {
    num numA;
    num numB;

    if (a is String) {
      numA = num.tryParse(a) ?? 0;
    } else if (a is num) {
      numA = a;
    } else {
      throw ArgumentError(' a ');
    }

    if (b is String) {
      numB = num.tryParse(b) ?? 0;
    } else if (b is num) {
      numB = b;
    } else {
      throw ArgumentError(' b ');
    }

    final decimalA = Decimal.tryParse(numA.toString()) ?? Decimal.zero;
    final decimalB = Decimal.tryParse(numB.toString()) ?? Decimal.zero;

    return decimalA.compareTo(decimalB);
  }

  static bool greaterThan(dynamic a, dynamic b) {
    return compareNumbers(a, b) > 0;
  }

  static bool lessThan(dynamic a, dynamic b) {
    return compareNumbers(a, b) < 0;
  }

  static bool equalTo(dynamic a, dynamic b) {
    return compareNumbers(a, b) == 0;
  }

  static bool greaterThanOrEqual(dynamic a, dynamic b) {
    return compareNumbers(a, b) >= 0;
  }

  static bool lessThanOrEqual(dynamic a, dynamic b) {
    return compareNumbers(a, b) <= 0;
  }

  static num subtractNumbers(dynamic a, dynamic b) {
    num numA;
    num numB;

    if (a is String) {
      numA = num.tryParse(a) ?? 0;
    } else if (a is num) {
      numA = a;
    } else {
      throw ArgumentError(' a ');
    }

    if (b is String) {
      numB = num.tryParse(b) ?? 0;
    } else if (b is num) {
      numB = b;
    } else {
      throw ArgumentError(' b ');
    }

    return numA - numB;
  }

  static bool isGreaterThanZero(dynamic value) {
    if (value is String) {
      final numValue = num.tryParse(value) ?? 0;
      return numValue > 0;
    } else if (value is num) {
      return value > 0;
    } else {
      throw ArgumentError('');
    }
  }

  ///      truncateDecimals(1.23456789, 4) = "1.2345"
  static String truncateDecimals(double value, int decimalPlaces) {
    if (decimalPlaces < 0) {
      throw ArgumentError('decimalPlaces must be non-negative');
    }

    final decimal = Decimal.parse(value.toString());
    final multiplier = Decimal.parse(pow(10, decimalPlaces).toString());

    final truncated = (decimal * multiplier).toBigInt();
    final result = Decimal.fromBigInt(truncated) / multiplier;

    return result.toDecimal().toStringAsFixed(decimalPlaces);
  }
}

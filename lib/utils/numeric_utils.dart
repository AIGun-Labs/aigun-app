import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter_aigun/utils/format/number.dart';

class NumericUtils {
  static double divideStringByNumber(String numeratorString, num divisor) {
    if (numeratorString.isEmpty) {
      return 0;
    }
    final numerator = Decimal.parse(numeratorString);

    final result = numerator.toDouble() / divisor;
    return result;
  }

  /// 将数值乘以10的指定小数位数次方
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

  static String convertToAtomicUnits(String amountString, int decimals) {
    // final Decimal decimalValue = Decimal.tryParse(amountString) ?? Decimal.zero;
    // final Decimal integerValue = Decimal.fromInt(decimals);
    // final Decimal result = decimalValue * integerValue;
    // return formatDecimal(result.toString());
    final decimal =
        Decimal.tryParse(pow(10, decimals).toString()) ?? Decimal.zero;

    final Decimal amount = Decimal.tryParse(amountString) ?? Decimal.zero;
    final Decimal result = (amount / decimal).toDecimal();
    return formatDecimal(result.toString());
  }

  /// 从金额中减去 10 的 decimal 次方
  /// 例如：subtractDecimalPower("1000000000000000000", 18) = "1000000000000000000" - 10^18
  static String subtractDecimalPower(String amountString, int decimals) {
    final Decimal amount = Decimal.tryParse(amountString) ?? Decimal.zero;
    final Decimal powerOfTen = Decimal.parse(pow(10, decimals).toString());

    final Decimal result = amount - powerOfTen;
    return result.toString();
  }

  /// 将原子单位转换为人类可读格式
  /// 例如：convertFromAtomicUnits("1000000000000000000", 18) = "1.0"
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
}

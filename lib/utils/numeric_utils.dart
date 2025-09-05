import 'dart:math';

import 'package:decimal/decimal.dart';

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
}

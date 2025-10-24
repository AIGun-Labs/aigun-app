import 'dart:math';

import 'package:decimal/decimal.dart';

class NumericUtils {
  static bool isInteger(int value) {
    return value.toInt() == value.toDouble().toInt().toDouble();
  }

  /// 判断数字是否为整数（无小数部分）
  /// 支持 String、int、double、Decimal 等类型
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

  static String formatIncreaseRateDisplay(
    String increaseRate,
  ) {
    final rate = Decimal.tryParse(increaseRate)?.toDouble() ?? 0.0;

    if (rate <= 0) {
      // 如果是跌的（<=0），显示为 "<1x"
      return "<1x";
    } else if (rate < 1) {
      // 如果是大于 0，小于 100%，那么显示为对应的涨幅，不要保留小数，例如 56%，不显示 x
      final percentage = (rate * 100).round();
      return "$percentage%";
    } else {
      // 如果大于 1，那么就最多保留一位小数显示+x，例如：1.2x，12x，123x
      if (rate % 1 == 0) {
        // 如果是整数，直接显示为整倍数
        return "${rate.toInt()}x";
      } else {
        // 如果有小数，最多保留一位小数
        final formatted = rate.toStringAsFixed(1);
        // 移除末尾的 .0
        return "${formatted.replaceAll(RegExp(r'\.0$'), '')}x";
      }
    }
  }

  /// 格式化增长率并分离数值和后缀，用于自定义后缀样式
  /// 返回 ({String value, String suffix})
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

  static num multiplyTwoNumbers(dynamic a, dynamic b) {
    num numA;
    num numB;

    if (a is String) {
      numA = num.tryParse(a) ?? 0;
    } else if (a is num) {
      numA = a;
    } else {
      throw ArgumentError('参数 a 必须是数字或数字字符串');
    }

    if (b is String) {
      numB = num.tryParse(b) ?? 0;
    } else if (b is num) {
      numB = b;
    } else {
      throw ArgumentError('参数 b 必须是数字或数字字符串');
    }

    return numA * numB;
  }

  /// 比较两个数字的大小（兼容字符串、整数、浮点数）
  /// 返回值：
  ///   -1: a < b
  ///    0: a == b
  ///    1: a > b
  static int compareNumbers(dynamic a, dynamic b) {
    num numA;
    num numB;

    // 转换第一个参数
    if (a is String) {
      numA = num.tryParse(a) ?? 0;
    } else if (a is num) {
      numA = a;
    } else {
      throw ArgumentError('参数 a 必须是数字或数字字符串');
    }

    // 转换第二个参数
    if (b is String) {
      numB = num.tryParse(b) ?? 0;
    } else if (b is num) {
      numB = b;
    } else {
      throw ArgumentError('参数 b 必须是数字或数字字符串');
    }

    // 使用 Decimal 进行精确比较，避免浮点数精度问题
    final decimalA = Decimal.tryParse(numA.toString()) ?? Decimal.zero;
    final decimalB = Decimal.tryParse(numB.toString()) ?? Decimal.zero;

    return decimalA.compareTo(decimalB);
  }

  /// 判断 a 是否大于 b
  static bool greaterThan(dynamic a, dynamic b) {
    return compareNumbers(a, b) > 0;
  }

  /// 判断 a 是否小于 b
  static bool lessThan(dynamic a, dynamic b) {
    return compareNumbers(a, b) < 0;
  }

  /// 判断 a 是否等于 b
  static bool equalTo(dynamic a, dynamic b) {
    return compareNumbers(a, b) == 0;
  }

  /// 判断 a 是否大于等于 b
  static bool greaterThanOrEqual(dynamic a, dynamic b) {
    return compareNumbers(a, b) >= 0;
  }

  /// 判断 a 是否小于等于 b
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
      throw ArgumentError('参数 a 必须是数字或数字字符串');
    }

    if (b is String) {
      numB = num.tryParse(b) ?? 0;
    } else if (b is num) {
      numB = b;
    } else {
      throw ArgumentError('参数 b 必须是数字或数字字符串');
    }

    return numA - numB;
  }

  /// 判断数字是否大于零（兼容字符串、整数、浮点数）
  static bool isGreaterThanZero(dynamic value) {
    if (value is String) {
      final numValue = num.tryParse(value) ?? 0;
      return numValue > 0;
    } else if (value is num) {
      return value > 0;
    } else {
      throw ArgumentError('参数必须是数字或数字字符串');
    }
  }
}

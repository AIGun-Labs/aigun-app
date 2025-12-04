import 'dart:math';

import 'package:decimal/decimal.dart';

/// 基于 Decimal 的高精度计算工具库
///
/// 功能：
/// - 加法、减法、乘法、除法（支持多数运算）
/// - 比较运算（大于、小于、等于、大于等于、小于等于）
/// - 类型转换（String, int, double, BigInt, Decimal）
/// - 精度控制（四舍五入、截断、小数位数）
/// - 链式调用（fluent API）
class Calculator {
  /// ============================================
  /// 1. 基础算术运算（多数支持）
  /// ============================================

  /// 多数相加
  ///
  /// 例子：
  /// ```dart
  /// Calculator.add(['1.1', 2.2, '3.3']); // 返回 "6.6"
  /// Calculator.add([1, 2, 3, 4, 5]); // 返回 "15"
  /// Calculator.add(['0.1', '0.2', '0.3']); // 返回 "0.6"（避免浮点数精度问题）
  /// ```
  static String add(List<dynamic> values, {int? precision}) {
    Decimal result = Decimal.zero;

    for (final value in values) {
      result += _toDecimal(value);
    }

    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  /// 多数相减（从第一个数依次减去后续数字）
  ///
  /// 例子：
  /// ```dart
  /// Calculator.subtract(['10', 3, 2.5]); // 返回 "4.5" (10 - 3 - 2.5)
  /// Calculator.subtract([100, 20, 30]); // 返回 "50"
  /// ```
  static String subtract(List<dynamic> values, {int? precision}) {
    if (values.isEmpty) return '0';

    Decimal result = _toDecimal(values[0]);

    for (int i = 1; i < values.length; i++) {
      result -= _toDecimal(values[i]);
    }

    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  /// 多数相乘
  ///
  /// 例子：
  /// ```dart
  /// Calculator.multiply(['2', 3, 1.5]); // 返回 "9" (2 * 3 * 1.5)
  /// Calculator.multiply([0.1, 0.2, 10]); // 返回 "0.2"（避免浮点数精度问题）
  /// Calculator.multiply(['1.5', '2.5'], precision: 2); // 返回 "3.75"
  /// ```
  static String multiply(List<dynamic> values, {int? precision}) {
    if (values.isEmpty) return '0';

    Decimal result = _toDecimal(values[0]);

    for (int i = 1; i < values.length; i++) {
      result *= _toDecimal(values[i]);
    }

    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  /// 多数相除（从第一个数依次除以后续数字）
  ///
  /// 例子：
  /// ```dart
  /// Calculator.divide(['100', 2, 5]); // 返回 "10" (100 / 2 / 5)
  /// Calculator.divide([10, 3], precision: 4); // 返回 "3.3333"
  /// Calculator.divide([1, 0]); // 抛出异常：除数不能为零
  /// ```
  static String divide(List<dynamic> values, {int? precision}) {
    if (values.isEmpty) return '0';

    Decimal result = _toDecimal(values[0]);

    for (int i = 1; i < values.length; i++) {
      final divisor = _toDecimal(values[i]);
      if (divisor == Decimal.zero) {
        throw ArgumentError('除数不能为零');
      }
      result = (result / divisor).toDecimal();
    }

    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  /// ============================================
  /// 2. 两数运算（简化版）
  /// ============================================

  /// 两数相加
  static String addTwo(dynamic a, dynamic b, {int? precision}) {
    return add([a, b], precision: precision);
  }

  /// 两数相减
  static String subtractTwo(dynamic a, dynamic b, {int? precision}) {
    return subtract([a, b], precision: precision);
  }

  /// 两数相乘
  static String multiplyTwo(dynamic a, dynamic b, {int? precision}) {
    return multiply([a, b], precision: precision);
  }

  /// 两数相除
  static String divideTwo(dynamic a, dynamic b, {int? precision}) {
    return divide([a, b], precision: precision);
  }

  /// ============================================
  /// 3. 比较运算
  /// ============================================

  /// 比较两个数
  /// 返回值：a > b 返回 1，a < b 返回 -1，a == b 返回 0
  ///
  /// 例子：
  /// ```dart
  /// Calculator.compare('1.5', 2); // 返回 -1
  /// Calculator.compare(10, '10.0'); // 返回 0
  /// Calculator.compare('100', 50); // 返回 1
  /// ```
  static int compare(dynamic a, dynamic b) {
    final decimalA = _toDecimal(a);
    final decimalB = _toDecimal(b);
    return decimalA.compareTo(decimalB);
  }

  /// a 是否大于 b
  ///
  /// 例子：
  /// ```dart
  /// Calculator.greaterThan(10, 5); // true
  /// Calculator.greaterThan('5.5', 10); // false
  /// ```
  static bool greaterThan(dynamic a, dynamic b) {
    return compare(a, b) > 0;
  }

  /// a 是否小于 b
  static bool lessThan(dynamic a, dynamic b) {
    return compare(a, b) < 0;
  }

  /// a 是否等于 b
  static bool equal(dynamic a, dynamic b) {
    return compare(a, b) == 0;
  }

  /// a 是否大于等于 b
  static bool greaterThanOrEqual(dynamic a, dynamic b) {
    return compare(a, b) >= 0;
  }

  /// a 是否小于等于 b
  static bool lessThanOrEqual(dynamic a, dynamic b) {
    return compare(a, b) <= 0;
  }

  /// 是否大于零
  static bool isPositive(dynamic value) {
    return greaterThan(value, 0);
  }

  /// 是否小于零
  static bool isNegative(dynamic value) {
    return lessThan(value, 0);
  }

  /// 是否等于零
  static bool isZero(dynamic value) {
    return equal(value, 0);
  }

  /// ============================================
  /// 4. 精度控制
  /// ============================================

  /// 四舍五入到指定小数位
  ///
  /// 例子：
  /// ```dart
  /// Calculator.round('1.2345', 2); // 返回 "1.23"
  /// Calculator.round('1.2367', 2); // 返回 "1.24"
  /// ```
  static String round(dynamic value, int decimalPlaces) {
    final decimal = _toDecimal(value);
    return decimal.toStringAsFixed(decimalPlaces);
  }

  /// 向下取整（截断小数部分）
  ///
  /// 例子：
  /// ```dart
  /// Calculator.floor('1.9999'); // 返回 "1"
  /// Calculator.floor('-1.5'); // 返回 "-2"
  /// ```
  static String floor(dynamic value) {
    final decimal = _toDecimal(value);
    return decimal.floor().toString();
  }

  /// 向上取整
  ///
  /// 例子：
  /// ```dart
  /// Calculator.ceil('1.0001'); // 返回 "2"
  /// Calculator.ceil('-1.5'); // 返回 "-1"
  /// ```
  static String ceil(dynamic value) {
    final decimal = _toDecimal(value);
    return decimal.ceil().toString();
  }

  /// 截断到指定小数位（不四舍五入）
  ///
  /// 例子：
  /// ```dart
  /// Calculator.truncate('1.23456', 3); // 返回 "1.234"
  /// Calculator.truncate('9.9999', 2); // 返回 "9.99"
  /// ```
  static String truncate(dynamic value, int decimalPlaces) {
    if (decimalPlaces < 0) {
      throw ArgumentError('小数位数必须非负');
    }

    final decimal = _toDecimal(value);
    final multiplier = Decimal.parse(pow(10, decimalPlaces).toString());

    // 先乘以倍数，然后截断（向下取整），再除以倍数
    final truncated = (decimal * multiplier).toBigInt();
    final result = (Decimal.fromBigInt(truncated) / multiplier).toDecimal();

    return result.toStringAsFixed(decimalPlaces);
  }

  /// 取绝对值
  ///
  /// 例子：
  /// ```dart
  /// Calculator.abs('-123.45'); // 返回 "123.45"
  /// Calculator.abs('100'); // 返回 "100"
  /// ```
  static String abs(dynamic value) {
    final decimal = _toDecimal(value);
    return decimal.abs().toString();
  }

  /// ============================================
  /// 5. 区块链相关计算
  /// ============================================

  /// 将金额转换为原子单位（区块链 token 计算）
  ///
  /// 例子：
  /// ```dart
  /// Calculator.toAtomicUnits('1.5', 18); // 返回 BigInt: 1500000000000000000
  /// Calculator.toAtomicUnits('0.001', 6); // 返回 BigInt: 1000
  /// ```
  static BigInt toAtomicUnits(String amount, int decimals) {
    // 直接从字符串解析,避免 double 精度问题
    final decimal = Decimal.tryParse(amount) ?? Decimal.zero;
    if (decimal == Decimal.zero) return BigInt.zero;

    final factor = Decimal.parse(pow(10, decimals).toString());
    final atomicAmount = decimal * factor;

    // 使用 toBigInt() 而非 truncate().toBigInt()
    // Decimal 的 toBigInt() 会自动截断小数部分(向零取整)
    return atomicAmount.toBigInt();
  }

  /// 将原子单位转换为人类可读格式
  ///
  /// 例子：
  /// ```dart
  /// Calculator.fromAtomicUnits('1500000000000000000', 18); // 返回 "1.5"
  /// Calculator.fromAtomicUnits('1000', 6); // 返回 "0.001"
  /// ```
  static String fromAtomicUnits(
    String atomicAmount,
    int decimals, {
    int? precision,
  }) {
    if (atomicAmount.isEmpty) return '0';

    final amount = Decimal.parse(atomicAmount);
    final factor = Decimal.parse(pow(10, decimals).toString());
    final result = (amount / factor).toDecimal();

    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  /// 百分比转滑点（百分比 * 100）
  ///
  /// 例子：
  /// ```dart
  /// Calculator.percentToSlippage(0.5); // 返回 50
  /// Calculator.percentToSlippage(1.25); // 返回 125
  /// ```
  static int percentToSlippage(double percent) {
    return (percent * 100).toInt();
  }

  /// ============================================
  /// 6. 类型转换
  /// ============================================

  /// 转换为 Decimal（内部使用）
  static Decimal _toDecimal(dynamic value) {
    if (value == null) return Decimal.zero;

    if (value is Decimal) {
      return value;
    } else if (value is String) {
      return Decimal.tryParse(value) ?? Decimal.zero;
    } else if (value is int) {
      return Decimal.fromInt(value);
    } else if (value is double) {
      return Decimal.parse(value.toString());
    } else if (value is BigInt) {
      return Decimal.fromBigInt(value);
    } else {
      throw ArgumentError('不支持的类型: ${value.runtimeType}');
    }
  }

  /// 转换为 String
  static String toStringValue(dynamic value, {int? precision}) {
    final decimal = _toDecimal(value);
    return precision != null
        ? decimal.toStringAsFixed(precision)
        : decimal.toString();
  }

  /// 转换为 double
  static double toDouble(dynamic value) {
    return _toDecimal(value).toDouble();
  }

  /// 转换为 int
  static int toInt(dynamic value) {
    return _toDecimal(value).toBigInt().toInt();
  }

  /// 转换为 BigInt
  static BigInt toBigInt(dynamic value) {
    return _toDecimal(value).toBigInt();
  }

  /// 判断是否为整数（无小数部分）
  ///
  /// 例子：
  /// ```dart
  /// Calculator.isWholeNumber('10.0'); // true
  /// Calculator.isWholeNumber('10.5'); // false
  /// Calculator.isWholeNumber(100); // true
  /// ```
  static bool isWholeNumber(dynamic value) {
    try {
      final decimal = _toDecimal(value);
      final bigIntValue = decimal.toBigInt();
      return decimal == Decimal.fromBigInt(bigIntValue);
    } catch (e) {
      return false;
    }
  }

  /// ============================================
  /// 7. 特殊计算
  /// ============================================

  /// 计算百分比
  ///
  /// 例子：
  /// ```dart
  /// Calculator.percentage(50, 200); // 返回 "25" (50是200的25%)
  /// Calculator.percentage(30, 100, precision: 1); // 返回 "30.0"
  /// ```
  static String percentage(dynamic part, dynamic total, {int? precision}) {
    final partDecimal = _toDecimal(part);
    final totalDecimal = _toDecimal(total);

    if (totalDecimal == Decimal.zero) {
      throw ArgumentError('总数不能为零');
    }

    final result =
        ((partDecimal / totalDecimal).toDecimal() * Decimal.fromInt(100));
    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  /// 计算变化率（增长率或下降率）
  ///
  /// 例子：
  /// ```dart
  /// Calculator.changeRate(120, 100); // 返回 "20" (增长20%)
  /// Calculator.changeRate(80, 100); // 返回 "-20" (下降20%)
  /// ```
  static String changeRate(
    dynamic newValue,
    dynamic oldValue, {
    int? precision,
  }) {
    final newDecimal = _toDecimal(newValue);
    final oldDecimal = _toDecimal(oldValue);

    if (oldDecimal == Decimal.zero) {
      throw ArgumentError('原值不能为零');
    }

    final change = newDecimal - oldDecimal;
    final rate = ((change / oldDecimal).toDecimal() * Decimal.fromInt(100));

    return precision != null
        ? rate.toStringAsFixed(precision)
        : rate.toString();
  }

  /// 求最大值
  ///
  /// 例子：
  /// ```dart
  /// Calculator.max(['1.5', 10, '5.5', 3]); // 返回 "10"
  /// ```
  static String max(List<dynamic> values) {
    if (values.isEmpty) {
      throw ArgumentError('列表不能为空');
    }

    Decimal maxValue = _toDecimal(values[0]);

    for (int i = 1; i < values.length; i++) {
      final current = _toDecimal(values[i]);
      if (current > maxValue) {
        maxValue = current;
      }
    }

    return maxValue.toString();
  }

  /// 求最小值
  ///
  /// 例子：
  /// ```dart
  /// Calculator.min(['1.5', 10, '5.5', 3]); // 返回 "1.5"
  /// ```
  static String min(List<dynamic> values) {
    if (values.isEmpty) {
      throw ArgumentError('列表不能为空');
    }

    Decimal minValue = _toDecimal(values[0]);

    for (int i = 1; i < values.length; i++) {
      final current = _toDecimal(values[i]);
      if (current < minValue) {
        minValue = current;
      }
    }

    return minValue.toString();
  }

  /// 求平均值
  ///
  /// 例子：
  /// ```dart
  /// Calculator.average([10, 20, 30]); // 返回 "20"
  /// Calculator.average(['1.5', 2.5, 3], precision: 2); // 返回 "2.33"
  /// ```
  static String average(List<dynamic> values, {int? precision}) {
    if (values.isEmpty) {
      throw ArgumentError('列表不能为空');
    }

    final sum = add(values);
    final count = Decimal.fromInt(values.length);
    final result = (_toDecimal(sum) / count).toDecimal();

    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  /// 求和
  static String sum(List<dynamic> values, {int? precision}) {
    return add(values, precision: precision);
  }

  /// 幂运算
  ///
  /// 例子：
  /// ```dart
  /// Calculator.power(2, 3); // 返回 "8" (2^3)
  /// Calculator.power('1.5', 2); // 返回 "2.25" (1.5^2)
  /// ```
  static String power(dynamic base, int exponent) {
    final baseDecimal = _toDecimal(base);

    if (exponent == 0) return '1';
    if (exponent == 1) return baseDecimal.toString();

    Decimal result = baseDecimal;
    final isNegative = exponent < 0;
    final absExponent = exponent.abs();

    for (int i = 1; i < absExponent; i++) {
      result *= baseDecimal;
    }

    if (isNegative) {
      result = (Decimal.one / result).toDecimal();
    }

    return result.toString();
  }
}

/// ============================================
/// 8. 链式调用（Fluent API）
/// ============================================

/// 链式计算器（支持链式调用）
///
/// 例子：
/// ```dart
/// final result = CalculatorChain('100')
///   .add('50')
///   .subtract(20)
///   .multiply('2')
///   .divide(4)
///   .round(2)
///   .value; // "90.00"
///
/// // 条件判断
/// final isGreater = CalculatorChain('100')
///   .add(50)
///   .isGreaterThan('200'); // false
/// ```
class CalculatorChain {
  Decimal _value;

  CalculatorChain(dynamic initialValue)
    : _value = Calculator._toDecimal(initialValue);

  /// 加法
  CalculatorChain add(dynamic value) {
    _value += Calculator._toDecimal(value);
    return this;
  }

  /// 减法
  CalculatorChain subtract(dynamic value) {
    _value -= Calculator._toDecimal(value);
    return this;
  }

  /// 乘法
  CalculatorChain multiply(dynamic value) {
    _value *= Calculator._toDecimal(value);
    return this;
  }

  /// 除法
  CalculatorChain divide(dynamic value) {
    final divisor = Calculator._toDecimal(value);
    if (divisor == Decimal.zero) {
      throw ArgumentError('除数不能为零');
    }
    _value = (_value / divisor).toDecimal();
    return this;
  }

  /// 取绝对值
  CalculatorChain abs() {
    _value = _value.abs();
    return this;
  }

  /// 向下取整
  CalculatorChain floor() {
    _value = _value.floor();
    return this;
  }

  /// 向上取整
  CalculatorChain ceil() {
    _value = _value.ceil();
    return this;
  }

  /// 比较
  bool isGreaterThan(dynamic other) {
    return _value > Calculator._toDecimal(other);
  }

  bool isLessThan(dynamic other) {
    return _value < Calculator._toDecimal(other);
  }

  bool isEqual(dynamic other) {
    return _value == Calculator._toDecimal(other);
  }

  bool isGreaterThanOrEqual(dynamic other) {
    return _value >= Calculator._toDecimal(other);
  }

  bool isLessThanOrEqual(dynamic other) {
    return _value <= Calculator._toDecimal(other);
  }

  bool get isPositive => _value > Decimal.zero;
  bool get isNegative => _value < Decimal.zero;
  bool get isZero => _value == Decimal.zero;

  /// 获取结果
  String get value => _value.toString();

  /// 四舍五入获取结果
  String round(int decimalPlaces) {
    return _value.toStringAsFixed(decimalPlaces);
  }

  /// 截断获取结果
  String truncate(int decimalPlaces) {
    return Calculator.truncate(_value, decimalPlaces);
  }

  /// 转为 double
  double toDouble() => _value.toDouble();

  /// 转为 int
  int toInt() => _value.toBigInt().toInt();

  /// 转为 BigInt
  BigInt toBigInt() => _value.toBigInt();

  @override
  String toString() => value;
}

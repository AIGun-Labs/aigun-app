import 'dart:math';

import 'package:decimal/decimal.dart';

///
class Calculator {
  /// ============================================
  /// ============================================
  ///
  /// ```dart
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

  ///
  /// ```dart
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

  ///
  /// ```dart
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

  ///
  /// ```dart
  /// ```
  static String divide(List<dynamic> values, {int? precision}) {
    if (values.isEmpty) return '0';

    Decimal result = _toDecimal(values[0]);

    for (int i = 1; i < values.length; i++) {
      final divisor = _toDecimal(values[i]);
      if (divisor == Decimal.zero) {
        throw ArgumentError('');
      }
      result = (result / divisor).toDecimal();
    }

    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  /// ============================================
  /// ============================================
  static String addTwo(dynamic a, dynamic b, {int? precision}) {
    return add([a, b], precision: precision);
  }

  static String subtractTwo(dynamic a, dynamic b, {int? precision}) {
    return subtract([a, b], precision: precision);
  }

  static String multiplyTwo(dynamic a, dynamic b, {int? precision}) {
    return multiply([a, b], precision: precision);
  }

  static String divideTwo(dynamic a, dynamic b, {int? precision}) {
    return divide([a, b], precision: precision);
  }

  /// ============================================
  /// ============================================
  ///
  /// ```dart
  /// ```
  static int compare(dynamic a, dynamic b) {
    final decimalA = _toDecimal(a);
    final decimalB = _toDecimal(b);
    return decimalA.compareTo(decimalB);
  }

  ///
  /// ```dart
  /// Calculator.greaterThan(10, 5); // true
  /// Calculator.greaterThan('5.5', 10); // false
  /// ```
  static bool greaterThan(dynamic a, dynamic b) {
    return compare(a, b) > 0;
  }

  static bool lessThan(dynamic a, dynamic b) {
    return compare(a, b) < 0;
  }

  static bool equal(dynamic a, dynamic b) {
    return compare(a, b) == 0;
  }

  static bool greaterThanOrEqual(dynamic a, dynamic b) {
    return compare(a, b) >= 0;
  }

  static bool lessThanOrEqual(dynamic a, dynamic b) {
    return compare(a, b) <= 0;
  }

  static bool isPositive(dynamic value) {
    return greaterThan(value, 0);
  }

  static bool isNegative(dynamic value) {
    return lessThan(value, 0);
  }

  static bool isZero(dynamic value) {
    return equal(value, 0);
  }

  /// ============================================
  /// ============================================
  ///
  /// ```dart
  /// ```
  static String round(dynamic value, int decimalPlaces) {
    final decimal = _toDecimal(value);
    return decimal.toStringAsFixed(decimalPlaces);
  }

  ///
  /// ```dart
  /// ```
  static String floor(dynamic value) {
    final decimal = _toDecimal(value);
    return decimal.floor().toString();
  }

  ///
  /// ```dart
  /// ```
  static String ceil(dynamic value) {
    final decimal = _toDecimal(value);
    return decimal.ceil().toString();
  }

  ///
  /// ```dart
  /// ```
  static String truncate(dynamic value, int decimalPlaces) {
    if (decimalPlaces < 0) {
      throw ArgumentError('');
    }

    final decimal = _toDecimal(value);
    final multiplier = Decimal.parse(
      BigInt.from(10).pow(decimalPlaces).toString(),
    );
    final truncated = (decimal * multiplier).toBigInt();

    final result = (Decimal.fromBigInt(truncated) / multiplier).toDecimal(
      scaleOnInfinitePrecision: decimalPlaces,
    );

    return result.toStringAsFixed(decimalPlaces);
  }

  ///
  /// ```dart
  /// ```
  static String abs(dynamic value) {
    final decimal = _toDecimal(value);
    return decimal.abs().toString();
  }

  /// ============================================
  /// ============================================
  ///
  /// ```dart
  /// ```
  static BigInt toAtomicUnits(String amount, int decimals) {
    final decimal = Decimal.tryParse(amount) ?? Decimal.zero;
    if (decimal == Decimal.zero) return BigInt.zero;

    final factor = Decimal.parse(pow(10, decimals).toString());
    final atomicAmount = decimal * factor;
    return atomicAmount.toBigInt();
  }

  ///
  /// ```dart
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

  ///
  /// ```dart
  /// ```
  static int percentToSlippage(double percent) {
    return (percent * 100).toInt();
  }

  /// ============================================
  /// ============================================
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
      throw ArgumentError(': ${value.runtimeType}');
    }
  }

  static String toStringValue(dynamic value, {int? precision}) {
    final decimal = _toDecimal(value);
    return precision != null
        ? decimal.toStringAsFixed(precision)
        : decimal.toString();
  }

  static double toDouble(dynamic value) {
    return _toDecimal(value).toDouble();
  }

  static int toInt(dynamic value) {
    return _toDecimal(value).toBigInt().toInt();
  }

  static BigInt toBigInt(dynamic value) {
    return _toDecimal(value).toBigInt();
  }

  ///
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
  /// ============================================
  ///
  /// ```dart
  /// ```
  static String percentage(dynamic part, dynamic total, {int? precision}) {
    final partDecimal = _toDecimal(part);
    final totalDecimal = _toDecimal(total);

    if (totalDecimal == Decimal.zero) {
      throw ArgumentError('');
    }

    final result =
        ((partDecimal / totalDecimal).toDecimal() * Decimal.fromInt(100));
    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  ///
  /// ```dart
  /// ```
  static String changeRate(
    dynamic newValue,
    dynamic oldValue, {
    int? precision,
  }) {
    final newDecimal = _toDecimal(newValue);
    final oldDecimal = _toDecimal(oldValue);

    if (oldDecimal == Decimal.zero) {
      throw ArgumentError('');
    }

    final change = newDecimal - oldDecimal;
    final rate = ((change / oldDecimal).toDecimal() * Decimal.fromInt(100));

    return precision != null
        ? rate.toStringAsFixed(precision)
        : rate.toString();
  }

  ///
  /// ```dart
  /// ```
  static String max(List<dynamic> values) {
    if (values.isEmpty) {
      throw ArgumentError('');
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

  ///
  /// ```dart
  /// ```
  static String min(List<dynamic> values) {
    if (values.isEmpty) {
      throw ArgumentError('');
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

  ///
  /// ```dart
  /// ```
  static String average(List<dynamic> values, {int? precision}) {
    if (values.isEmpty) {
      throw ArgumentError('');
    }

    final sum = add(values);
    final count = Decimal.fromInt(values.length);
    final result = (_toDecimal(sum) / count).toDecimal();

    return precision != null
        ? result.toStringAsFixed(precision)
        : result.toString();
  }

  static String sum(List<dynamic> values, {int? precision}) {
    return add(values, precision: precision);
  }

  ///
  /// ```dart
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
/// ============================================
///
/// ```dart
/// final result = CalculatorChain('100')
///   .add('50')
///   .subtract(20)
///   .multiply('2')
///   .divide(4)
///   .round(2)
///   .value; // "90.00"
///
/// final isGreater = CalculatorChain('100')
///   .add(50)
///   .isGreaterThan('200'); // false
/// ```
class CalculatorChain {
  CalculatorChain(dynamic initialValue)
    : _value = Calculator._toDecimal(initialValue);
  Decimal _value;
  CalculatorChain add(dynamic value) {
    _value += Calculator._toDecimal(value);
    return this;
  }

  CalculatorChain subtract(dynamic value) {
    _value -= Calculator._toDecimal(value);
    return this;
  }

  CalculatorChain multiply(dynamic value) {
    _value *= Calculator._toDecimal(value);
    return this;
  }

  CalculatorChain divide(dynamic value) {
    final divisor = Calculator._toDecimal(value);
    if (divisor == Decimal.zero) {
      throw ArgumentError('');
    }
    _value = (_value / divisor).toDecimal();
    return this;
  }

  CalculatorChain abs() {
    _value = _value.abs();
    return this;
  }

  CalculatorChain floor() {
    _value = _value.floor();
    return this;
  }

  CalculatorChain ceil() {
    _value = _value.ceil();
    return this;
  }

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
  String get value => _value.toString();
  String round(int decimalPlaces) {
    return _value.toStringAsFixed(decimalPlaces);
  }

  String truncate(int decimalPlaces) {
    return Calculator.truncate(_value, decimalPlaces);
  }

  double toDouble() => _value.toDouble();
  int toInt() => _value.toBigInt().toInt();
  BigInt toBigInt() => _value.toBigInt();

  @override
  String toString() => value;
}

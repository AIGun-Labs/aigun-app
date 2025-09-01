import 'dart:math';

import 'package:decimal/decimal.dart';

Decimal multiplyPrecisely(double a, double b) {
  final aDecimal = Decimal.parse(a.toString());
  final bDecimal = Decimal.parse(b.toString());
  return aDecimal * bDecimal;
}

/// 将金额转换为原子单位
///
/// 例如：
/// 1.234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
/// 1.234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
/// @param amountString 金额
/// @param decimals 小数位数
/// @return 原子单位

BigInt convertAmountToAtomicUint(String amountString, int decimals) {
  final amount = Decimal.tryParse(amountString) ?? Decimal.zero;

  if (amount == Decimal.zero) return BigInt.zero;

  final factor = Decimal.parse(pow(10, decimals).toString());

  final atomicAmount = amount * factor;

  return atomicAmount.toBigInt();
}

int convertPercentToSlippage(double slippage) {
  return (slippage * 100).toInt();
}

/// 将数值乘以10的指定小数位数次方
///
/// 例如：
/// multiplyByDecimalPower(1.5, 6) = 1.5 * 10^6 = 1500000
/// multiplyByDecimalPower(0.001, 3) = 0.001 * 10^3 = 1
/// @param value 要计算的数值
/// @param decimals 小数位数
/// @return 计算结果
BigInt multiplyByDecimalPower(String value, int decimals) {
  final amount = Decimal.tryParse(value) ?? Decimal.zero;

  if (amount == Decimal.zero) return BigInt.zero;

  final factor = Decimal.parse(pow(10, decimals).toString());

  final result = amount * factor;

  return result.toBigInt();
}

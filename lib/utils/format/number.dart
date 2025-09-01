import 'package:decimal/decimal.dart';

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
  // 注意：判断顺序必须从大到小
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

// _removeTrailingZeros 函数与方案一相同
String _removeTrailingZeros(String n) {
  if (!n.contains('.')) return n;
  String trimmed = n.replaceAll(RegExp(r'0+$'), '');
  if (trimmed.endsWith('.')) {
    return trimmed.substring(0, trimmed.length - 1);
  }
  return trimmed;
}

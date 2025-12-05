extension StringExtensions on String {
  bool get isNotEmptyAndZeroValue {
    if (isEmpty) return false;

    final trimmed = trim();

    if (trimmed.isEmpty) return false;

    if (trimmed == "0" || trimmed == "-0") return false;

    if (trimmed.startsWith(".") || trimmed.endsWith(".")) return false;

    final numValue = num.tryParse(trimmed);

    if (numValue == null) return false;

    return numValue.abs() > 0;
  }

  String safeMultiply(String? other) {
    final numOther = double.tryParse(other ?? "0") ?? 0.0;
    final numThis = double.tryParse(this) ?? 0.0;
    return (numThis * numOther).toString();
  }

  DateTime toDateTime() {
    if (isEmpty) return DateTime.now();
    return DateTime.tryParse(this) ?? DateTime.now();
  }

  String toTitleCase() {
    if (isEmpty) return this;

    return split(RegExp(r"\s+"))
        .map((word) {
          if (word.isEmpty) return "";
          return word.capitelize();
        })
        .join(" ");
  }

  String toPercentage() {
    final numValue = double.tryParse(this) ?? 0.0;
    return (numValue / 100).toString();
  }

  String truncateWithCharCount(int maxLength, {String? ellipsis = '...'}) {
    if (length <= maxLength) {
      return this;
    }
    return '${substring(0, maxLength)}$ellipsis';
  }

  String divideByDecimalPower(int decimals) {
    if (isEmpty) {
      return "0";
    }

    final trimmed = trim();
    if (trimmed.isEmpty) return "0";

    final isNegative = trimmed.startsWith('-');
    final positiveStr = isNegative ? trimmed.substring(1) : trimmed;

    BigInt numerator;
    try {
      numerator = BigInt.parse(positiveStr);
    } catch (_) {
      return "0";
    }

    if (decimals <= 0) {
      final result = numerator.toString();
      return isNegative && result != '0' ? '-$result' : result;
    }

    final divisor = BigInt.from(10).pow(decimals);
    final quotient = numerator ~/ divisor;
    final remainder = numerator % divisor;

    String remainderStr = remainder.toString().padLeft(decimals, '0');

    if (RegExp(r'^0+$').hasMatch(remainderStr)) {
      final result = quotient.toString();
      return isNegative && result != '0' ? '-$result' : result;
    }

    while (remainderStr.endsWith('0')) {
      remainderStr = remainderStr.substring(0, remainderStr.length - 1);
    }

    final result = "${quotient.toString()}.$remainderStr";
    return isNegative ? '-$result' : result;
  }

  String splitStartAndEnd(int start, int end, {String? separator = "..."}) {
    if (isEmpty) {
      return "";
    }

    // If start or end are invalid, return original string
    if (start < 0 || end < 0) {
      return this;
    }

    // If the string is too short to be truncated, return it as is
    if (length <= start + end) {
      return this;
    }

    // Ensure we don't exceed string bounds
    final safeStart = start.clamp(0, length);
    final safeEnd = end.clamp(0, length);

    // If after clamping, the string would be fully shown, return it as is
    if (safeStart + safeEnd >= length) {
      return this;
    }

    return "${substring(0, safeStart)}$separator${substring(length - safeEnd, length)}";
  }

  String capitelize() {
    if (isEmpty) return this;

    return this[0].toUpperCase() + substring(1);
  }

  int toInt() {
    if (isEmpty) return 0;
    return int.tryParse(this) ?? 0;
  }

  bool isPositive() {
    if (isEmpty) return false;
    return toInt() > 0 ? true : false;
  }

  String splitValueByCount({int? count}) {
    if (isEmpty) return "?";

    return substring(0, count ?? 1).toUpperCase();
  }

  String takeFirst(int n) => substring(0, length < n ? length : n);

  String splitWithSymbol(int n, {String? symbol = "..."}) {
    if (isEmpty) return this;

    if (length > n) return "${substring(0, n)}$symbol";

    return this;
  }

  String withSymbol({String symbol = "", bool isPrefix = true}) {
    if (isEmpty) return this;

    return isPrefix ? "$symbol$this" : "$this$symbol";
  }

  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }

  String removeNegativeSign() {
    if (isEmpty) return this;
    if (startsWith("-")) {
      return substring(1);
    }
    return this;
  }

  String removeTrailing() {
    if (isEmpty || length == 1) return '';

    return substring(0, length - 1);
  }

  String removeLeading() {
    if (isEmpty || length == 1) return '';

    return substring(1);
  }

  String addNegativeSign(dynamic value) {
    final newValue = double.tryParse(value.toString()) ?? 0;

    if (newValue < 0) {
      return "-$this";
    }
    return this;
  }
}

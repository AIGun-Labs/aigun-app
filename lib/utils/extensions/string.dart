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

  String toPercentage() {
    final numValue = double.tryParse(this) ?? 0.0;
    return (numValue / 100).toString();
  }

  
}

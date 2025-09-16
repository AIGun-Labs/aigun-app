extension NumberExtensions on num {
  num multiplyBy(int other) {
    return this * other;
  }

  double safeMultiply(String? other) {
    final numOther = double.tryParse(other ?? "0") ?? 0.0;

    return toDouble() * numOther;
  }
}

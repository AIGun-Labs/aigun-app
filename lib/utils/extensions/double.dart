extension DoubleExtensions on double {
  double get removeNegativeSign {
    final str = toString();
    if (str.startsWith("-")) {
      return double.tryParse(str.substring(1)) ?? 0;
    }
    return this;
  }
}

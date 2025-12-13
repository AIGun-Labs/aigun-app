enum CandleSource {
  okx('okx'),
  cmc('cmc');

  const CandleSource(this.value);

  factory CandleSource.fromString(String value) {
    return CandleSource.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CandleSource.okx,
    );
  }

  final String value;
}

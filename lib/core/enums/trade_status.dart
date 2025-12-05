enum TradeStatus {
  pending("PENDING"),
  success("SUCCESS"),
  failed("FAILED");

  final String value;

  const TradeStatus(this.value);
}

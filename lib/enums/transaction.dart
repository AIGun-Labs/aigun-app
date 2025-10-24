enum TransactionStatusEnum {
  success("SUCCESS"),
  pending("PENDING"),
  failed("FAILED");

  const TransactionStatusEnum(this.value);
  final String value;
}

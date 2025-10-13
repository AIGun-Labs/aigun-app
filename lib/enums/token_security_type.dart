enum TokenSecurityType {
  risk('risk'),
  warning('attention');

  final String type;
  const TokenSecurityType(this.type);
}

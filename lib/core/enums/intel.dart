enum IntelQueryType {
  event('event'),
  radarSignal('radar_signal');

  final String type;
  const IntelQueryType(this.type);
}

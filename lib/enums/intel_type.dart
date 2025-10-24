enum IntelType {
  radarSignal('radar_signal'),
  twitter('twitter'),
  news('news'),
  telegram('telegram');

  final String type;
  const IntelType(this.type);
}

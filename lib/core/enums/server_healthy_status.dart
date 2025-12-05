enum ServerHealthyStatus {
  healthy("healthy"),
  unhealthy("unhealthy");

  const ServerHealthyStatus(this.value);
  final String value;
}

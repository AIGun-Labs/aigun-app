class NetworkException implements Exception {
  final String message;
  final int? code;

  NetworkException({required this.message, this.code});

  @override
  String toString() => '[$code] $message';
}

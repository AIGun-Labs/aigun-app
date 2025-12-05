sealed class AppException implements Exception {
  final String message;
  final int? code;

  AppException({required this.message, this.code});
}

class BusinessException extends AppException {
  BusinessException({required super.message, super.code});

  @override
  String toString() => '$message ($code)';
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.code});

  @override
  String toString() => '[$code] $message';
}

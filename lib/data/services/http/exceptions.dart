class ApiException implements Exception {
  final String message;
  final int code;

  ApiException(this.message, this.code);

  @override
  String toString() => 'ApiException(code: $code, message: $message)';
}

class ApiResponseException implements Exception {
  final String message;
  final int code;

  const ApiResponseException(this.message, this.code);

  @override
  String toString() => 'ApiResponseException(code: $code, message: $message)';
}

/// Unauthorized exception
class UnauthorizedException implements Exception {
  final String? message;
  UnauthorizedException([this.message]);

  @override
  String toString() => message ?? 'Unauthorized, please login again';
}

/// Validation exception
class ValidationException implements Exception {
  final String? message;
  ValidationException([this.message]);

  @override
  String toString() => message ?? 'Parameter validation failed';
}

/// Server exception
class ServerException implements Exception {
  final String? message;
  ServerException([this.message]);

  @override
  String toString() => message ?? 'Server error';
}

/// Network exception
class NetworkException implements Exception {
  final String? message;
  NetworkException([this.message]);

  @override
  String toString() => message ?? 'Network connection error';
}

/// Request cancelled exception
class RequestCancelledException implements Exception {
  final String? message;
  RequestCancelledException([this.message]);

  @override
  String toString() => message ?? 'Request has been cancelled';
}

/// Unknown exception
class UnknownException implements Exception {
  final String? message;
  UnknownException([this.message]);

  @override
  String toString() => message ?? 'Unknown error';
}

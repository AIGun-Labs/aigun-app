class BusinessException implements Exception {
  final int code;
  final String msg;

  BusinessException({
    required this.code,
    required this.msg,
  });

  @override
  String toString() => "BusinessException: $code, $msg";
}

class ServerException implements Exception {}

abstract class Failure implements Exception {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'A server error occurred']);
}

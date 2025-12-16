import 'package:dio/dio.dart';

final class AppException<C extends Object?> implements Exception {
  AppException({required this.message, this.code, this.cause, this.stackTrace});
  final String message;
  final int? code;
  final C? cause;
  final StackTrace? stackTrace;
}

final class BusinessException extends AppException {
  BusinessException({
    required super.message,
    super.code,
    super.cause,
    super.stackTrace,
  });

  @override
  String toString() => '[$code] $message';
}

final class NetworkException extends AppException<DioException> {
  NetworkException({
    required super.message,
    super.code,
    super.cause,
    super.stackTrace,
  });

  @override
  String toString() => '[$code] $message';
}

final class JsonException extends AppException {
  JsonException({
    required super.message,
    super.code,
    super.cause,
    super.stackTrace,
  });

  @override
  String toString() => '[$code] $message';
}

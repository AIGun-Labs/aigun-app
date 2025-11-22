import 'package:dio/dio.dart';

import 'app_exception.dart';

class ErrorHandler {
  static AppException handle(dynamic error) {
    if (error is BusinessException) {
      return error;
    }

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException(
              message:
                  'Network connection timeout, please check your network settings',
              code: 408);
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          String msg = 'Server request failed';
          if (data is Map && data.containsKey('message')) {
            msg = data['message'];
          }
          return NetworkException(message: msg, code: statusCode);
        case DioExceptionType.cancel:
          return NetworkException(message: 'Request cancelled');
        case DioExceptionType.connectionError:
          return NetworkException(
              message:
                  'Network connection error, please check your network settings');
        default:
          return NetworkException(message: 'Unknown network error');
      }
    } else if (error is NetworkException) {
      return error;
    } else {
      return NetworkException(message: 'Unknown error: $error');
    }
  }
}

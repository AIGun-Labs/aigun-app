import 'package:dio/dio.dart';

import '../../../core/services/logger_service.dart';
import 'app_exception.dart';

final class AppErrorHandler {
  AppErrorHandler(this._logger);
  final LoggerService _logger;

  final String _tag = 'AppErrorHandler';

  AppException handle(Object error, {StackTrace? stackTrace}) {
    String errorMessage = 'Unknown error: $error';
    StackTrace? stackTrace0 = stackTrace;

    //先创建一个网络错误兜底
    AppException<Object?> appException = AppException(
      message: errorMessage,
      code: -1,
      cause: error,
      stackTrace: stackTrace0,
    );

    //如果错误是业务异常，则直接返回(BusinessException,和JsonException 都是AppException的子类)
    if (error is AppException) {
      errorMessage = 'AppException: $error';
      appException = error;
      stackTrace0 ??= error.stackTrace;
    }

    //如果错误是DioException，则处理成网络错误
    if (error is DioException) {
      final ex = _handleDioException(error);

      errorMessage = 'DioException mapped to $ex';
      appException = ex;
      stackTrace0 ??= error.stackTrace;
    }

    //如果错误是FormatException或TypeError，则处理成Json错误
    if (error is FormatException || error is TypeError) {
      final ex = JsonException(
        message: 'Data parsing error',
        code: -1,
        cause: error,
        stackTrace: stackTrace0,
      );

      errorMessage = 'JsonException: $error';
      appException = ex;
    }

    //记录错误日志
    _logger.error(
      errorMessage,
      tag: _tag,
      error: error,
      stackTrace: stackTrace0,
    );

    return appException;
  }

  NetworkException _handleDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    String msg;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        msg = 'Network connection timeout';
        return NetworkException(
          message: msg,
          code: 408,
          cause: error,
          stackTrace: error.stackTrace,
        );
      case DioExceptionType.badResponse:
        msg = 'Server request failed';
        int? bizCode;

        if (data is Map<String, dynamic>) {
          bizCode = data['code'] as int?;
          msg = (data['message'] ?? msg).toString();
        }
        return NetworkException(
          message: msg,
          code: bizCode ?? statusCode,
          cause: error,
          stackTrace: error.stackTrace,
        );
      case DioExceptionType.cancel:
        msg = 'Request cancelled';

        return NetworkException(
          message: msg,
          code: statusCode,
          cause: error,
          stackTrace: error.stackTrace,
        );
      case DioExceptionType.connectionError:
        msg = 'Network connection error';
        return NetworkException(
          message: msg,
          code: statusCode,
          cause: error,
          stackTrace: error.stackTrace,
        );
      default:
        msg = 'Unknown network error';
        return NetworkException(
          message: msg,
          code: statusCode,
          cause: error,
          stackTrace: error.stackTrace,
        );
    }
  }
}

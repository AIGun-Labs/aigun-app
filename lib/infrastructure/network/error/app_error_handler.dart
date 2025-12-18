import 'package:dio/dio.dart';

import '../../../core/services/logger_service.dart';
import 'app_exception.dart';

enum NetworkExceptionMessageEnum {
  connectionTimeout('CONNECTION_TIMEOUT'),
  serverRequestFailed('REQUEST_FAILED'),
  requestCancelled('REQUEST_CANCELLED'),
  networkConnectionError('CONNECTION_ERROR'),
  unknownNetworkError('UNKNOWN_ERROR');

  final String message;
  const NetworkExceptionMessageEnum(this.message);
}

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
    int? code = error.response?.statusCode;
    String? message = error.message;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = NetworkExceptionMessageEnum.connectionTimeout.message;
        code = 408;
        break;
      case DioExceptionType.badResponse:
        message = NetworkExceptionMessageEnum.serverRequestFailed.message;
        break;
      case DioExceptionType.cancel:
        message = NetworkExceptionMessageEnum.requestCancelled.message;
        break;
      case DioExceptionType.connectionError:
        message = NetworkExceptionMessageEnum.networkConnectionError.message;
        break;
      default:
        message = NetworkExceptionMessageEnum.unknownNetworkError.message;
        break;
    }

    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final dataCode = data['code'] as int?;
      final dataMessage = data['message'] as String?;
      if (dataCode != null && dataCode.toString().isNotEmpty) {
        code = dataCode;
      }
      if (dataMessage != null && dataMessage.isNotEmpty) {
        message = dataMessage;
      }
    }

    return NetworkException(
      message: message,
      code: code,
      cause: error,
      stackTrace: error.stackTrace,
    );
  }
}

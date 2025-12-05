import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'dio_client.dart';
import 'exceptions.dart';

class ErrorHandler {
  final DioClient dioClient;

  ErrorHandler(this.dioClient);

  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 1);

  /// Handles Dio errors and converts them to business exceptions
  Exception handleDioError(DioException e) {
    // Report to Sentry
    _reportToSentry(e);

    switch (e.type) {
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;

        final message = e.response?.data['msg'] ?? e.response?.data['message'];
        final code = e.response?.data['code'];
        if (statusCode == 200) {
          return ApiException(message, code);
        }

        if (statusCode != null && statusCode >= 400 && statusCode < 500) {
          return ValidationException(
            e.response?.data['msg'] ?? _getClientErrorMessage(statusCode),
          );
        }

        if (statusCode != null && statusCode >= 500) {
          return ServerException(_getServerErrorMessage(statusCode));
        }

        return UnknownException('Unknown HTTP error: $statusCode');
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          'Network connection timeout, please check your network settings',
        );
      case DioExceptionType.cancel:
        return RequestCancelledException('Request has been cancelled');
      default:
        return UnknownException('Network error, please try again later');
    }
  }

  /// Handles Dio errors and returns DioException
  DioException handleDioErrorWithRetry(DioException error) {
    // Report to Sentry
    _reportToSentry(error);

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return _createTimeoutError(error);
      case DioExceptionType.badResponse:
        return _handleResponseError(error);
      case DioExceptionType.cancel:
        return _createCancelError(error);
      default:
        return _createDefaultError(error);
    }
  }

  void _reportToSentry(DioException error) {
    if (kDebugMode) return;

    final statusCode = error.response?.statusCode;

    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      _getClientErrorMessage(statusCode);
    } else if (statusCode != null && statusCode >= 500) {
      _getServerErrorMessage(statusCode);
    } else {
      'Network error (${statusCode ?? 'unknown'})';
    }

    // SentryConfig.reportError(
    //   error,
    //   error.stackTrace,
    //   hint: 'API Error: ${error.type}',
    //   extra: {
    //     'url': error.requestOptions.uri.toString(),
    //     'method': error.requestOptions.method,
    //     'statusCode': statusCode,
    //     'errorMessage': errorMessage,
    //     'responseData': error.response?.data,
    //     'requestData': error.requestOptions.data,
    //     'queryParameters': error.requestOptions.queryParameters,
    //     'headers': error.requestOptions.headers,
    //     'errorType': error.type.toString(),
    //   },
    // );
  }

  DioException _createTimeoutError(DioException error) {
    return DioException(
      requestOptions: error.requestOptions,
      error: 'Network connection timeout, please check your network settings',
      type: error.type,
    );
  }

  DioException _createCancelError(DioException error) {
    return DioException(
      requestOptions: error.requestOptions,
      error: 'Request has been cancelled',
      type: error.type,
    );
  }

  DioException _createDefaultError(DioException error) {
    return DioException(
      requestOptions: error.requestOptions,
      error: 'Network error, please try again later',
      type: error.type,
    );
  }

  DioException _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    String message;

    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      message = _getClientErrorMessage(statusCode);
    } else if (statusCode != null && statusCode >= 500) {
      message = _getServerErrorMessage(statusCode);
    } else {
      message = 'Network error (${statusCode ?? 'unknown'})';
    }

    return DioException(
      requestOptions: error.requestOptions,
      error: message,
      type: error.type,
      response: error.response,
    );
  }

  String _getClientErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Parameter validation failed';
      case 401:
        return 'Unauthorized, please login again';
      case 403:
        return 'Access denied';
      case 404:
        return 'Request URL does not exist';
      case 422:
        return 'Data validation failed';
      default:
        return 'Client error (${statusCode ?? 'unknown'})';
    }
  }

  String _getServerErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 500:
        return 'Internal server error';
      case 502:
        return 'Gateway error';
      case 503:
        return 'Service unavailable';
      case 504:
        return 'Gateway timeout';
      default:
        return 'Server error (${statusCode ?? 'unknown'})';
    }
  }

  bool shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        (error.type == DioExceptionType.badResponse &&
            error.response?.statusCode ==
                503); // Also retry when service is unavailable
  }

  Future<void> retry(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final options = error.requestOptions;

    // Get current retry count
    final retryCount = options.extra['retryCount'] as int? ?? 0;

    if (retryCount >= _maxRetries) {
      // Exceeded maximum retry attempts, report error
      // SentryConfig.reportError(
      //   error,
      //   error.stackTrace,
      //   hint: 'API Retry Failed',
      //   extra: {
      //     'url': options.uri.toString(),
      //     'method': options.method,
      //     'retryCount': retryCount,
      //   },
      // );
      handler.next(error);
      return;
    }

    // Delay retry to avoid immediate retries
    await Future.delayed(_retryDelay);

    try {
      // Update retry count
      options.extra['retryCount'] = retryCount + 1;

      final response = await dioClient.dioInstance.fetch(options);
      handler.resolve(response);
    } catch (e) {
      handler.next(error);
    }
  }

  String? handleTimeoutError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timed out. Please try again later.';
    }
    return null;
  }
}

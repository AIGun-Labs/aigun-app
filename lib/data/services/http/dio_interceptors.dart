import 'package:dio/dio.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/services/http/error_handler.dart';
import 'package:flutter_aigun/data/services/http/interceptors/api_interceptor.dart';
import 'package:flutter_aigun/data/services/http/interceptors/business_interceptor.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/shared/utils/offline_queue.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioInterceptors {
  DioInterceptors();

  final queueManager = getIt<OfflineQueueManager>();

  /// Initialize and add all interceptors
  void init(Dio dio) {
    dio.interceptors.addAll([
      OfflineQueueInterceptor(manager: queueManager),
      ApiInterceptor(dio),
      BusinessInterceptor(),
      _createRetryInterceptor(), // Retry logic
      _createPrettyInterceptor(), // Pretty logging
    ]);
  }

  /// Retry interceptor with configurable retry attempts and delay
  Interceptor _createRetryInterceptor() {
    return QueuedInterceptorsWrapper(
      onError: (error, handler) async {
        final errorHandler = getIt.get<ErrorHandler>();

        if (errorHandler.shouldRetry(error)) {
          return await errorHandler.retry(error, handler);
        }

        handler.next(error);
      },
    );
  }

  /// Pretty logger for Dio requests and responses
  Interceptor _createPrettyInterceptor() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }
}

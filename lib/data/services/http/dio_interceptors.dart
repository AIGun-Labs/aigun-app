import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core/service_locator.dart';
import '../../../shared/utils/offline_queue.dart';
import '../../../utils/storage/secure/token_storage_service.dart';
import '../index.dart';
import 'error_handler.dart';
import 'interceptors/api_interceptor.dart';
import 'interceptors/business_interceptor.dart';
import 'interceptors/refresh_interceptor.dart';

class DioInterceptors {
  DioInterceptors();

  final queueManager = getIt<OfflineQueueManager>();

  /// Initialize and add all interceptors
  void init(Dio dio) {
    dio.interceptors.addAll([
      OfflineQueueInterceptor(manager: queueManager),
      ApiInterceptor(dio),
      BusinessInterceptor(),
      // _createRefreshInterceptor(dio),
      _createRetryInterceptor(), // Retry logic
      // _createPrettyInterceptor(), // Pretty logging
    ]);
  }

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

  Interceptor _createRefreshInterceptor(Dio dio) {
    return RefreshInterceptor(
      dio: dio,
      refreshUrl: "/refresh",
      tokenStorageService: getIt.get<TokenStorageService>(),
    );
  }
}

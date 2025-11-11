import 'package:dio/dio.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/services/http/interceptors/api_interceptor.dart';
import 'package:flutter_aigun/data/services/http/interceptors/business_interceptor.dart';
import 'package:flutter_aigun/shared/utils/offline_queue.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:ansicolor/ansicolor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

class DioInterceptors {
  DioInterceptors();

  final queueManager = getIt<OfflineQueueManager>();

  /// Initialize and add all interceptors
  void init(Dio dio) {
    dio.interceptors.addAll([
      OfflineQueueInterceptor(manager: queueManager),
      ApiInterceptor(dio),
      BusinessInterceptor(),
      // _createRetryInterceptor(), // Retry logic
      _createSmartRetryInterceptor(dio),
      _createTalkerInterceptor(), // Talker logging
    ]);
  }

  /// Retry interceptor with configurable retry attempts and delay
  // Interceptor _createRetryInterceptor() {
  //   return QueuedInterceptorsWrapper(
  //     onError: (error, handler) async {
  //       final errorHandler = getIt.get<ErrorHandler>();

  //       if (errorHandler.shouldRetry(error)) {
  //         return await errorHandler.retry(error, handler);
  //       }

  //       handler.next(error);
  //     },
  //   );
  // }

  Interceptor _createTalkerInterceptor() {
    return TalkerDioLogger(
      settings: TalkerDioLoggerSettings(
          // Blue http requests logs in console
          requestPen: AnsiPen()..blue(),
          // Green http responses logs in console
          responsePen: AnsiPen()..green(),
          // Error http logs in console
          errorPen: AnsiPen()..red(),
          printRequestHeaders: true,
          // printRequestData: true,
          printErrorMessage: true,
          printResponseTime: true),
    );
  }

  Interceptor _createSmartRetryInterceptor(Dio dio) {
    return RetryInterceptor(
      dio: dio,
      retries: 3,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 3),
        Duration(seconds: 5),
      ],
    );
  }

  /// Pretty logger for Dio requests and responses
  // Interceptor _createPrettyInterceptor() {
  //   return PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseHeader: false,
  //     responseBody: false,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90,
  //   );
  // }
}

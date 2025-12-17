import 'package:dio/dio.dart';

import '../../../core/services/logger_service.dart';

class AppDioLoggerInterceptor extends Interceptor {
  AppDioLoggerInterceptor(this._logger, {this.enableBodyLog = true});
  final LoggerService _logger;
  final bool enableBodyLog;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug(
      'REQUEST: ${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Query: ${options.queryParameters}\n'
      'Body: ${enableBodyLog ? options.data : '<<hidden>>'}',
      tag: 'DIO',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.debug(
      'RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}\n'
      'Data: ${enableBodyLog ? response.data : '<<hidden>>'}',
      tag: 'DIO',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      'ERROR: ${err.requestOptions.uri} - ${err.message}',
      tag: 'DIO',
      error: err,
      stackTrace: err.stackTrace,
    );
    super.onError(err, handler);
  }
}

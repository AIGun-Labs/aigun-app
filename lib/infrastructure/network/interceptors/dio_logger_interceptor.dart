import 'package:dio/dio.dart';

import '../../../core/services/logger_service.dart';

class AppDioLoggerInterceptor extends Interceptor {
  AppDioLoggerInterceptor(this._logger, {this.enableBodyLog = true});
  final LoggerService _logger;
  final bool enableBodyLog;

  final String _tag = 'DIO';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug(
      'Request[${options.method}]: ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Query: ${options.queryParameters}\n'
      'Body: ${enableBodyLog ? options.data : '<<hidden>>'}',
      tag: _tag,
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.debug(
      'Response[${response.statusCode}]: ${response.requestOptions.uri}\n'
      'Data: ${enableBodyLog ? response.data : '<<hidden>>'}',
      tag: _tag,
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      'Error: ${err.requestOptions.uri}\n'
      'Message: ${err.message}\n'
      'Headers: ${err.response?.headers}\n'
      'Query: ${err.requestOptions.queryParameters}\n'
      'Body: ${enableBodyLog ? err.requestOptions.data : '<<hidden>>'}\n'
      'Response: ${err.response?.data}\n',
      tag: _tag,
      error: err,
      stackTrace: err.stackTrace,
    );
    super.onError(err, handler);
  }
}

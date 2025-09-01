import 'package:dio/dio.dart';
import 'package:flutter_aigun/core/custom_exceptions.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/services/http/error_handler.dart';
import 'package:flutter_aigun/data/services/http/interceptors/api_interceptor.dart';
import 'package:flutter_aigun/data/services/http/interceptors/business_interceptor.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/storage/index.dart';
import 'package:flutter_aigun/utils/storage/secure/secure_storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioInterceptors {
  DioInterceptors();

  /// 添加所有拦截器
  void init(Dio dio) {
    dio.interceptors.addAll([
      ApiInterceptor(dio),
      BusinessInterceptor(),
      _createRetryInterceptor(),
      _createPrettyInterceptor(),
    ]);
  }

  /// 日志拦截器
  // Interceptor _createLogInterceptor() {
  //   return LogInterceptor(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseHeader: false,
  //     responseBody: false,
  //     error: true,
  //     logPrint: (object) {
  //       Logger.network(object.toString());
  //     },
  //   );
  // }

  /// 重试拦截器
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

  /// 请求拦截函数
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 获取token
    // SecureStorageService secureStorageService = getIt.get<SecureStorageService>();
    final token = await SecureStorageService().getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  /// 响应拦截函数
  void _onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    dynamic responseData = response.data;

    if (responseData is Map<String, dynamic>) {
      // 确保 'code' 字段存在且为数字
      if (!responseData.containsKey('code') || responseData['code'] is! num) {
        final error = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: "Response format error: 'code' is missing or  nota number.",
        );
        return handler.reject(error);
      }

      // 确保 'msg' 字段存在，如果为 null 则提供默认值
      if (!responseData.containsKey('msg') || responseData['msg'] == null) {
        responseData['msg'] = '';
      }

      try {
        if (responseData['code'] == 0) {
          // 业务成功，继续传递原始响应
          return handler.next(response);
        } else {
          // 业务失败，拒绝请求并附带业务异常信息
          final businessException = BusinessException(
            code: responseData['code'],
            msg: responseData['msg'],
          );
          final error = DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            message: businessException.msg,
            error: businessException,
          );
          return handler.reject(error);
        }
      } catch (e) {
        // JSON 解析或模型转换失败
        final error = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.unknown,
          message: 'Failed to parse response or convert to model: $e',
          error: e,
        );
        return handler.reject(error);
      }
    }

    // 如果响应数据不是 Map，直接继续
    handler.next(response);
  }

  /// 错误拦截函数
  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    Logger.error('Error occurred: ${err?.message}');
    if (err.response?.data != null) {
      Logger.error(
          'Response JSON: ${err.requestOptions.uri} ${err.response?.data}');
    }

    handler.reject(err);
  }
}

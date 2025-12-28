import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import '../../core/services/gate_keeper_service.dart';
import '../../core/services/logger_service.dart';
import '../../features/anti_spider/domain/anti_spider/anti_spider_service.dart';
import '../../features/anti_spider/infrastructure/network/anti_spider_interceptor.dart';
import '../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import 'error/app_error_handler.dart';
import 'error/app_exception.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/dio_logger_interceptor.dart';
import 'interceptors/gate_interceptor.dart';
import 'models/api_response.dart';

const String kContentTypeJson = 'application/json';

class DioClient {
  DioClient(
    this._userCubit,
    this._gatekeeper,
    this._errorHandler,
    this._antiSpiderKeyService,
    this._logger, {
    required String baseUrl,
    required bool enableNetworkLog,
  }) {
    final options = BaseOptions(
      baseUrl: baseUrl, //  envied  URL
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': kContentTypeJson, 'Accept': kContentTypeJson},
      responseType: ResponseType.json,
    );

    _dio = Dio(options);
    _dio.interceptors
      ..add(AuthInterceptor(_userCubit, _dio))
      ..add(RetryInterceptor(dio: _dio))
      ..add(AntiSpiderInterceptor(keyService: _antiSpiderKeyService))
      ..add(GateInterceptor(_gatekeeper));

    if (enableNetworkLog) {
      _dio.interceptors.add(AppDioLoggerInterceptor(_logger));
    }
  }
  late final Dio _dio;
  final NewUserCubit _userCubit;
  final GateKeeperService _gatekeeper;
  final AppErrorHandler _errorHandler;
  final AntiSpiderKeyService _antiSpiderKeyService;
  final LoggerService _logger;
  Future<T?> _request<T>(Future<Response> Function() request) async {
    try {
      final response = await request();
      final apiResponse = ApiResponse<T>.fromJson(response.data, (json) {
        if (json is T) {
          return json;
        }
        throw JsonException(message: 'Expected $T type');
      });
      if (!apiResponse.isSuccess) {
        throw BusinessException(
          message: apiResponse.msg,
          code: apiResponse.code,
        );
      }
      return apiResponse.data;
    } catch (e) {
      throw _errorHandler.handle(e);
    }
  }

  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<T?> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<T?> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<T?> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Dio get dioInstance => _dio;
}

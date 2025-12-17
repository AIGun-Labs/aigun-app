import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/services/gate_keeper_service.dart';
import '../../core/services/logger_service.dart';
import '../../features/anti_spider/domain/anti_spider/anti_spider_service.dart';
import '../../features/anti_spider/infrastructure/network/anti_spider_interceptor.dart';
import 'error/app_error_handler.dart';
import 'error/app_exception.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/dio_logger_interceptor.dart';
import 'interceptors/gate_interceptor.dart';
import 'models/api_response.dart';

// 定义常用的 Content-Type
const String kContentTypeJson = 'application/json';

class DioClient {
  // 单例模式（可选，如果使用 GetIt 注册为 Singleton 则不需要内部单例）
  DioClient(
    this._storage,
    this._gatekeeper,
    this._errorHandler,
    this._antiSpiderKeyService,
    this._logger, {
    required String baseUrl,
    required bool enableNetworkLog,
  }) {
    // 2. 配置 BaseOptions
    final options = BaseOptions(
      baseUrl: baseUrl, // 动态获取 envied 中的 URL
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': kContentTypeJson, 'Accept': kContentTypeJson},
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    if (enableNetworkLog) {
      _dio.interceptors.add(AppDioLoggerInterceptor(_logger));
    }

    // 3. 添加拦截器
    _dio.interceptors
      ..add(AuthInterceptor(_storage, _dio))
      ..add(RetryInterceptor(dio: _dio))
      ..add(AntiSpiderInterceptor(keyService: _antiSpiderKeyService))
      ..add(GateInterceptor(_gatekeeper));
  }
  late final Dio _dio;
  final FlutterSecureStorage _storage;
  final GateKeeperService _gatekeeper;
  final AppErrorHandler _errorHandler;
  final AntiSpiderKeyService _antiSpiderKeyService;
  final LoggerService _logger;

  /// 核心处理方法 (私有)
  /// 1. 执行请求
  /// 2. 解析 ApiResponse
  /// 3. 校验 code
  /// 4. 返回 data
  Future<T?> _request<T>(Future<Response> Function() request) async {
    try {
      final response = await request();

      // 1. 解析外层结构 ApiResponse<T>
      // 注意：这里把 response.data 传进去，利用泛型工厂解析
      final apiResponse = ApiResponse<T>.fromJson(response.data, (json) {
        if (json is T) {
          return json;
        }
        throw JsonException(message: 'Expected $T type');
      });

      // 2. 业务逻辑校验拦截
      if (!apiResponse.isSuccess) {
        throw BusinessException(
          message: apiResponse.msg,
          code: apiResponse.code,
        );
      }

      // 3. 返回剥壳后的 data (可能是 Map, List 或 null)
      return apiResponse.data;
    } catch (e) {
      // 这里的 ErrorHandler 需要兼容处理 BusinessException
      throw _errorHandler.handle(e);
    }
  }

  // --- 封装常用方法 ---

  /// GET 请求
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

  /// POST 请求
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

  /// PUT 请求
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

  /// DELETE 请求
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

  // 暴露原始 Dio 实例，以备特殊需求（如下载文件）
  Dio get dioInstance => _dio;
}

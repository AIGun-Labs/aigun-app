import 'package:dio/dio.dart';
import 'package:flutter_aigun/config/env/env.dart';
import 'package:flutter_aigun/data/services/index.dart';

/// 网络请求客户端
class DioClient {
  final Dio _dio;
  bool _isInitialized = false;

  /// 默认配置
  final BaseOptions _defaultOptions = BaseOptions(
    baseUrl: EnvConfig().baseApiUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 10),
    validateStatus: (status) => status != null && status >= 200 && status < 300,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  DioClient() : _dio = Dio();

  /// 初始化客户端
  void init() {
    if (_isInitialized) return;
    _dio.options = _defaultOptions;
    DioInterceptors().init(_dio);
    _isInitialized = true;
  }

  /// 通用请求方法
  Future<Response<T>> _request<T>(
    String path,
    String method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.request<T>(
        '${EnvConfig().baseApiUrl}$path',
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(method: method),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /// GET 请求
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final response = await _request<T>(
      path,
      'GET',
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data as T;
  }

  /// POST 请求
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final response = await _request<T>(
      path,
      'POST',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// PUT 请求
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) =>
      _request<T>(
        path,
        'PUT',
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  /// DELETE 请求
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _request<T>(
        path,
        'DELETE',
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

  /// 获取 Dio 实例
  Dio get dio => _dio;
}

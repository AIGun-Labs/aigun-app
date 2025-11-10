import 'package:dio/dio.dart';
import 'package:flutter_aigun/config/env/env.dart';
import 'package:flutter_aigun/core/enums/request_methods.dart';
import 'package:flutter_aigun/data/services/index.dart';

/// Network client for API requests with retry logic and interceptors
class DioClient {
  final Dio _dio;
  bool _isInitialized = false;

  /// Default configuration for Dio client
  final BaseOptions _defaultOptions = BaseOptions(
    baseUrl: EnvConfig().baseApiUrl,
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 8),
    sendTimeout: const Duration(seconds: 10),
    validateStatus: (status) => status != null && status >= 200 && status < 300,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );

  DioClient() : _dio = Dio();

  /// Initialize Dio with default settings and interceptors
  void init() {
    if (_isInitialized) return;
    _dio.options = _defaultOptions;
    DioInterceptors().init(_dio); // Setup interceptors
    _isInitialized = true;
  }

  /// Generic request method
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

  /// GET request method
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final response = await _request<T>(
      path,
      RequestMethods.get.value,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data as T;
  }

  /// POST request method
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
      RequestMethods.post.value,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data as T;
  }

  /// PUT request method
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
        RequestMethods.put.value,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  /// DELETE request method
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _request<T>(
        path,
        RequestMethods.delete.value,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

  /// Get the Dio instance
  Dio get dio => _dio;
}

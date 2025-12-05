import 'package:dio/dio.dart';

import '../../../core/network/gatekeeper/gate_keeper_service.dart';
import '../../../core/network/interceptors/gate_interceptor.dart';
import '../../../core/service_locator.dart';
import '../../../utils/storage/secure/token_storage_service.dart';
import '../index.dart';
import 'interceptors/api_interceptor.dart';
import 'interceptors/business_interceptor.dart';
import 'interceptors/refresh_interceptor.dart';

/// Network client for API requests with retry logic and interceptors
class DioClient {
  late final Dio _dio;

  final GateKeeperService _gatekeeper;

  DioClient(this._gatekeeper, {required String baseUrl}) {
    /// Default configuration for Dio client
    final BaseOptions defaultOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      validateStatus: (status) =>
          status != null && status >= 200 && status < 300,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    _dio = Dio(defaultOptions);

    _dio.interceptors.addAll([
      GateInterceptor(_gatekeeper),
      ApiInterceptor(_dio),
      BusinessInterceptor(),
      _createRetryInterceptor(),
      // _createRefreshInterceptor(getIt<TokenStorageService>()),
    ]);
  }

  /// Initialize refresh interceptor (call after TokenStorageService is registered)
  void initRefreshInterceptor(TokenStorageService tokenStorageService) {
    _dio.interceptors.add(
      RefreshInterceptor(
        dio: _dio,
        refreshUrl: '/refresh',
        tokenStorageService: tokenStorageService,
      ),
    );
  }

  Interceptor _createRetryInterceptor() {
    return QueuedInterceptorsWrapper(
      onError: (error, handler) async {
        final errorHandler = getIt<ErrorHandler>();

        if (errorHandler.shouldRetry(error)) {
          return await errorHandler.retry(error, handler);
        }

        handler.next(error);
      },
    );
  }

  // Interceptor _createRefreshInterceptor(
  //     TokenStorageService tokenStorageService) {
  //   return RefreshInterceptor(
  //     dio: _dio,
  //     refreshUrl: '/refresh',
  //     tokenStorageService: tokenStorageService,
  //   );
  // }

  /// GET request method
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as T;
    } catch (_) {
      rethrow;
    }
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
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as T;
    } catch (_) {
      rethrow;
    }
  }

  /// PUT request method
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as T;
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request method
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } catch (e) {
      rethrow;
    }
  }

  /// Get the Dio instance
  Dio get dioInstance => _dio;
}

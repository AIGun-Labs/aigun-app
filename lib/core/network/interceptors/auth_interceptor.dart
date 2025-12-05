import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../config/app_config.dart';
import '../../constant/storage_keys.dart';

class _PendingRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;

  _PendingRequest(this.options, this.handler);
}

const String kContentTypeJson = 'application/json';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _dio;

  bool _isRefreshing = false;

  late final Dio _tokenRefreshDio;

  final List<_PendingRequest> _pendingRequests = [];

  AuthInterceptor(this._storage, this._dio) {
    _tokenRefreshDio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseApiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': kContentTypeJson,

          // 'x-api-key': env.apiKey,
        },
      ),
    );
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.read(key: StorageKeys.accessToken);

    if (token != null && token.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('/refresh')) {
      if (_isRefreshing) {
        _pendingRequests.add(_PendingRequest(err.requestOptions, handler));
        return;
      }

      _isRefreshing = true;

      try {
        final newAccessToken = await _refreshTokenWithRetry();

        await _storage.write(
          key: StorageKeys.accessToken,
          value: newAccessToken,
        );

        _retryRequest(err.requestOptions, handler, newAccessToken);

        for (var pending in _pendingRequests) {
          _retryRequest(pending.options, pending.handler, newAccessToken);
        }
      } catch (e) {
        _handleRefreshFailure(e, err, handler);
      } finally {
        _isRefreshing = false;
        _pendingRequests.clear();
      }
    } else {
      super.onError(err, handler);
    }
  }

  Future<String> _refreshTokenWithRetry({int maxRetries = 2}) async {
    final refreshToken = await _storage.read(key: StorageKeys.refreshToken);

    if (refreshToken == null || refreshToken.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: '/refresh'),
        type: DioExceptionType.cancel,
        error: 'No refresh token found',
      );
    }

    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        final response = await _tokenRefreshDio.post(
          '/refresh',
          options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
        );

        final newAccessToken = response.data['access_token'];

        return newAccessToken;
      } catch (e) {
        if (attempt == maxRetries ||
            (e is DioException &&
                (e.response?.statusCode == 401 ||
                    e.response?.statusCode == 403))) {
          rethrow;
        }

        final delay = Duration(seconds: 1 << attempt);
        await Future.delayed(delay);
      }
    }
    throw Exception('Token refresh failed');
  }

  Future<void> _retryRequest(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
    String newToken,
  ) async {
    requestOptions.headers['Authorization'] = 'Bearer $newToken';

    try {
      final response = await _dio.fetch(requestOptions);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  Future<void> _handleRefreshFailure(
    dynamic error,
    DioException originalError,
    ErrorInterceptorHandler handler,
  ) async {
    bool shouldLogout = true;

    if (error is DioException) {
      final type = error.type;

      if (type == DioExceptionType.connectionTimeout ||
          type == DioExceptionType.sendTimeout ||
          type == DioExceptionType.receiveTimeout ||
          type == DioExceptionType.connectionError ||
          type == DioExceptionType.unknown) {
        shouldLogout = false;
      }

      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        if (statusCode == 401 || statusCode == 403) {
          shouldLogout = true;
        } else if (statusCode >= 500) {
          shouldLogout = false;
        }
      }
    }

    if (shouldLogout) {
      await _storage.delete(key: StorageKeys.accessToken);
      await _storage.delete(key: StorageKeys.refreshToken);
    }

    handler.reject(originalError);

    for (var pending in _pendingRequests) {
      pending.handler.reject(originalError);
    }
  }
}

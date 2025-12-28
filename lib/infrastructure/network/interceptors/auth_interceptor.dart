import 'package:dio/dio.dart';

import '../../../config/app_config.dart';
import '../../../shared/presentation/cubits/new_user/new_user_cubit.dart';

class _PendingRequest {
  _PendingRequest(this.options, this.handler);
  final RequestOptions options;
  final ErrorInterceptorHandler handler;
}

const String kContentTypeJson = 'application/json';

const String kRefreshUrl = '/api/v1/intel-user/refresh';

const String kAuthorizationHeader = 'Authorization';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._userCubit, this._dio) {
    final env = AppConfig().env;
    _tokenRefreshDio = Dio(
      BaseOptions(
        baseUrl: env.baseApiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': kContentTypeJson,
          // 'x-api-key': env.apiKey,
        },
      ),
    );
  }
  final NewUserCubit _userCubit;
  final Dio _dio; //  Dio ，
  bool _isRefreshing = false;
  late final Dio _tokenRefreshDio;
  final List<_PendingRequest> _pendingRequests = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _userCubit.state.tokens?.access;
    if (token != null && token.isNotEmpty) {
      options.headers.putIfAbsent(kAuthorizationHeader, () => 'Bearer $token');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains(kRefreshUrl)) {
      if (_isRefreshing) {
        _pendingRequests.add(_PendingRequest(err.requestOptions, handler));
        return;
      }

      _isRefreshing = true;

      try {
        final newAccessToken = await _refreshTokenWithRetry();
        await _userCubit.saveTokens(access: newAccessToken);
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
    final refreshToken = _userCubit.state.tokens?.refresh;

    if (refreshToken == null || refreshToken.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: kRefreshUrl),
        type: DioExceptionType.cancel,
        error: 'No refresh token found',
      );
    }
    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        final response = await _tokenRefreshDio.post(
          kRefreshUrl,
          data: {'refresh_token': refreshToken},
        );
        final newAccessToken = response.data['access_token'];

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          return newAccessToken;
        }
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
        if (statusCode == 401) {
          shouldLogout = true;
        } else if (statusCode >= 500) {
          shouldLogout = false;
        }
      }
    }

    if (shouldLogout) {
      await _userCubit.deleteTokens();
    }
    handler.reject(originalError);
    for (var pending in _pendingRequests) {
      pending.handler.reject(originalError);
    }
  }
}

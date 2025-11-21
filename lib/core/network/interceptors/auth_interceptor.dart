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
  final Dio _dio; // 主 Dio 实例，用于重试原请求

  // 互斥锁：是否正在刷新
  bool _isRefreshing = false;

  // 专门用于刷新 Token 的 Dio 实例（无拦截器，防止死锁）
  late final Dio _tokenRefreshDio;

// 挂起请求队列
  final List<_PendingRequest> _pendingRequests = [];

  AuthInterceptor(this._storage, this._dio) {
// 初始化一个干净的 Dio，仅用于 Refresh Token
    // 读取当前的 BaseUrl
    final env = AppConfig().env;
    _tokenRefreshDio = Dio(BaseOptions(
      baseUrl: env.baseApiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': kContentTypeJson,
        // 如果刷新 Token 需要 API Key，这里也要加上
        // 'x-api-key': env.apiKey,
      },
    ));
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. 获取 Token
    final token = await _storage.read(key: StorageKeys.accessToken);

    // 2. 如果 Token 存在且请求头未包含 Authorization，则注入
    if (token != null && token.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 1. 判断是否为 401 且不是刷新接口本身的错误
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains('/refresh')) {
      // 2. 如果正在刷新，将当前请求加入队列
      if (_isRefreshing) {
        _pendingRequests.add(_PendingRequest(err.requestOptions, handler));
        return;
      }

      _isRefreshing = true;

      try {
        // 3. 执行刷新逻辑
        final newAccessToken = await _refreshTokenWithRetry();

        // 4. 刷新成功：保存新 Token
        await _storage.write(
            key: StorageKeys.accessToken, value: newAccessToken);

        // 5. 重试【当前失败】的请求
        _retryRequest(err.requestOptions, handler, newAccessToken);

        // 6. 重试【队列中】的所有请求
        for (var pending in _pendingRequests) {
          _retryRequest(pending.options, pending.handler, newAccessToken);
        }
      } catch (e) {
        // 7. 刷新失败处理
        _handleRefreshFailure(e, err, handler);
      } finally {
        // 8. 清理状态
        _isRefreshing = false;
        _pendingRequests.clear();
      }
    } else {
      super.onError(err, handler);
    }
  }

  /// 刷新 Token，带指数退避重试机制
  Future<String> _refreshTokenWithRetry({int maxRetries = 2}) async {
    final refreshToken = await _storage.read(key: StorageKeys.refreshToken);

    if (refreshToken == null || refreshToken.isEmpty) {
      throw DioException(
          requestOptions: RequestOptions(path: '/refresh'),
          type: DioExceptionType.cancel,
          error: 'No refresh token found');
    }

    //指数退避重试
    for (int attempt = 0; attempt <= maxRetries; attempt++) {
      try {
        //使用 _tokenRefreshDio 发送请求，避开拦截器
        final response = await _tokenRefreshDio.post('/refresh',
            options: Options(
              headers: {
                'Authorization': 'Bearer $refreshToken',
              },
            ));
        //根据后端的结构对应修改
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

  /// 辅助方法：使用新 Token 重试请求
  Future<void> _retryRequest(RequestOptions requestOptions,
      ErrorInterceptorHandler handler, String newToken) async {
    // 更新 Token
    requestOptions.headers['Authorization'] = 'Bearer $newToken';

    try {
      // 使用主 Dio 实例重发请求
      // 注意：这里必须创建一个新的 Options，避免引用问题
      final response = await _dio.fetch(requestOptions);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  /// 核心逻辑：处理刷新失败（区分网络错误 vs 认证失效）
  Future<void> _handleRefreshFailure(dynamic error, DioException originalError,
      ErrorInterceptorHandler handler) async {
    bool shouldLogout = true;

    if (error is DioException) {
      final type = error.type;
      // 如果是网络连接层面的问题，不应该登出
      if (type == DioExceptionType.connectionTimeout ||
          type == DioExceptionType.sendTimeout ||
          type == DioExceptionType.receiveTimeout ||
          type == DioExceptionType.connectionError ||
          type == DioExceptionType.unknown) {
        shouldLogout = false;
      }

      // 如果后端明确返回 4xx/5xx，检查状态码
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        // 只有 401 (未授权) 或 403 (禁止) 才代表 Refresh Token 也失效了
        if (statusCode == 401 || statusCode == 403) {
          shouldLogout = true;
        } else if (statusCode >= 500) {
          // 服务器炸了，不应该让用户重新登录
          shouldLogout = false;
        }
      }
    }

    if (shouldLogout) {
      // 清除本地所有 Token
      await _storage.delete(key: StorageKeys.accessToken);
      await _storage.delete(key: StorageKeys.refreshToken);
      // 这里可以使用 EventBus 通知 UI 层跳转登录页，或者抛出特定异常
    }

    // 拒绝当前请求
    handler.reject(originalError);

    // 拒绝队列中的所有请求
    for (var pending in _pendingRequests) {
      pending.handler.reject(originalError);
    }
  }
}

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
}

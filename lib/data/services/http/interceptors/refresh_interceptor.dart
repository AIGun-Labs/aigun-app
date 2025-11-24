import 'package:dio/dio.dart';

import '../../../../utils/storage/secure/token_storage_service.dart';

class RefreshInterceptor extends Interceptor {
  RefreshInterceptor({
    required Dio dio,
    required String refreshUrl,
    required TokenStorageService tokenStorageService,
  })  : _dio = dio,
        _tokenStorageService = tokenStorageService,
        _refreshUrl = refreshUrl;

  final Dio _dio;
  final TokenStorageService _tokenStorageService;
  final String _refreshUrl;

  bool _isRefreshCall(RequestOptions options) {
    return options.path.contains(_refreshUrl) ||
        options.extra['refresh'] == true;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode ?? 0;

    final req = err.requestOptions;

// 如果请求状态码不是401，或者请求是刷新请求，或者请求已经重试过，则直接返回
    if (statusCode != 401 ||
        _isRefreshCall(req) ||
        req.extra['__retried'] == true) {
      return handler.next(err);
    }

    try {
      final refresh = await _tokenStorageService.getRefreshToken();
      if (refresh == null || refresh.isEmpty) {
        handler.next(err);
        return;
      }

      // 1) 刷新 token
      final refreshResp = await _dio.post<Map<String, dynamic>>(
        _refreshUrl,
        data: {'refresh_token': refresh},
        options: Options(extra: const {'skipAuth': true}), // 避免被再次拦截
      );
      final data = refreshResp.data ?? const {};
      final newAccess = (data['access_token'] as String?) ?? '';
      // final newRefresh = (data['refresh_token'] as String?) ?? refresh;
      if (newAccess.isEmpty) {
        handler.next(err);
        return;
      }
      await _tokenStorageService.saveAccessToken(
        newAccess,
      );

      // 2) 带新 token 重试原请求（只重试一次）
      final newHeaders = Map<String, dynamic>.from(req.headers);
      newHeaders['Authorization'] = 'Bearer $newAccess';

      final newExtra = Map<String, dynamic>.from(req.extra);
      newExtra['__retried'] = true;

      final retryResp = await _dio.request<dynamic>(
        req.path,
        data: req.data,
        queryParameters: req.queryParameters,
        options: Options(
          method: req.method,
          headers: newHeaders,
          responseType: req.responseType,
          contentType: req.contentType,
          followRedirects: req.followRedirects,
          receiveDataWhenStatusError: req.receiveDataWhenStatusError,
          validateStatus: req.validateStatus,
          sendTimeout: req.sendTimeout,
          receiveTimeout: req.receiveTimeout,
          extra: newExtra,
        ),
        cancelToken: req.cancelToken,
        onSendProgress: req.onSendProgress,
        onReceiveProgress: req.onReceiveProgress,
      );

      return handler.resolve(retryResp);
    } catch (_) {
      // 刷新或重试失败，交回给调用方处理（比如跳登录）
      return handler.next(err);
    }
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isRefreshCall(options)) {
      handler.next(options);
      return;
    }
    final access = await _tokenStorageService.getAccessToken();
    if (access != null && access.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $access';
    }
    handler.next(options);
  }
}

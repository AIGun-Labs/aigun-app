import 'package:dio/dio.dart';
import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/services/api/auth_api.dart';
import 'package:flutter_aigun/utils/storage/secure/token_storage_service.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;
  final List<ErrorInterceptorHandler> _subscribers = [];

  ApiInterceptor(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// 添加 token 请求头
    final accessToken = await getIt<TokenStorageService>().getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains("/refresh")) {
      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          final newAccessToken = await _refreshToken();

          await getIt<TokenStorageService>().saveAccessToken(newAccessToken);

          err.requestOptions.headers["Authorization"] =
              "Bearer $newAccessToken";

          final response = await dio.fetch(err.requestOptions);

          handler.resolve(response);

          return handler.resolve(response);
        } catch (e) {
          await getIt<TokenStorageService>().deleteTokens();

          handler.reject(err);

          for (var subscriber in _subscribers) {
            subscriber.reject(err);
          }

          _subscribers.clear();
        }
      } else {
        _subscribers.add(handler);
      }
    } else {
      return super.onError(err, handler);
    }
  }

  Future<String> _refreshToken() async {
    final refreshToken = await getIt<TokenStorageService>().getRefreshToken();
    if (refreshToken == null) {
      throw DioException(
        requestOptions: RequestOptions(path: "/refresh"),
        response: Response(requestOptions: RequestOptions(path: "/refresh")),
      );
    }

    final newAccessToken = await getIt<AuthApi>().refreshToken();

    await getIt<TokenStorageService>()
        .saveAccessToken(newAccessToken.accessToken);

    return newAccessToken.accessToken;
  }
}

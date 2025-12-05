import 'package:dio/dio.dart';

import '../../../../core/service_locator.dart';
import '../../../../utils/storage/secure/token_storage_service.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  // final bool _isRefreshing = false;
  // final List<ErrorInterceptorHandler> _subscribers = [];

  ApiInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await getIt<TokenStorageService>().getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  //   @override
  //   void onError(DioException err, ErrorInterceptorHandler handler) async {
  //     if (err.response?.statusCode == 401 &&
  //         !err.requestOptions.path.contains("/refresh")) {
  //       if (!_isRefreshing) {
  //         _isRefreshing = true;

  //         try {
  //           final newAccessToken = await _refreshToken();

  //           await getIt<TokenStorageService>().saveAccessToken(newAccessToken);

  //           err.requestOptions.headers["Authorization"] =
  //               "Bearer $newAccessToken";

  //           final response = await dio.fetch(err.requestOptions);

  //           handler.resolve(response);

  //           return handler.resolve(response);
  //         } catch (e) {

  //           bool shouldDeleteTokens = true;

  //           if (e is DioException) {
  //             final errorType = e.type;

  //             if (errorType == DioExceptionType.connectionTimeout ||
  //                 errorType == DioExceptionType.sendTimeout ||
  //                 errorType == DioExceptionType.receiveTimeout ||
  //                 errorType == DioExceptionType.connectionError ||
  //                 errorType == DioExceptionType.unknown) {
  //               shouldDeleteTokens = false;
  //             }

  //             final statusCode = e.response?.statusCode;
  //             if (statusCode != null) {

  //               if (statusCode == 401 || statusCode == 403) {
  //                 shouldDeleteTokens = true;
  //               }

  //               else if (statusCode >= 400) {
  //                 shouldDeleteTokens = false;
  //               }
  //             }
  //           }

  //           if (shouldDeleteTokens) {
  //             await getIt<TokenStorageService>().deleteTokens();
  //           }

  //           handler.reject(err);

  //           for (var subscriber in _subscribers) {
  //             subscriber.reject(err);
  //           }

  //           _subscribers.clear();
  //         } finally {
  //           _isRefreshing = false;
  //         }
  //       } else {
  //         _subscribers.add(handler);
  //       }
  //     } else {
  // // SentryService().reportRequestError(exception, stackTrace)
  //       return super.onError(err, handler);
  //     }
  //   }

  //   Future<String> _refreshToken({int retryCount = 2}) async {
  //     final refreshToken = await getIt<TokenStorageService>().getRefreshToken();
  //     if (refreshToken == null) {
  //       throw DioException(
  //         requestOptions: RequestOptions(path: "/refresh"),
  //         response: Response(requestOptions: RequestOptions(path: "/refresh")),
  //       );
  //     }

  //     for (int attempt = 0; attempt <= retryCount; attempt++) {
  //       try {
  //         final newAccessToken = await getIt<AuthApi>().refreshToken();

  //         await getIt<TokenStorageService>()
  //             .saveAccessToken(newAccessToken.accessToken);

  //         return newAccessToken.accessToken;
  //       } catch (e) {

  //         if (attempt == retryCount) {
  //           rethrow;
  //         }

  //         final delaySeconds = 1 << attempt; // 2^attempt
  //         await Future.delayed(Duration(seconds: delaySeconds));
  //       }
  //     }

  //     throw Exception('Token refresh failed after $retryCount retries');
  //   }
}

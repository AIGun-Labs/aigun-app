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
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// 添加 token 请求头
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
//           // 区分网络错误和认证失败
//           bool shouldDeleteTokens = true;

//           if (e is DioException) {
//             final errorType = e.type;

//             // 网络错误（超时、连接失败等）不删除 Token，让用户稍后重试
//             if (errorType == DioExceptionType.connectionTimeout ||
//                 errorType == DioExceptionType.sendTimeout ||
//                 errorType == DioExceptionType.receiveTimeout ||
//                 errorType == DioExceptionType.connectionError ||
//                 errorType == DioExceptionType.unknown) {
//               shouldDeleteTokens = false;
//             }

//             // 检查响应状态码：只有真正的认证失败才删除 Token
//             final statusCode = e.response?.statusCode;
//             if (statusCode != null) {
//               // 401/403 是认证失败，删除 Token
//               if (statusCode == 401 || statusCode == 403) {
//                 shouldDeleteTokens = true;
//               }
//               // 其他 4xx/5xx 错误可能是服务器问题，不删除 Token
//               else if (statusCode >= 400) {
//                 shouldDeleteTokens = false;
//               }
//             }
//           }

//           // 只在确实需要时才删除 Token
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

//   /// 刷新 Token，带重试机制
//   /// [retryCount] 重试次数，默认为 2 次
//   Future<String> _refreshToken({int retryCount = 2}) async {
//     final refreshToken = await getIt<TokenStorageService>().getRefreshToken();
//     if (refreshToken == null) {
//       throw DioException(
//         requestOptions: RequestOptions(path: "/refresh"),
//         response: Response(requestOptions: RequestOptions(path: "/refresh")),
//       );
//     }

//     // 使用指数退避策略进行重试
//     for (int attempt = 0; attempt <= retryCount; attempt++) {
//       try {
//         final newAccessToken = await getIt<AuthApi>().refreshToken();

//         await getIt<TokenStorageService>()
//             .saveAccessToken(newAccessToken.accessToken);

//         return newAccessToken.accessToken;
//       } catch (e) {
//         // 如果是最后一次尝试，直接抛出异常
//         if (attempt == retryCount) {
//           rethrow;
//         }

//         // 指数退避：第一次重试等待 1 秒，第二次等待 2 秒
//         final delaySeconds = 1 << attempt; // 2^attempt
//         await Future.delayed(Duration(seconds: delaySeconds));
//       }
//     }

//     // 理论上不会到达这里，但为了类型安全
//     throw Exception('Token refresh failed after $retryCount retries');
//   }
}

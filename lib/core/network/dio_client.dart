import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'error/app_exception.dart';
import 'error/error_handler.dart';
import 'interceptors/auth_interceptor.dart';
import 'models/api_response.dart';

// 定义常用的 Content-Type
const String kContentTypeJson = 'application/json';

class DioClient {
  late final Dio _dio;
  final FlutterSecureStorage _storage;

  // 单例模式（可选，如果使用 GetIt 注册为 Singleton 则不需要内部单例）
  DioClient(this._storage, {required String baseUrl}) {
    // 2. 配置 BaseOptions
    final options = BaseOptions(
      baseUrl: baseUrl, // 动态获取 envied 中的 URL
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': kContentTypeJson,
        'Accept': kContentTypeJson,
        // 如果有 API Key 需求
        // 'x-api-key': env.apiKey,
      },
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    // 3. 添加拦截器
    _dio.interceptors.addAll([
      //处理 Token 注入和 401 刷新
      AuthInterceptor(_storage, _dio),

      //处理网络超时、500 服务器错误等
      RetryInterceptor(
        dio: _dio, //dio 实例
      ),

      // 开发环境打印日志，生产环境建议关闭或使用精简版
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print('📡 $obj'), // 建议换成 logger 库
      ),
    ]);
  }

  /// 核心处理方法 (私有)
  /// 1. 执行请求
  /// 2. 解析 ApiResponse
  /// 3. 校验 code
  /// 4. 返回 data
  Future<dynamic> _request(Future<Response> Function() request) async {
    try {
      final response = await request();

      // 1. 解析外层结构 ApiResponse<T>
      // 注意：这里把 response.data 传进去，利用泛型工厂解析
      final apiResponse = ApiResponse<Object?>.fromJson(
        response.data,
        (json) => json,
      );

      // 2. 业务逻辑校验拦截
      if (!apiResponse.isSuccess) {
        throw BusinessException(
            message: apiResponse.msg, code: apiResponse.code);
      }

      // 3. 返回剥壳后的 data (可能是 Map, List 或 null)
      return apiResponse.data;
    } catch (e) {
      // 这里的 ErrorHandler 需要兼容处理 BusinessException
      throw ErrorHandler.handle(e);
    }
  }

  // --- 封装常用方法 ---

  /// GET 请求
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// POST 请求
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// PUT 请求
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  /// DELETE 请求
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }

  // 暴露原始 Dio 实例，以备特殊需求（如下载文件）
  Dio get dioInstance => _dio;
}

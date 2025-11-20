import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 引入我们之前做好的 Config
import '../../config/app_config.dart';
import 'error/error_handler.dart';
import 'interceptors/auth_interceptor.dart';

// 定义常用的 Content-Type
const String kContentTypeJson = 'application/json';

class DioClient {
  late final Dio _dio;
  final FlutterSecureStorage _storage;

  // 单例模式（可选，如果使用 GetIt 注册为 Singleton 则不需要内部单例）
  DioClient(this._storage) {
    // 1. 获取当前环境配置
    final env = AppConfig().env;

    // 2. 配置 BaseOptions
    final options = BaseOptions(
      baseUrl: env.baseApiUrl, // 动态获取 envied 中的 URL
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
      AuthInterceptor(_storage, _dio),
      // 开发环境打印日志，生产环境建议关闭或使用精简版
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print('📡 $obj'), // 建议换成 logger 库
      ),
    ]);
  }

  // --- 封装常用方法 ---

  /// GET 请求
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  /// POST 请求
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  /// PUT 请求
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  /// DELETE 请求
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
      throw ErrorHandler.handle(e);
    }
  }

  // 暴露原始 Dio 实例，以备特殊需求（如下载文件）
  Dio get dioInstance => _dio;
}

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'error/app_exception.dart';
import 'error/error_handler.dart';
import 'gatekeeper/gate_keeper_service.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/gate_interceptor.dart';
import 'models/api_response.dart';

const String kContentTypeJson = 'application/json';

class NewDioClient {
  late final Dio _dio;
  final FlutterSecureStorage _storage;
  final GateKeeperService _gatekeeper;

  NewDioClient(this._storage, this._gatekeeper, {required String baseUrl}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': kContentTypeJson,
        'Accept': kContentTypeJson,

        // 'x-api-key': env.apiKey,
      },
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    _dio.interceptors.addAll([
      GateInterceptor(_gatekeeper),

      AuthInterceptor(_storage, _dio),

      RetryInterceptor(dio: _dio),

      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print('📡 $obj'),
      ),
    ]);
  }

  Future<dynamic> _request(Future<Response> Function() request) async {
    try {
      final response = await request();

      final apiResponse = ApiResponse<dynamic>.fromJson(
        response.data,
        (json) => json,
      );

      if (!apiResponse.isSuccess) {
        throw BusinessException(
          message: apiResponse.msg,
          code: apiResponse.code,
        );
      }

      return apiResponse.data;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(
      () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(
      () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(
      () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Dio get dioInstance => _dio;
}

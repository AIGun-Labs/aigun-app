import 'package:dio/dio.dart';

import '../../domain/anti_spider/anti_spider_service.dart';

abstract class ClientIpProvider {
  Future<String> getClientIp();
}

class AntiSpiderInterceptor extends Interceptor {
  // final ClientIpProvider clientIpProvider;

  AntiSpiderInterceptor({
    required this.keyService,
    // required this.clientIpProvider,
  });
  final AntiSpiderKeyService keyService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final headerMap = <String, String>{};

      options.headers.forEach((key, value) {
        if (value != null) {
          headerMap[key.toString()] = value.toString();
        }
      });

      // final clientIp = await clientIpProvider.getClientIp();

      final key = await keyService.generateKey(
        interfacePath: options.path,
        headers: headerMap,
        // clientIp: clientIp,
      );

      options.headers.putIfAbsent('x-data-key', key.toString);

      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          error: e,
        ),
      );
    }
  }
}

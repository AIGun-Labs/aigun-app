import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../data/models/queued_request/queued_request.dart';
import '../../utils/logger.dart';

class OfflineQueueManager {
  final Dio dio;
  final Box<QueuedRequest> _box;
  bool isConnected = true;

  OfflineQueueManager({required this.dio, required Box<QueuedRequest> box})
      : _box = box;

  void addToQueue(QueuedRequest request) {
    _box.add(request);
    Logger.info('Request queued: ${request.path}');
  }

  Future<void> retryAll() async {
    final List<QueuedRequest> pending = _box.values.toList();
    await _box.clear();

    for (final req in pending) {
      try {
        await dio.request(
          req.path,
          data: req.data,
          queryParameters: req.queryParameters,
          options: Options(method: req.method, headers: req.headers),
        );
        Logger.info('Retried: ${req.path}');
      } catch (e) {
        Logger.error('Retry failed: ${req.path}');
        _box.add(req); // Re-queue failed
      }
    }
  }
}

class OfflineQueueInterceptor extends Interceptor {
  final OfflineQueueManager manager;

  OfflineQueueInterceptor({required this.manager});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!manager.isConnected) {
      manager.addToQueue(QueuedRequest(
          method: options.method,
          path: options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          headers: options.headers));

      handler.reject(DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: "No Nework, request queued"));
    } else {
      handler.next(options);
    }
  }
}

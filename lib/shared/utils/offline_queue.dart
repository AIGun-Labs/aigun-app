import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../data/models/queued_request/queued_request.dart';
import '../../data/services/http/dio_client.dart';
import '../../utils/logger.dart';

class OfflineQueueManager {
  final DioClient _dioClient;
  final Box<QueuedRequest> _box;
  bool isConnected = true;

  OfflineQueueManager(this._dioClient, this._box);

  void addToQueue(QueuedRequest request) {
    _box.add(request);
    Logger.info('Request queued: ${request.path}');
  }

  Future<void> retryAll() async {
    final List<QueuedRequest> pending = _box.values.toList();
    await _box.clear();

    for (final req in pending) {
      try {
        await _dioClient.dioInstance.request(
          req.path,
          data: req.data,
          queryParameters: req.queryParameters,
          options: Options(method: req.method, headers: req.headers),
        );
        Logger.info('Retried: ${req.path}');
      } catch (e) {
        Logger.error('Retry failed: ${req.path}');
        // _box.add(req); // Re-queue failed
        _box.add(QueuedRequest(
            method: req.method,
            path: req.path,
            data: req.data,
            queryParameters: req.queryParameters,
            headers: req.headers));
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
          error: 'No Nework, request queued'));
    } else {
      handler.next(options);
    }
  }
}

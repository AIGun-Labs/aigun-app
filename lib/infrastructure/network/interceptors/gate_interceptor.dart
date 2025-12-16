import 'package:dio/dio.dart';

import '../../../core/services/gate_keeper_service.dart';

class GateInterceptor extends Interceptor {
  GateInterceptor(this._gatekeeper);
  final GateKeeperService _gatekeeper;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_gatekeeper.isServiceAvailable) {
      _gatekeeper.addPendingRequest(options, handler);
      return;
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _gatekeeper.notifyRequestSucceeded(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _gatekeeper.notifyRequestFailed(err);
    handler.next(err);
  }
}

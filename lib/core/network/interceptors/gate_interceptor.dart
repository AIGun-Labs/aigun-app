import 'package:dio/dio.dart';

import '../gatekeeper/gate_keeper_service.dart';

class GateInterceptor extends Interceptor {
  final GateKeeperService _gatekeeper;

  GateInterceptor(this._gatekeeper);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_gatekeeper.isServiceAvailable) {
      handler.next(options);
    } else {
      _gatekeeper.addPendingRequest(options, handler);
    }
  }
}

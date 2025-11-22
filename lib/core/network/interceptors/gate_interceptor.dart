import 'package:dio/dio.dart';

import '../gateKeeper/service_gateKeeper.dart';

class GateInterceptor extends Interceptor {
  final ServiceGatekeeper _gatekeeper;

  GateInterceptor(this._gatekeeper);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 2. 检查系统状态
    if (_gatekeeper.isServiceAvailable) {
      // ✅ 系统正常，放行
      handler.next(options);
    } else {
      // ⛔️ 系统不可用，挂起请求（不要调用 handler.next/resolve/reject）
      _gatekeeper.addPendingRequest(options, handler);
    }
  }
}

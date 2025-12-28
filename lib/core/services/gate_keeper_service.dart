// ...existing code...
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract interface class GateKeeperService {
  ValueNotifier<bool> get isServiceLockedNotifier;
  bool get isBackendHealthy;
  bool get isDeviceOnline;
  bool get isServiceAvailable;
  void addPendingRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  );
  void notifyRequestSucceeded(Response response);
  void notifyRequestFailed(DioException err);
  void lockService();
  void dispose();
}

// ...existing code...
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// GateKeeper 服务接口，封装网络/后端可用性检查与挂起请求的管理。
abstract interface class GateKeeperService {
  /// UI 层监听：true = 锁定/不可用，false = 可用
  ValueNotifier<bool> get isServiceLockedNotifier;

  /// 后端是否健康
  bool get isBackendHealthy;

  /// 设备是否有网络
  bool get isDeviceOnline;

  /// 整体服务是否可用（后端健康且设备在线）
  bool get isServiceAvailable;

  /// 将一个正在进行的请求加入挂起队列（Request 拦截器使用）
  void addPendingRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  );

  /// 通知请求成功
  void notifyRequestSucceeded(Response response);

  /// 通知请求失败
  void notifyRequestFailed(DioException err);

  /// 手动锁定服务（例如遇到 503 时调用）
  void lockService();

  /// 释放资源
  void dispose();
}

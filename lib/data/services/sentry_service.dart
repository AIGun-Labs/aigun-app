import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// 一个 Sentry 服务的封装类，用于提供统一的错误报告接口。
/// 使用单例模式确保全局只有一个实例。
class SentryService {
  // --- 单例模式设置 ---
  SentryService._internal();
  static final SentryService _instance = SentryService._internal();
  factory SentryService() => _instance;

  /// --- 1. 初始化方法 ---
  /// 在 main.dart 中调用此方法来初始化 Sentry。
  static Future<void> init(
    FutureOr<void> Function() appRunner, {
    required String dsn,
    String? environment,
  }) async {
    await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
        // Adds request headers and IP for users, for more info visit:
        // https://docs.sentry.io/platforms/dart/guides/flutter/data-management/data-collected/
        options.sendDefaultPii = true;
        // options.enableLogs = true;
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        options.profilesSampleRate = 1.0;
        // Configure Session Replay
        // options.replay.sessionSampleRate = 0.1;
        // options.replay.onErrorSampleRate = 1.0;
        options.environment = kDebugMode ? 'development' : 'production';
      },
      appRunner: appRunner,
    );
  }

  Future<void> reportRequestError(
    dynamic exception,
    StackTrace? stackTrace, {
    Map<String, String>? tags,
    dynamic code,
    dynamic message,
  }) async {
    await reportError(exception, stackTrace,
        tags: tags, extra: {"code": code, "message": message});
  }

  /// --- 2. 核心错误报告方法 ---
  ///
  /// 上报一个捕获到的异常。
  /// [exception]: 异常对象。
  /// [stackTrace]: 堆栈跟踪。
  /// [tags]: 自定义标签，用于分类和过滤。
  /// [extra]: 附加的上下文数据，用于调试。
  Future<void> reportError(
    dynamic exception,
    StackTrace? stackTrace, {
    Map<String, String>? tags,
    Map<String, dynamic>? extra,
  }) async {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      withScope: (scope) {
        // 添加全局不会改变的标签
        scope.setTag('platform', defaultTargetPlatform.name);

        // 添加本次上报的特定标签
        if (tags != null) {
          tags.forEach((key, value) {
            scope.setTag(key, value);
          });
        }

        // 添加本次上报的特定附加数据
        if (extra != null) {
          extra.forEach((key, value) {
            scope.setExtra(key, value);
          });
        }
      },
    );
  }

  /// --- 3. 用户管理 ---
  ///
  /// 在用户登录后设置用户信息。
  void setUser({
    required String id,
    String? email,
    String? username,
    Map<String, dynamic>? data,
  }) {
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(
        id: id,
        email: email,
        username: username,
        data: data,
      ));
    });
  }

  /// 在用户登出后清除用户信息。
  void clearUser() {
    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }

  /// --- 4. 面包屑 (Breadcrumbs) ---
  ///
  /// 添加一个面包屑来记录用户的操作路径。
  void addBreadcrumb(
    String message, {
    String category = 'log',
    SentryLevel level = SentryLevel.info,
  }) {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: message,
        category: category,
        level: level,
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService {
  SentryService._internal();
  static final SentryService _instance = SentryService._internal();
  factory SentryService() => _instance;
  static Future<void> init(
    FutureOr<void> Function() appRunner, {
    required String dsn,
    String? environment,
  }) async {
    await SentryFlutter.init((options) {
      options.dsn = dsn;
      // Adds request headers and IP for users, for more info visit:
      // https://docs.sentry.io/platforms/dart/guides/flutter/data-management/data-collected/
      options.sendDefaultPii = true;
      // options.enableLogs = true;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = kDebugMode ? 1.0 : 0.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = kDebugMode ? 1.0 : 0.0;
      // Configure Session Replay
      // options.replay.sessionSampleRate = 0.1;
      // options.replay.onErrorSampleRate = 1.0;
      options.environment = kDebugMode ? 'development' : 'production';
      options.debug = false;
    }, appRunner: appRunner);
  }

  Future<void> reportRequestError(
    dynamic exception,
    StackTrace? stackTrace, {
    Map<String, String>? tags,
    dynamic code,
    dynamic message,
  }) async {
    await reportError(
      exception,
      stackTrace,
      tags: tags,
      extra: {'code': code, 'message': message},
    );
  }

  ///
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
        scope.setTag('platform', defaultTargetPlatform.name);
        if (tags != null) {
          tags.forEach((key, value) {
            scope.setTag(key, value);
          });
        }
        if (extra != null) {
          extra.forEach((key, value) {
            scope.setExtra(key, value);
          });
        }
      },
    );
  }

  ///
  void setUser({
    required String id,
    String? email,
    String? username,
    Map<String, dynamic>? data,
  }) {
    Sentry.configureScope((scope) {
      scope.setUser(
        SentryUser(id: id, email: email, username: username, data: data),
      );
    });
  }

  void clearUser() {
    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }

  ///
  void addBreadcrumb(
    String message, {
    String category = 'log',
    SentryLevel level = SentryLevel.info,
  }) {
    Sentry.addBreadcrumb(
      Breadcrumb(message: message, category: category, level: level),
    );
  }
}

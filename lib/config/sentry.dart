import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_config.dart';

class SentryConfig {
  static String? _dsn;

  static Future<void> initialize(void Function() runApp) async {
    if (kDebugMode) {
      return runApp();
    }

    _dsn = AppConfig().env.sentryDsn;

    if (_dsn?.isEmpty ?? true) {
      debugPrint('Sentry DSN is empty, skipping initialization');
      return;
    }

    await SentryFlutter.init((options) {
      options
        ..dsn = _dsn
        ..environment = kDebugMode ? 'development' : 'production'
        ..tracesSampleRate = 1.0
        ..debug = kDebugMode
        ..attachStacktrace = true
        ..enableAutoSessionTracking = true
        ..autoSessionTrackingInterval = const Duration(seconds: 30)
        ..maxBreadcrumbs = 100;
    }, appRunner: runApp);
  }

  static Future<void> reportError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? hint,
    Map<String, dynamic>? extra,
  }) async {
    if (_dsn?.isEmpty ?? true) {
      debugPrint('Sentry not initialized, skipping error report');
      return;
    }

    try {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
        hint: hint != null ? Hint.withMap({'hint': hint}) : null,
        withScope: (scope) {
          if (extra != null) {
            scope.setContexts('extra_data', extra);
          }
        },
      );

      debugPrint('Error reported to Sentry');
    } catch (e) {
      debugPrint('Error reporting to Sentry: $e');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_aigun/app.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/utils/timezone_utils.dart';
import 'package:flutter_aigun/utils/image_cache_manager.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true;

  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintBaselinesEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  // 配置图片缓存
  ImageCacheManager.configureCache();

  // 初始化时区数据
  TimezoneUtils.initializeTimezone();

  // 异步初始化所有核心服务（包括 SettingsStorage 和其他异步依赖）
  await setupCoreServices();

  // 确保所有异步初始化完成后再运行应用
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://83220a9fe57fd4d8794717e665ad397d@o4509673590554624.ingest.us.sentry.io/4510152616509440';
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
    },
    appRunner: () => runApp(SentryWidget(child: const AIGunApp())),
  );
  // TODO: Remove this line after sending the first sample event to sentry.
  await Sentry.captureException(StateError('This is a sample exception.'));
}

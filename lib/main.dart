import 'package:flutter/material.dart';
import 'package:flutter_aigun/app.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
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

  SentryService.init(() => runApp(SentryWidget(child: const AIGunApp())),
      dsn:
          'https://83220a9fe57fd4d8794717e665ad397d@o4509673590554624.ingest.us.sentry.io/4510152616509440');
}

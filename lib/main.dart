import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app.dart';
import 'config/env/env.dart';
import 'core/service_locator.dart';
import 'core/time/device_timezone_resolver.dart';
import 'core/time/time_zone_store.dart';
import 'data/models/queued_request/queued_request_adapter.dart';
import 'data/services/sentry_service.dart';
import 'services/analytics/analytics_manager.dart';
import 'utils/image_cache_manager.dart';
import 'utils/region_utils.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true;

  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintBaselinesEnabled = true;

  SentryWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(QueuedRequestAdapter());

  // TODO:配置图片缓存,需要删除
  ImageCacheManager.configureCache();

  // 初始化时区数据
  TimeZoneStore.instance.init(deviceTimeZoneResolver: resolveDeviceTimeZone);

  // 初始化统计分析
  // 根据用户地区自动选择 Firebase Analytics 或友盟统计
  try {
    final bool isInChina = await RegionUtils.isUserInMainlandChina();

    if (!EnvConfig.kDebugMode) {
      await AnalyticsManager().init(isInChina: isInChina);
    }
  } catch (e) {
    // 统计初始化失败不应阻止应用启动
    debugPrint('统计分析初始化失败: $e');
  }

  // 异步初始化所有核心服务（包括 SettingsStorage 和其他异步依赖）
  await setupCoreServices();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 确保所有异步初始化完成后再运行应用
  SentryService.init(() => runApp(SentryWidget(child: const AIGunApp())),
      dsn:
          'https://83220a9fe57fd4d8794717e665ad397d@o4509673590554624.ingest.us.sentry.io/4510152616509440');
}

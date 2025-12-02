import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'config/app_config.dart';
import 'core/service_locator.dart';
import 'core/time/device_timezone_resolver.dart';
import 'core/time/time_zone_store.dart';
import 'data/services/sentry_service.dart';
import 'services/analytics/analytics_manager.dart';
import 'utils/region_utils.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required String environment,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  //初始化配置
  AppConfig().init(environment: environment);

  //初始化时区数据
  await TimeZoneStore.instance.init(
    deviceTimeZoneResolver: resolveDeviceTimeZone,
  );

  try {
    final bool isInChina = await RegionUtils.isUserInMainlandChina();

    if (!kDebugMode) {
      await AnalyticsManager().init(isInChina: isInChina);
    }
  } catch (e) {
    debugPrint('统计分析初始化失败: $e');
  }

  //异步初始化所有核心服务（包括 SettingsStorage 和其他异步依赖）
  await setupCoreServices();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  // 确保所有异步初始化完成后再运行应用
  SentryService.init(
    () async => runApp(SentryWidget(child: await builder())),
    dsn:
        'https://83220a9fe57fd4d8794717e665ad397d@o4509673590554624.ingest.us.sentry.io/4510152616509440',
  );
}

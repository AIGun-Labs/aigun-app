import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'config/app_config.dart';
import 'core/enums/environment.dart';
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
    log('onChange(${bloc.runtimeType})');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required Environment environment,
  required bool enableNetworkLog,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig().init(environment: environment);
  await TimeZoneStore.instance.init(
    deviceTimeZoneResolver: resolveDeviceTimeZone,
  );

  try {
    final bool isInChina = await RegionUtils.isUserInMainlandChina();

    if (!kDebugMode) {
      await AnalyticsManager().init(isInChina: isInChina);
    }
  } catch (e) {
    debugPrint(': $e');
  }
  await setupCoreServices(enableNetworkLog: enableNetworkLog);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();
  SentryService.init(
    () async => runApp(SentryWidget(child: await builder())),
    dsn: AppConfig().env.sentryDsn,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/service_locator.dart';
import 'core/time/device_timezone_resolver.dart';
import 'core/time/time_zone_store.dart';

Future<void> main() async {
  await TimeZoneStore.instance.init(
    deviceTimeZoneResolver: resolveDeviceTimeZone,
  );

  await setupCoreServices();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const AIGunApp());
}

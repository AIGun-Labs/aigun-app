import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/app.dart';
import 'package:flutter_aigun/config/sentry.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/utils/timezone_utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true;

  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintBaselinesEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  // 初始化时区数据
  TimezoneUtils.initializeTimezone();

  await setupCoreServices();

  // SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
  //   statusBarBrightness: Brightness.dark,
  //   systemNavigationBarColor: Colors.transparent,
  //   systemNavigationBarDividerColor: Colors.transparent,
  //   systemNavigationBarIconBrightness: Brightness.light,
  //   statusBarColor: Colors.transparent,
  //   statusBarIconBrightness: Brightness.dark,
  // ));

  // SentryConfig.initialize(
  //   () => runApp(const AiGunApp()),
  // ).then((_) {
  //   FlutterError.onError = (FlutterErrorDetails details) async {
  //     // if (kDebugMode) {
  //     //   FlutterError.dumpErrorToConsole(details);
  //     // }
  //     await SentryConfig.reportError(
  //       details.exception,
  //       details.stack,
  //       hint: 'AIGun Error',
  //     );
  //   };
  // });
  // SentryConfig.disable();
  runApp(const AiGunApp());
}

import 'package:flutter/material.dart';
import 'package:flutter_aigun/app.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/utils/timezone_utils.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true;

  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintBaselinesEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();

  // 初始化时区数据
  TimezoneUtils.initializeTimezone();
  

  // 异步初始化所有核心服务（包括 SettingsStorage 和其他异步依赖）
  await setupCoreServices();

  // 确保所有异步初始化完成后再运行应用
  runApp(const AIGunApp());
}

import 'package:permission_handler/permission_handler.dart';
import '../../../utils/logger.dart';

/// 通知权限管理
class NotificationPermission {
  /// 请求通知权限（Android 13+ 需要）
  static Future<bool> request() async {
    Logger.info('checking notification permission');

    // 检查当前权限状态
    final status = await Permission.notification.status;
    Logger.info('notification permission status: $status');

    if (status.isGranted) {
      Logger.info('notification permission granted');
      return true;
    }

    if (status.isDenied) {
      Logger.info('requesting notification permission');
      final result = await Permission.notification.request();
      Logger.info('notification permission request result: $result');
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      Logger.error(
          'notification permission permanently denied, please open settings page');
      // 可以提示用户去设置页面
      await openAppSettings();
      return false;
    }

    return false;
  }

  /// 检查是否已授予通知权限
  static Future<bool> isGranted() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }
}

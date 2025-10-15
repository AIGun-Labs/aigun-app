import 'package:permission_handler/permission_handler.dart';
import '../../../utils/logger.dart';

/// 通知权限管理
class NotificationPermission {
  /// 请求通知权限（Android 13+ 需要）
  static Future<bool> request() async {
    Logger.info('检查通知权限');

    // 检查当前权限状态
    final status = await Permission.notification.status;
    Logger.info('通知权限状态: $status');

    if (status.isGranted) {
      Logger.info('通知权限已授予');
      return true;
    }

    if (status.isDenied) {
      Logger.info('请求通知权限');
      final result = await Permission.notification.request();
      Logger.info('通知权限请求结果: $result');
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      Logger.error('通知权限被永久拒绝，需要用户手动开启');
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

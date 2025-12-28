import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermission {
  static Future<bool> request() async {
    try {
      final status = await Permission.notification.status;
      if (status.isGranted) {
        return true;
      }

      if (status.isDenied) {
        final result = await Permission.notification.request();
        return result.isGranted;
      }

      if (status.isPermanentlyDenied) {
        return false;
      }

      return false;
    } on Exception catch (e) {
      return false;
    }
  }

  static Future<bool> openNotificationSettings() async {
    try {
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
      return true;
    } catch (e) {
      try {
        return await openAppSettings();
      } on Exception catch (e) {
        // TODO
        return false;
      }
    }
  }

  static Future<bool> isGranted() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }
}

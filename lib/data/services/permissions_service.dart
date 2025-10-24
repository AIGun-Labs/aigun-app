import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/data/services/sentry_service.dart';
import 'package:flutter_aigun/utils/storage/local/permission_storage.dart';
import 'package:flutter_aigun/widgets/dialog/privacy.dart';

class PermissionsService {
  static Future<void> requestTrackingPermission(BuildContext context) async {
    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;

      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } catch (e, s) {
      getIt<SentryService>().reportError("requestPermissionError $e", s);
    }
  }

  static Future<bool?> requestPrivacyPermission(BuildContext context) async {
    try {
      final privacyPermission =
          await getIt<PermissionStorage>().getPrivacyPermission();
      if (privacyPermission) {
        return true;
      }
      final result = await PrivacyDialog().show(context);
      return result;
    } catch (e, s) {
      getIt<SentryService>().reportError("checkPermissionError $e", s);
    }
    return false;
  }
}

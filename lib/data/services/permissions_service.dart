import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';

import '../../core/service_locator.dart';
import '../../utils/storage/local/permission_storage.dart';
import '../../widgets/dialog/privacy.dart';
import 'sentry_service.dart';

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

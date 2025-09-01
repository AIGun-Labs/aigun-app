import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceIdentifierService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static const String _persistentKey = "persistent_device_id";

  static Future<String> getDeviceId() async {
    try {
      // get system device id
      String? systemId = await _getSystemDeviceId();

      if (systemId != null && systemId.isNotEmpty && systemId != 'unknown') {
        return systemId;
      }

      // if system id is not available, use persistent device id
      return await _getPersistentDeviceId();
    } catch (e) {
      // fallback to generate unique id
      return _generateFallbackId();
    }
  }

  static Future<String?> _getSystemDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? '';
      }
    } catch (e) {
      // ignore error and return null
    }
    return null;
  }

  /// get persistent device id
  static Future<String> _getPersistentDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_persistentKey);

    if (deviceId == null) {
      deviceId = _generateUniqueId();
      await prefs.setString(_persistentKey, deviceId);
    }

    return deviceId;
  }

  /// generate unique id
  static String _generateUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = DateTime.now().microsecond;
    final data = '$timestamp$random${Platform.operatingSystem}';

    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);

    return digest.toString().substring(0, 16);
  }

  /// generate fallback id
  static String _generateFallbackId() {
    return 'fallback_${DateTime.now().millisecondsSinceEpoch}';
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';

class DeviceHelper {
  static String getDeviceType() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isWindows) {
      return 'windows';
    } else if (Platform.isMacOS) {
      return 'macos';
    } else if (Platform.isLinux) {
      return 'linux';
    } else if (kIsWeb) {
      return 'web';
    } else {
      return 'unknown';
    }
  }

  static DeviceType getDeviceTypeEnum() {
    if (Platform.isAndroid) {
      return DeviceType.android;
    } else if (Platform.isIOS) {
      return DeviceType.ios;
    } else if (Platform.isWindows) {
      return DeviceType.windows;
    } else if (Platform.isMacOS) {
      return DeviceType.macos;
    } else if (Platform.isLinux) {
      return DeviceType.linux;
    } else if (kIsWeb) {
      return DeviceType.web;
    } else {
      return DeviceType.unknown;
    }
  }

  static bool get isMobileDevice {
    return Platform.isAndroid || Platform.isIOS;
  }

  static bool get isDesktopDevice {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }

  static bool get isWebPlatform {
    return kIsWeb;
  }
}

enum DeviceType {
  android,
  ios,
  windows,
  macos,
  linux,
  web,
  unknown;

  String get value {
    switch (this) {
      case DeviceType.android:
        return 'android';
      case DeviceType.ios:
        return 'ios';
      case DeviceType.windows:
        return 'windows';
      case DeviceType.macos:
        return 'macos';
      case DeviceType.linux:
        return 'linux';
      case DeviceType.web:
        return 'web';
      case DeviceType.unknown:
        return 'unknown';
    }
  }

  String get displayName {
    switch (this) {
      case DeviceType.android:
        return 'Android';
      case DeviceType.ios:
        return 'iOS';
      case DeviceType.windows:
        return 'Windows';
      case DeviceType.macos:
        return 'macOS';
      case DeviceType.linux:
        return 'Linux';
      case DeviceType.web:
        return 'Web';
      case DeviceType.unknown:
        return 'Unknown';
    }
  }
}

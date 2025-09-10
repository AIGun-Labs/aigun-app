import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// 时区工具类
class TimezoneUtils {
  static String? _deviceTimezone;

  /// 初始化时区数据
  static void initializeTimezone() {
    tz_data.initializeTimeZones();
  }

  /// 获取设备当前时区
  static String getDeviceTimezone() {
    if (_deviceTimezone != null) return _deviceTimezone!;

    try {
      // 使用 timezone 包获取设备时区
      final deviceLocation = tz.local;
      _deviceTimezone = deviceLocation.name;
      return _deviceTimezone!;
    } catch (e) {
      // 备用方法：使用 DateTime 的 timeZoneName
      try {
        _deviceTimezone = DateTime.now().timeZoneName;
        return _deviceTimezone!;
      } catch (e) {
        // 最后的备用方案
        return 'y';
      }
    }
  }

  /// 获取设备时区偏移（以小时为单位）
  static double getDeviceTimezoneOffset() {
    try {
      return DateTime.now().timeZoneOffset.inHours.toDouble();
    } catch (e) {
      return 0.0; // UTC
    }
  }

  /// 将 UTC 时间转换为设备本地时间
  static DateTime utcToLocal(DateTime utcTime) {
    try {
      final deviceLocation = tz.local;
      return tz.TZDateTime.from(utcTime, deviceLocation);
    } catch (e) {
      // 备用方法
      return utcTime.toLocal();
    }
  }

  /// 将本地时间转换为 UTC 时间
  static DateTime localToUtc(DateTime localTime) {
    try {
      final deviceLocation = tz.local;
      return tz.TZDateTime(
              deviceLocation,
              localTime.year,
              localTime.month,
              localTime.day,
              localTime.hour,
              localTime.minute,
              localTime.second,
              localTime.millisecond,
              localTime.microsecond)
          .toUtc();
    } catch (e) {
      // 备用方法
      return localTime.toUtc();
    }
  }

  /// 获取所有可用的时区列表
  static List<String> getAvailableTimezones() {
    try {
      return tz.timeZoneDatabase.locations.keys.toList();
    } catch (e) {
      return ['UTC'];
    }
  }

  /// 格式化时间显示，包含时区信息
  static String formatWithTimezone(DateTime dateTime,
      {String format = "yyyy-MM-dd HH:mm:ss"}) {
    final localTime = utcToLocal(dateTime);
    final timezoneName = getDeviceTimezone();
    final formatter = DateFormat(format);
    return '${formatter.format(localTime)} $timezoneName';
  }

  static String formatTimeToLocal(DateTime? dateTime,
      {String format = "yyyy-MM-dd HH:mm:ss"}) {
    if (dateTime == null) {
      return '';
    }
    final localTime = utcToLocal(dateTime);
    final formatter = DateFormat(format);
    return formatter.format(localTime);
  }
}

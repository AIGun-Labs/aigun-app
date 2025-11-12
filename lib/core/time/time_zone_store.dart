// core/time/time_zone_store.dart
import 'dart:async';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneStore {
  TimeZoneStore._();
  static final TimeZoneStore instance = TimeZoneStore._();

  late tz.Location _location;
  String _name = tz.local.name;
  bool _initialized = false;

  String get currentName => _name;
  tz.Location get location => _location;
  bool get initialized => _initialized;

  /// 初始化：加载时区库，默认取设备时区（可自定义 resolver），失败兜底 UTC
  Future<void> init({
    String? timeZoneName,
    Future<String?> Function()? deviceTimeZoneResolver,
  }) async {
    tzdata.initializeTimeZones();

    String name = timeZoneName ?? tz.local.name;
    try {
      if (deviceTimeZoneResolver != null) {
        final v = await deviceTimeZoneResolver();
        if (v != null && v.isNotEmpty) name = v; // 如 'Asia/Shanghai'
      }
      _location = tz.getLocation(name);
      _name = name;
    } catch (_) {
      final dateTimeNowZoneName = DateTime.now().timeZoneName;
      _location = tz.getLocation(dateTimeNowZoneName);
      _name = dateTimeNowZoneName;
    }

    _initialized = true;
  }

  /// 切换当前展示时区（IANA 名称）
  void setTimeZone(String name) {
    _location = tz.getLocation(name);
    _name = name;
  }
}

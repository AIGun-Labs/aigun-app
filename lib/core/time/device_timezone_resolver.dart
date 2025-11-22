import 'package:flutter_timezone/flutter_timezone.dart' as ftz;
import 'package:timezone/timezone.dart' as tz;

import '../../utils/logger.dart';

Future<String?> resolveDeviceTimeZone() async {
  try {
    // 插件获取设备时区（期望返回 IANA，如 Asia/Shanghai）
    final name = await ftz.FlutterTimezone.getLocalTimezone();

    Logger.info('device timezone: $name');

    if (tz.timeZoneDatabase.locations.containsKey(name.identifier)) {
      return name.identifier;
    }
  } catch (_) {}

  // 兜底：tz.local 的名称（可能已是 IANA）
  try {
    final localName = tz.local.name;
    if (tz.timeZoneDatabase.locations.containsKey(localName)) {
      return localName;
    }
  } catch (_) {}

  return 'UTC';
}

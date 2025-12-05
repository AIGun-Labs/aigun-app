import 'package:flutter_timezone/flutter_timezone.dart' as ftz;
import 'package:timezone/timezone.dart' as tz;

import '../../utils/logger.dart';

Future<String?> resolveDeviceTimeZone() async {
  try {
    final name = await ftz.FlutterTimezone.getLocalTimezone();

    Logger.info('device timezone: $name');

    if (tz.timeZoneDatabase.locations.containsKey(name.identifier)) {
      return name.identifier;
    }
  } catch (_) {}

  try {
    final localName = tz.local.name;
    if (tz.timeZoneDatabase.locations.containsKey(localName)) {
      return localName;
    }
  } catch (_) {}

  return 'UTC';
}

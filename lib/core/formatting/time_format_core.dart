// core/formatting/time_format_core.dart
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

import '../time/time_zone_store.dart';

class TimeFormatCore {
  TimeFormatCore._();

  static final Map<String, DateFormat> _cache = {};

  static String format(
    DateTime? dt, {
    String pattern = 'MM.dd HH:mm',
    String? locale,
    String? timeZoneName,
    bool withUtcSuffix = false,
  }) {
    if (dt == null) return '-';

    final loc = _resolveLocation(timeZoneName);
    final zoned = tz.TZDateTime.from(_toUtc(dt), loc);
    final key = '${locale ?? Intl.getCurrentLocale()}|$pattern';
    final fmt = _cache.putIfAbsent(key, () => DateFormat(pattern, locale));

    final base = fmt.format(zoned);
    if (!withUtcSuffix) return base;

    return '$base ${_utcOffsetLabel(zoned.timeZoneOffset)}';
  }

  static String relative(
    DateTime? dt, {
    DateTime? nowUtc,
    String? locale,
    String? timeZoneName,
  }) {
    if (dt == null) return '-';

    final loc = _resolveLocation(timeZoneName);
    final now = tz.TZDateTime.from(
      _toUtc(nowUtc ?? DateTime.now().toUtc()),
      loc,
    );
    final when = tz.TZDateTime.from(_toUtc(dt), loc);
    final diff = now.difference(when);

    if (diff.inSeconds < 60) return '';
    if (diff.inMinutes < 60) return '${diff.inMinutes} ';
    if (diff.inHours < 24) return '${diff.inHours} ';

    final isYesterday =
        DateTime(
          now.year,
          now.month,
          now.day,
        ).difference(DateTime(when.year, when.month, when.day)).inDays ==
        1;
    if (isYesterday) {
      final t = format(
        dt,
        pattern: 'HH:mm',
        locale: locale,
        timeZoneName: timeZoneName,
      );
      return ' $t';
    }

    final isSameYear = now.year == when.year;
    final pattern = isSameYear ? 'MM-dd HH:mm' : 'yyyy-MM-dd HH:mm';
    return format(
      dt,
      pattern: pattern,
      locale: locale,
      timeZoneName: timeZoneName,
    );
  }

  static void clearLocale(String locale) {
    _cache.removeWhere((key, _) => key.startsWith('$locale|'));
  }

  static tz.Location _resolveLocation(String? name) {
    if (name != null && name.isNotEmpty) {
      return tz.getLocation(name);
    }
    return TimeZoneStore.instance.location;
  }

  static DateTime _toUtc(DateTime dt) => dt.isUtc ? dt : dt.toUtc();

  static String _utcOffsetLabel(Duration d) {
    final sign = d.isNegative ? '-' : '+';
    final totalMinutes = d.inMinutes.abs();
    final hh = (totalMinutes ~/ 60).toString().padLeft(2, '0');
    final mm = (totalMinutes % 60).toString().padLeft(2, '0');
    return 'UTC$sign$hh:$mm';
  }
}

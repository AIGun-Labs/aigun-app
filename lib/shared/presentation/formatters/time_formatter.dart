// presentation/formatters/time_formatter.dart
import 'package:flutter/widgets.dart';

import '../../../core/formatting/time_format_core.dart';
import '../../../core/time/time_zone_store.dart';

class TimeFormatter {
  TimeFormatter._();

  static String format(
    DateTime? dt,
    BuildContext ctx, {
    String pattern = 'MM.dd HH:mm',
    String? timeZoneName,
    bool withUtcSuffix = false,
  }) {
    return TimeFormatCore.format(
      dt,
      pattern: pattern,
      locale: Localizations.localeOf(ctx).toLanguageTag(),
      timeZoneName: timeZoneName ?? TimeZoneStore.instance.currentName,
      withUtcSuffix: withUtcSuffix,
    );
  }

  static String relative(
    DateTime? dt,
    BuildContext ctx, {
    String? timeZoneName,
    DateTime? nowUtc,
  }) {
    return TimeFormatCore.relative(
      dt,
      nowUtc: nowUtc,
      locale: Localizations.localeOf(ctx).toLanguageTag(),
      timeZoneName: timeZoneName ?? TimeZoneStore.instance.currentName,
    );
  }

  static void clearLocale(String locale) => TimeFormatCore.clearLocale(locale);
}

// presentation/formatters/time_formatter.dart
import 'package:flutter/widgets.dart';

import '../../../core/formatting/date_format_core.dart';
import '../../../core/time/time_zone_store.dart';

class TimeFormatter {
  TimeFormatter._();

  /// 固定格式：默认 'MM.dd HH:mm'
  static String format(
    DateTime? dt,
    BuildContext ctx, {
    String pattern = 'MM.dd HH:mm',
    String? timeZoneName,
    bool withUtcSuffix = false,
  }) {
    return DateFormatCore.format(
      dt,
      pattern: pattern,
      locale: Localizations.localeOf(ctx).toLanguageTag(),
      timeZoneName: timeZoneName ?? TimeZoneStore.instance.currentName,
      withUtcSuffix: withUtcSuffix,
    );
  }

  /// 相对时间：刚刚/xx分钟前/昨天HH:mm/…
  static String relative(
    DateTime? dt,
    BuildContext ctx, {
    String? timeZoneName,
    DateTime? nowUtc,
  }) {
    return DateFormatCore.relative(
      dt,
      nowUtc: nowUtc,
      locale: Localizations.localeOf(ctx).toLanguageTag(),
      timeZoneName: timeZoneName ?? TimeZoneStore.instance.currentName,
    );
  }

  /// 清理某语言环境的缓存（可选）
  static void clearLocale(String locale) => DateFormatCore.clearLocale(locale);
}

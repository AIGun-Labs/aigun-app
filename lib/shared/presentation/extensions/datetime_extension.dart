// presentation/extensions/datetime_extensions.dart
import 'package:flutter/widgets.dart';
import '../formatters/time_formatter.dart';

extension DateTimeX on DateTime? {
  /// 固定格式格式化（默认 'MM.dd HH:mm'）
  String fmt(
    BuildContext ctx, {
    String pattern = 'MM.dd HH:mm',
    String? timeZoneName,
    bool withUtcSuffix = false,
  }) =>
      TimeFormatter.format(
        this,
        ctx,
        pattern: pattern,
        timeZoneName: timeZoneName,
        withUtcSuffix: withUtcSuffix,
      );

  /// 相对时间（刚刚/xx分钟前/昨天…）
  String relative(
    BuildContext ctx, {
    String? timeZoneName,
    DateTime? nowUtc,
  }) =>
      TimeFormatter.relative(
        this,
        ctx,
        timeZoneName: timeZoneName,
        nowUtc: nowUtc,
      );
}

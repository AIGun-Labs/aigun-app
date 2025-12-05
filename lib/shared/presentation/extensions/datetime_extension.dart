// presentation/extensions/datetime_extensions.dart
import 'package:flutter/widgets.dart';

import '../formatters/time_formatter.dart';

extension DateTimeX on DateTime? {
  String fmt(
    BuildContext ctx, {
    String pattern = 'MM.dd HH:mm',
    String? timeZoneName,
    bool withUtcSuffix = false,
  }) => TimeFormatter.format(
    this,
    ctx,
    pattern: pattern,
    timeZoneName: timeZoneName,
    withUtcSuffix: withUtcSuffix,
  );

  String relative(BuildContext ctx, {String? timeZoneName, DateTime? nowUtc}) =>
      TimeFormatter.relative(
        this,
        ctx,
        timeZoneName: timeZoneName,
        nowUtc: nowUtc,
      );
}

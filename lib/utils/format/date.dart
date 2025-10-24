import 'package:intl/intl.dart';
import 'package:flutter_aigun/utils/timezone_utils.dart';

String formatDate(DateTime dateTime, {String format = "MM-dd HH:mm"}) {
  return DateFormat(format).format(dateTime);
}

class DateUtilsHelper {
  /// 格式化时间戳（秒级或毫秒级）
  static String formatTimestamp(int timestamp,
      {String format = "HH:mm MM-dd", bool isUtc = true}) {
    // 判断是秒级还是毫秒级时间戳
    DateTime dateTime = timestamp > 1e10
        ? DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: isUtc)
        : DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: isUtc);

    if (isUtc) {
      // 如果是UTC时间，转换为本地时间
      dateTime = TimezoneUtils.utcToLocal(dateTime);
    }

    return DateFormat(format).format(dateTime);
  }

// 将后端返回的 UTC 时间转换为本地时间
  static String formatUtcToLocal(DateTime time, String format) {
    final iosTime =
        TimezoneUtils.utcToLocal(DateTime.parse(time.toIso8601String()));
    final utcTime = DateTime.parse(iosTime.toUtc().toString());
    final localTime = utcTime.toLocal();

    return DateFormat(format).format(localTime);
  }
}

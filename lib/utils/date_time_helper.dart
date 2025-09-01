import 'package:intl/intl.dart';

class DateTimeHelper {
  /// 将Unix时间戳（秒）转换为格式化的日期时间字符串
  /// 格式: yyyy.MM.dd HH:mm
  static String formatTimestamp(int? timestamp) {
    if (timestamp == null) return '';

    // 判断时间戳是毫秒还是秒
    final DateTime dateTime = timestamp > 9999999999
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // 格式化为 yyyy.MM.dd HH:mm
    final DateFormat formatter = DateFormat('yyyy.MM.dd HH:mm');
    return formatter.format(dateTime);
  }

  /// 将Unix时间戳（秒）转换为相对时间（例如：3小时前，昨天等）
  static String getRelativeTime(int? timestamp) {
    if (timestamp == null) return '';

    // 判断时间戳是毫秒还是秒
    final DateTime dateTime = timestamp > 9999999999
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}

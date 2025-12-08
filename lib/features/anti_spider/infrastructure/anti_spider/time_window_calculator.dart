import '../../../../infrastructure/extensions/string.dart';

sealed class TimeWindowCalculator {
  String currentUnit();
}

class UtcFiveMinuteWindowCalculator implements TimeWindowCalculator {
  @override
  String currentUnit() {
    /// 获取当前的 UTC 时间
    final now = DateTime.now().toUtc();

    /// 每 5 分钟一个单位
    final stepMinutes = 1;

    /// 计算当前的单位 例如：当前是 12:03，则返回 12:00
    final normalizedMinute = (now.minute ~/ stepMinutes) * stepMinutes;

    final normalized = DateTime.utc(
      now.year,
      now.month,
      now.day,
      now.hour,
      normalizedMinute,
    );

    return '${normalized.year}-${normalized.month.two()}-${normalized.day.two()}T${normalized.hour.two()}:${normalized.minute.two()}';
  }
}

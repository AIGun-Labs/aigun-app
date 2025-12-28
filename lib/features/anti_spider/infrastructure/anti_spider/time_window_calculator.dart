import '../../../../infrastructure/extensions/string.dart';

sealed class TimeWindowCalculator {
  String currentUnit();
}

class UtcFiveMinuteWindowCalculator implements TimeWindowCalculator {
  @override
  String currentUnit() {
    final now = DateTime.now().toUtc();
    final stepMinutes = 1;
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

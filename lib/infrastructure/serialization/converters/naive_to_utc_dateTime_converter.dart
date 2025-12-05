import 'package:freezed_annotation/freezed_annotation.dart';

class NaiveToUtcDateTimeConverter implements JsonConverter<DateTime, Object?> {
  const NaiveToUtcDateTimeConverter();

  @override
  DateTime fromJson(Object? json) {
    if (json == null) {
      // throw const FormatException('time parameter is null');
      return DateTime.now().toUtc();
    }
    if (json is String) {
      final s = json.trim();
      final hasZone =
          s.endsWith('Z') ||
          RegExp(r'([+-]\d{2}:\d{2}|[+-]\d{4})$').hasMatch(s);

      final parsed = DateTime.parse(hasZone ? s : '${s}Z');
      return parsed.toUtc();
    }
    if (json is num) {
      final ms = json > 1e10 ? json.toInt() : (json * 1000).toInt();
      return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
    }
    if (json is DateTime) {
      return json.isUtc ? json : json.toUtc();
    }
    throw const FormatException('Unsupported time format');
  }

  @override
  Object toJson(DateTime object) => object.toUtc().toIso8601String();
}

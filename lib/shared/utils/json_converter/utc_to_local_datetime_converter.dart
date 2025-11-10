import 'package:freezed_annotation/freezed_annotation.dart';

class UtcToLocalDatetimeConverter implements JsonConverter<DateTime?, String?> {
  const UtcToLocalDatetimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    return DateTime.parse(json).toLocal();
  }

  @override
  String toJson(DateTime? object) => object?.toUtc().toIso8601String() ?? "";
}

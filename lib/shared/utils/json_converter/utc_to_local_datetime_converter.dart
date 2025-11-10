import 'package:freezed_annotation/freezed_annotation.dart';

class UtcToLocalDatetimeConverter implements JsonConverter<String?, String?> {
  const UtcToLocalDatetimeConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) return null;
    return json.toLocal().toIso8601String();
  }

  @override
  String toJson(String? object) => object ?? "";
}

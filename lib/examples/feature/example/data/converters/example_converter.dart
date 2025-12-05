import 'package:freezed_annotation/freezed_annotation.dart';

///

///

class ExampleConverter implements JsonConverter<String, Object?> {
  const ExampleConverter();

  @override
  String fromJson(Object? json) {
    return (json ?? '').toString();
  }

  @override
  Object toJson(String object) {
    return object;
  }
}

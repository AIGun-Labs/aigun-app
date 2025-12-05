import 'package:freezed_annotation/freezed_annotation.dart';

part 'example_entity.freezed.dart';

///

@freezed
sealed class ExampleEntity with _$ExampleEntity {
  const ExampleEntity._();

  ///

  const factory ExampleEntity({
    required String id,
    required String name,
    required String description,
  }) = _ExampleEntity;

  ///

  bool get isValid => id.isNotEmpty && name.isNotEmpty;
}

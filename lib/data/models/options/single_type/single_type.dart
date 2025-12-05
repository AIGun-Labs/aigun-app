import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_type.freezed.dart';
part 'single_type.g.dart';

@freezed
sealed class SingleTypeOptions with _$SingleTypeOptions {
  const factory SingleTypeOptions({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'push_filter') String? pushFilter, // Solana Investigator
  }) = _SingleTypeOptions;

  factory SingleTypeOptions.fromJson(Map<String, dynamic> json) =>
      _$SingleTypeOptionsFromJson(json);
}

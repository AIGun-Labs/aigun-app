import 'package:freezed_annotation/freezed_annotation.dart';

part 'latest.freezed.dart';
part 'latest.g.dart';

@freezed
sealed class Latest with _$Latest {
  const factory Latest({
    required String app,
    required String build,
    required String latest,
    @JsonKey(name: 'min_version') required String minVersion,
    required List<String> notes,
    required String url,
    required String sha256,
    required bool force,
  }) = _Latest;

  factory Latest.fromJson(Map<String, dynamic> json) => _$LatestFromJson(json);
}

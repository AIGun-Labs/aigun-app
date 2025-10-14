import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_info.freezed.dart';
part 'update_info.g.dart';

@freezed
class UpdateInfo with _$UpdateInfo {
  const factory UpdateInfo({
    required String app,
    required String build,
    required String latest,
    @JsonKey(name: "min_version") required String minVersion,
    required List<String> notes,
    required String url,
    required String sha256,
    required bool force,
  }) = _UpdateInfo;

  factory UpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoFromJson(json);
}

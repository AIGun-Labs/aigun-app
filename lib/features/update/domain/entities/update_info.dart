import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_info.freezed.dart';
part 'update_info.g.dart';

@freezed
class UpdateInfo with _$UpdateInfo {
  const factory UpdateInfo({
    required String app,
    required String latest,
    required int build,
    @JsonKey(name: "min_version", defaultValue: null) String? minVersion,
    required String url,
    required String sha256,
    required bool force,
    required String filename,
    required List<String> notes,
  }) = _UpdateInfo;

  factory UpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';

@freezed
class ConfigModel with _$ConfigModel {
  const factory ConfigModel({
    required String app,
    required String latest,
    required int build,
    @JsonKey(name: "min_version", defaultValue: "") required String minVersion,
    required String url,
    required String sha256,
    required bool force,
    required String filename,
    @JsonKey(name: "multilingual_notes", defaultValue: {"zh": []})
    required Map<String, List<String>> multilingualNotes,
  }) = _ConfigModel;

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);
}

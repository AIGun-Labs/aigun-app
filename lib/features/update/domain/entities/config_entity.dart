import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_entity.freezed.dart';

@freezed
class ConfigEntity with _$ConfigEntity {
  const factory ConfigEntity({
    required String app,
    required String latest,
    required int build,
    required String minVersion,
    required String url,
    required String sha256,
    required bool force,
    required String filename,
    required Map<String, List<String>> multilingualNotes,
  }) = _ConfigEntity;
}

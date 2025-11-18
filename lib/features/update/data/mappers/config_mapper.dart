import '../../domain/entities/config_entity.dart';
import '../models/config_model.dart';

extension ConfigMapper on ConfigModel {
  ConfigEntity toEntity() => ConfigEntity(
        app: app,
        latest: latest,
        build: build,
        minVersion: minVersion,
        url: url,
        sha256: sha256,
        force: force,
        filename: filename,
        multilingualNotes: multilingualNotes,
      );
}

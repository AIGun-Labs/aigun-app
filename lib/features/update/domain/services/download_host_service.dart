import '../entities/config_entity.dart';

abstract class DownloadHostService {
  Future<ConfigEntity?> downloadLatestInfo();
}

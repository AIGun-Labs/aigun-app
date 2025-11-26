import '../entities/config_entity.dart';
import '../services/download_host_service.dart';

class CheckForUpdateV2 {
  final DownloadHostService _downloadHostService;
  CheckForUpdateV2(this._downloadHostService);

  Future<ConfigEntity?> call() => _downloadHostService.downloadLatestInfo();
}

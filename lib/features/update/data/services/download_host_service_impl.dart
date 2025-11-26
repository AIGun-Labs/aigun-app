import '../../domain/entities/config_entity.dart';
import '../../domain/repositories/download_route_repo.dart';
import '../../domain/repositories/update_config_repo.dart';
import '../../domain/services/download_host_service.dart';

class DownloadHostServiceImpl implements DownloadHostService {
  final DownloadRouteRepo _downloadRouteRepo;

  final UpdateConfigRepository _configRepository;

  DownloadHostServiceImpl(
    this._downloadRouteRepo,
    this._configRepository,
  );

  @override
  Future<ConfigEntity?> downloadLatestInfo() async {
    String defaultHost = 'cdn.route.aigun.ai';

    try {
      final host = await _downloadRouteRepo.resolveDownloadCname();
      if (host != null) {
        defaultHost = host;
      }
    } catch (e) {
      defaultHost = 'cdn.route.aigun.ai';
    }

    final config = await _configRepository.fetchLatestInfoV2(defaultHost);
    if (config != null) {
      return config;
    }
    return null;
  }
}

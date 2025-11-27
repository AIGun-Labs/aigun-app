import '../../domain/entities/config_entity.dart';
import '../../domain/repositories/download_route_repo.dart';
import '../../domain/repositories/update_config_repo.dart';
import '../../domain/services/download_host_service.dart';

class DownloadHostServiceImpl implements DownloadHostService {
  final DownloadRouteRepo _downloadRouteRepo;

  final UpdateConfigRepo _configRepository;

  DownloadHostServiceImpl(
    this._downloadRouteRepo,
    this._configRepository,
  );

  @override
  Future<ConfigEntity?> downloadLatestInfo() async {
    final host = await _downloadRouteRepo.resolveDownloadCname();

    print('host: $host');
    final config = await _configRepository.fetchLatestInfoV2(host);
    print('config: $config');
    if (config != null) {
      return config;
    }
    return null;
  }
}

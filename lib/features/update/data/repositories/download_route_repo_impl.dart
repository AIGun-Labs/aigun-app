import '../../domain/repositories/download_route_repo.dart';
import '../sources/download_dns_remote_source.dart';

class DownloadRouteRepoImpl implements DownloadRouteRepo {
  final DownloadDnsRemoteSource _downloadDnsRemoteSource;

  DownloadRouteRepoImpl(this._downloadDnsRemoteSource);

  @override
  Future<String> resolveDownloadCname() async {
    try {
      final cname = await _downloadDnsRemoteSource.getCname();

      return cname;
    } catch (e) {
      rethrow;
    }
  }
}

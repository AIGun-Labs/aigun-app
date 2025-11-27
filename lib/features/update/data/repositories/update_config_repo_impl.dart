import '../../domain/entities/config_entity.dart';
import '../../domain/repositories/update_config_repo.dart';
import '../mappers/config_mapper.dart';
import '../sources/update_remote_source.dart';

class UpdateConfigRepoImpl implements UpdateConfigRepo {
  final UpdateRemoteSource remote;
  UpdateConfigRepoImpl(this.remote);

  @override
  Future<ConfigEntity?> fetchLatest() {
    return remote.fetchLatestInfo().then((value) => value?.toEntity());
  }

  @override
  Future<String> fetchChecksum() {
    return remote.fetchChecksum();
  }

  @override
  Future<ConfigEntity?> fetchLatestInfoV2(String host) async {
    final result = await remote.fetchLatestInfoV2(host);

    return result?.toEntity();
  }
}

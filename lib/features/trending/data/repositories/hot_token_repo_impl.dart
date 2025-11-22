import '../../domain/entities/hot_token_entity.dart';
import '../../domain/entities/networks_entity.dart';
import '../../domain/repositories/hot_token_repo.dart';
import '../sources/hot_token_remote_source.dart';

/// 热门代币仓储实现
class HotTokenRepoImpl implements HotTokenRepo {
  final HotTokenRemoteSource _remoteSource;

  HotTokenRepoImpl(this._remoteSource);

  @override
  Future<List<HotTokenEntity>> fetchHotTokens(String? network) async {
    final data = await _remoteSource.fetchHotTokens(network);
    return data.map((e) => e.toEntity()).toList();
  }

  @override
  Future<NetworksEntity> fetchNetworks() async {
    final data = await _remoteSource.fetchNetworks();
    return data.toEntity();
  }
}

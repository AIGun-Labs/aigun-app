import '../entities/networks_entity.dart';
import '../repositories/hot_token_repository.dart';

/// 获取支持的网络列表用例
class FetchNetworks {
  final HotTokenRepository _repository;

  FetchNetworks(this._repository);

  /// 执行获取支持的网络列表
  Future<NetworksEntity> call() async {
    return await _repository.fetchNetworks();
  }
}

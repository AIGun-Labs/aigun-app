import '../entities/hot_token_entity.dart';
import '../entities/networks_entity.dart';

/// 热门代币仓储接口
abstract class HotTokenRepository {
  /// 获取热门代币列表
  Future<List<HotTokenEntity>> fetchHotTokens(String? network);

  /// 获取支持的网络列表
  Future<NetworksEntity> fetchNetworks();
}

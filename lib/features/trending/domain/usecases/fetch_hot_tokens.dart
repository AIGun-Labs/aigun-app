import '../entities/hot_token_entity.dart';
import '../repositories/hot_token_repository.dart';

/// 获取热门代币用例
class FetchHotTokens {
  final HotTokenRepository _repository;

  FetchHotTokens(this._repository);

  /// 执行获取热门代币
  Future<List<HotTokenEntity>> call(String? network) async {
    return await _repository.fetchHotTokens(network);
  }
}

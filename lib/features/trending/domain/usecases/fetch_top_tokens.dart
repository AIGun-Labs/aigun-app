import '../../../../core/types/result.dart';
import '../entities/top_token_entity.dart';
import '../repositories/top_token_repo.dart';

class FetchTopTokens {
  final TopTokenRepo _repo;

  FetchTopTokens(this._repo);

  Future<Result<List<TopTokenEntity>>> call(String? lastTime) =>
      _repo.fetchTopTokens(lastTime);
}

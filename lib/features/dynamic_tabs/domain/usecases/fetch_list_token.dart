import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../repositories/token_repo.dart';

class FetchListToken {
  final TokenRepo _repo;

  FetchListToken(this._repo);

  Future<Result<List<BaseTokenEntity>>> call({
    required String apiUrl,
    String? lastTime,
  }) => _repo.fetchTokens(apiUrl: apiUrl, lastTime: lastTime);
}

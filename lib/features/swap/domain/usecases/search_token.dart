import '../../../../core/types/result.dart';
import '../entities/query_token_entity.dart';
import '../repositories/token_repository.dart';

class SearchTokens {
  final TokenRepository _repository;

  SearchTokens(this._repository);

  Future<Result<List<QueryTokenEntity>>> call({
    required String keyword,
    String? walletId,
  }) {
    return _repository.searchTokens(keyword: keyword, walletId: walletId);
  }
}

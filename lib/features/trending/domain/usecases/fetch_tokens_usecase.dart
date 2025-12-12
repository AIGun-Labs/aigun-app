import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../repositories/tokens_repo.dart';

class FetchTokensUsecase {
  final TokensRepo _repository;
  FetchTokensUsecase(this._repository);

  Future<Result<List<BaseTokenEntity>>> call({
    Map<String, dynamic>? queryParameters,
  }) async => await _repository.fetchTokens(queryParameters: queryParameters);
}

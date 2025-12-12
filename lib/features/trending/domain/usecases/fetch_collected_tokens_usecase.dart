import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../repositories/tokens_repo.dart';

class FetchCollectedTokensUsecase {
  final TokensRepo _repository;
  FetchCollectedTokensUsecase(this._repository);

  Future<Result<List<BaseTokenEntity>>> call({
    required String walletId,
  }) async =>
      await _repository.fetchCollectedTokensByWalletId(walletId: walletId);
}

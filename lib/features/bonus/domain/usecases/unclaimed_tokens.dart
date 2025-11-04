import '../../../../core/types/result.dart';
import '../entities/claim_token_entity.dart';
import '../repositories/claim_token_repo.dart';

class UnclaimedTokens {
  final ClaimTokenRepo _repository;

  UnclaimedTokens(this._repository);

  Future<Result<List<ClaimTokenEntity>>> call() async =>
      await _repository.fetchUnclaimedTokens();
}

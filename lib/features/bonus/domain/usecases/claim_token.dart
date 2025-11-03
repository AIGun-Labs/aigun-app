import '../../../../core/types/result.dart';
import '../repositories/claim_token_repo.dart';

class ClaimToken {
  final ClaimTokenRepo _repository;

  ClaimToken(this._repository);

  Future<Result<bool>> call(
          String network, String contract, String amount) async =>
      await _repository.claimToken(network, contract, amount);
}

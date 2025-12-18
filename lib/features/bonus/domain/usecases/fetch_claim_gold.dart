import '../../../../core/types/result.dart';
import '../repositories/invite_repo.dart';

class FetchClaimGold {
  FetchClaimGold(this._repository);
  final InviteRepo _repository;

  Future<Result<void>> call() async => await _repository.claimGold();
}

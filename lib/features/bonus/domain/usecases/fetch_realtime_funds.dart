import '../../../../core/types/result.dart';
import '../repositories/invite_repo.dart';

class FetchRealtimeFunds {
  FetchRealtimeFunds(this._repository);
  final InviteRepo _repository;

  Future<Result<String>> call() async => await _repository.getRealTimeFunds();
}

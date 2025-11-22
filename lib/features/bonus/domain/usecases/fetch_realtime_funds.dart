import '../../../../core/types/result.dart';
import '../repositories/invite_repo.dart';

class FetchRealtimeFunds {
  final InviteRepo _repository;

  FetchRealtimeFunds(this._repository);

  Future<Result<String>> call() async => await _repository.getRealTimeFunds();
}

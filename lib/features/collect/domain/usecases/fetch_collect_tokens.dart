import '../../../../core/types/result.dart';
import '../entities/collect_token_entity.dart';
import '../repositories/collect_repo.dart';

class FetchCollectTokens {
  final CollectRepo _repository;

  FetchCollectTokens(this._repository);

  Future<Result<List<CollectTokenEntity>>> call(
          {required String walletId}) async =>
      await _repository.fetchCollectTokens(walletId: walletId);
}

import '../../../../core/types/result.dart';
import '../repositories/collect_repo.dart';

class FetchDeleteCollect {
  final CollectRepo _repository;

  FetchDeleteCollect(this._repository);

  Future<Result<void>> call(
          {required String network, required String address}) async =>
      await _repository.deleteCollectToken(network: network, address: address);
}

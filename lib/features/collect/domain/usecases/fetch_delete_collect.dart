import '../../../../core/types/result.dart';
import '../repositories/collect_repo.dart';

class FetchDeleteCollect {
  FetchDeleteCollect(this._repository);
  final CollectRepo _repository;

  Future<Result<void>> call({
    required String network,
    required String address,
  }) => _repository.deleteCollectToken(network: network, address: address);
}

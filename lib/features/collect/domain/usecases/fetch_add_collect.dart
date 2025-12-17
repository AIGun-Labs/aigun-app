import '../../../../core/types/result.dart';
import '../repositories/collect_repo.dart';

class FetchAddCollect {
  FetchAddCollect(this._repository);
  final CollectRepo _repository;

  Future<Result<void>> call({
    required String network,
    required String address,
  }) => _repository.addCollectToken(network: network, address: address);
}

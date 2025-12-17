import '../../../../core/types/result.dart';
import '../repositories/collect_repo.dart';

class FetchPinCollect {
  FetchPinCollect(this._repository);
  final CollectRepo _repository;

  Future<Result<void>> call({
    required String network,
    required String address,
  }) => _repository.pinCollectToken(network: network, address: address);
}

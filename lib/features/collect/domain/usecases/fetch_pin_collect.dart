import '../../../../core/types/result.dart';
import '../repositories/collect_repo.dart';

class FetchPinCollect {
  final CollectRepo _repository;
  FetchPinCollect(this._repository);

  Future<Result<void>> call(
          {required String network, required String address}) async =>
      await _repository.pinCollectToken(network: network, address: address);
}

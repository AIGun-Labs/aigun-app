import '../../../../core/types/result.dart';
import '../repositories/collect_repository.dart';

class FetchPinCollect {
  final CollectRepository _repository;
  FetchPinCollect(this._repository);

  Future<Result<void>> call(
          {required String network, required String address}) async =>
      await _repository.pinCollectToken(network: network, address: address);
}

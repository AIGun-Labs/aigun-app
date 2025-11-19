import '../../../../core/types/result.dart';
import '../repositories/collect_repository.dart';

class FetchDeleteCollect {
  final CollectRepository _repository;

  FetchDeleteCollect(this._repository);

  Future<Result<void>> call(
          {required String network, required String address}) async =>
      await _repository.deleteCollectToken(network: network, address: address);
}

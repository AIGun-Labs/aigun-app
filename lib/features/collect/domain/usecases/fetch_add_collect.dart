import '../../../../core/types/result.dart';
import '../repositories/collect_repository.dart';

class FetchAddCollect {
  final CollectRepository _repository;

  FetchAddCollect(this._repository);

  Future<Result<void>> call(
          {required String network, required String address}) async =>
      await _repository.addCollectToken(network: network, address: address);
}

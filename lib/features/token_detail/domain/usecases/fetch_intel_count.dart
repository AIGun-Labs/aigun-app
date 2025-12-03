import '../../../../core/types/result.dart';
import '../repositories/token_detail_repo.dart';

class FetchIntelCount {
  final TokenDetailRepo _repository;

  FetchIntelCount(this._repository);

  Future<Result<int>> call({
    required String address,
    required String network,
  }) async =>
      await _repository.fetchIntelCount(address: address, network: network);
}

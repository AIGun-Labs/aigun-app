import '../../../../core/types/result.dart';
import '../../../../shared/domain/entities/intel_v2_entity.dart';
import '../repositories/token_detail_repo.dart';

class FetchLatestIntelV2 {
  final TokenDetailRepo _repository;

  FetchLatestIntelV2(this._repository);

  Future<Result<IntelV2Entity>> call({
    required String address,
    required String network,
  }) async =>
      await _repository.fetchLatestIntelV2(address: address, network: network);
}

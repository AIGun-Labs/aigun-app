import '../../../../core/types/result.dart';
import '../entity/token_info_entity.dart';
import '../repositories/token_detail_repo.dart';

class FetchTokenDetailInfo {
  final TokenDetailRepo _repository;
  FetchTokenDetailInfo(this._repository);

  Future<Result<TokenInfoEntity>> call({
    required String address,
    required String network,
    String? type,
  }) async => await _repository.fetchTokenDetailInfo(
    address: address,
    network: network,
    type: type,
  );
}

import '../../../../core/types/result.dart';
import '../entity/token_security_entity.dart';
import '../repositories/token_detail_repo.dart';

class FetchTokenSecurity {
  final TokenDetailRepo _repository;
  FetchTokenSecurity(this._repository);

  Future<Result<TokenSecurityEntity>> call({
    required String address,
    required String network,
  }) async =>
      await _repository.fetchTokenSecurity(address: address, network: network);
}

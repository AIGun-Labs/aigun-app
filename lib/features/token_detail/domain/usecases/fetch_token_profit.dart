import '../../../../core/types/result.dart';
import '../entities/token_profit_entity.dart';
import '../repositories/token_detail_repo.dart';

class FetchTokenProfit {
  final TokenDetailRepo _repository;

  FetchTokenProfit(this._repository);

  Future<Result<TokenProfitEntity>> call({
    required String address,
    required String network,
  }) async =>
      await _repository.fetchTokenProfit(address: address, network: network);
}

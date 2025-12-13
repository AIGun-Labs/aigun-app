import '../../../../core/types/result.dart';
import '../../domain/entities/candlestick_entity.dart';
import '../../domain/repositories/candlestick_repository.dart';

class FetchLatestCandlesticks {
  final CandlestickRepository _repository;

  FetchLatestCandlesticks(this._repository);

  Future<Result<List<CandlestickEntity>>> call({
    required String network,
    required String tokenContractAddress,
  }) async {
    return _repository.getLatestCandlestick(
      network: network,
      tokenContractAddress: tokenContractAddress,
    );
  }
}

import '../../../../core/types/result.dart';
import '../../domain/entities/candlestick_entity.dart';
import '../../domain/repositories/candlestick_repository.dart';

class FetchHistoryCandlesticks {
  final CandlestickRepository _repository;

  FetchHistoryCandlesticks(this._repository);

  Future<Result<List<CandlestickEntity>>> call({
    required String network,
    required String tokenContractAddress,
    required String? bar,
    required int? limit,
    required int? from,
    required int? to,
  }) async {
    return _repository.getHistoryCandlestick(
      network: network,
      tokenContractAddress: tokenContractAddress,
      bar: bar,
      limit: limit,
      from: from,
      to: to,
    );
  }
}

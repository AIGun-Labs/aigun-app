import '../../../../core/types/result.dart';
import '../entities/candlestick_entity.dart';

abstract class CandlestickRepository {
  Future<Result<List<CandlestickEntity>>> getHistoryCandlestick({
    required String network,
    required String tokenContractAddress,
    required String bar,
    required int limit,
    required int from,
    required int to,
  });

  Future<Result<List<CandlestickEntity>>> getLatestCandlestick({
    required String network,
    required String tokenContractAddress,
  });
}

import '../../../../core/types/result.dart';
import '../../domain/entities/candlestick_entity.dart';
import '../../domain/repositories/candlestick_repository.dart';
import '../datasource/candlestick_remote_data_source.dart';

class CandlestickRepositoryImpl implements CandlestickRepository {
  final CandlestickRemoteDataSource _remoteSource;

  CandlestickRepositoryImpl(this._remoteSource);

  @override
  Future<Result<List<CandlestickEntity>>> getHistoryCandlestick({
    required String network,
    required String tokenContractAddress,
    required String? bar,
    required int? limit,
    required int? from,
    required int? to,
  }) async {
    try {
      final result = await _remoteSource.getHistoryCandlestick(
        network: network,
        tokenContractAddress: tokenContractAddress,
        bar: bar,
        limit: limit,
        from: from,
        to: to,
      );
      return Result.success(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<CandlestickEntity>>> getLatestCandlestick({
    required String network,
    required String tokenContractAddress,
  }) async {
    try {
      final result = await _remoteSource.getLatestCandlestick(
        network: network,
        tokenContractAddress: tokenContractAddress,
      );
      return Result.success(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}

import 'package:dio/dio.dart';

import '../../../../core/types/result.dart';
import '../../domain/entities/candlestick_datasource_entity.dart';
import '../../domain/entities/candlestick_entity.dart';
import '../../domain/repositories/candlestick_repository.dart';
import '../datasource/candlestick_remote_data_source.dart';

class CandlestickRepositoryImpl implements CandlestickRepository {
  final CandlestickRemoteDataSource _remoteSource;

  CandlestickRepositoryImpl(this._remoteSource);

  @override
  Future<Result<CandlestickDataSourceEntity>> getHistoryCandlestick({
    required String network,
    required String tokenContractAddress,
    String? bar,
    String? limit,
    String? from,
    String? to,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _remoteSource.getHistoryCandlestick(
        network: network,
        tokenContractAddress: tokenContractAddress,
        bar: bar,
        limit: limit,
        from: from,
        to: to,
        cancelToken: cancelToken,
      );
      return Result.success(result.toEntity());
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return Result.cancelled('Request cancelled');
      }
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<CandlestickEntity>>> getLatestCandlestick({
    required String network,
    required String tokenContractAddress,
    String? bar,
    String? limit,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _remoteSource.getLatestCandlestick(
        network: network,
        tokenContractAddress: tokenContractAddress,
        bar: bar,
        limit: limit,
        cancelToken: cancelToken,
      );
      return Result.success(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      // 区分异常，取消请求的不算是错误，需要特殊处理
      if (e is DioException && e.type == DioExceptionType.cancel) {
        return Result.cancelled('Request cancelled');
      }
      return Result.failure(e.toString());
    }
  }
}

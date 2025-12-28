import 'package:dio/dio.dart';

import '../../../../core/types/result.dart';
import '../../../../infrastructure/network/error/app_exception.dart';
import '../../domain/entities/candlestick_datasource_entity.dart';
import '../../domain/repositories/candlestick_repository.dart';
import '../datasource/candlestick_remote_data_source.dart';

class CandlestickRepositoryImpl implements CandlestickRepository {
  CandlestickRepositoryImpl(this._remoteSource);
  final CandlestickRemoteDataSource _remoteSource;

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

      // if(result.candles.isEmpty) {
      //   return
      // }
      return result.candles.isEmpty
          ? Result.failure('No data found')
          : Result.success(result.toEntity());

      // return Result.success(result.toEntity());
    } catch (e) {
      if (e is NetworkException && e.cause?.type == DioExceptionType.cancel) {
        return Result.cancelled('Request cancelled');
      }
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<CandlestickDataSourceEntity>> getLatestCandlestick({
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
      return Result.success(result.toEntity());
    } catch (e) {
      if (e is NetworkException && e.cause?.type == DioExceptionType.cancel) {
        return Result.cancelled('Request cancelled');
      }
      return Result.failure(e.toString());
    }
  }
}

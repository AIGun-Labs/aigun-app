import 'package:dio/dio.dart';

import '../../../../core/types/result.dart';
import '../entities/candlestick_datasource_entity.dart';
import '../entities/candlestick_entity.dart';

abstract class CandlestickRepository {
  Future<Result<CandlestickDataSourceEntity>> getHistoryCandlestick({
    required String network,
    required String tokenContractAddress,
    String? bar,
    int? limit,
    int? from,
    int? to,
    CancelToken? cancelToken,
  });

  Future<Result<List<CandlestickEntity>>> getLatestCandlestick({
    required String network,
    required String tokenContractAddress,
    String? bar,
    int? limit,
    CancelToken? cancelToken,
  });
}

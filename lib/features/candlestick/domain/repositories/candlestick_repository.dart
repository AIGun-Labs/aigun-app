import 'package:dio/dio.dart';

import '../../../../core/types/result.dart';
import '../entities/candlestick_datasource_entity.dart';

abstract class CandlestickRepository {
  Future<Result<CandlestickDataSourceEntity>> getHistoryCandlestick({
    required String network,
    required String tokenContractAddress,
    String? bar,
    String? limit,
    String? from,
    String? to,
    CancelToken? cancelToken,
  });

  Future<Result<CandlestickDataSourceEntity>> getLatestCandlestick({
    required String network,
    required String tokenContractAddress,
    String? bar,
    String? limit,
    CancelToken? cancelToken,
  });
}

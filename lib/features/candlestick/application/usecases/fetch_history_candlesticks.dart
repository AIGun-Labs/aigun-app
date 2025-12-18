import 'package:dio/dio.dart';

import '../../../../core/types/result.dart';
import '../../domain/entities/candlestick_datasource_entity.dart';
import '../../domain/repositories/candlestick_repository.dart';

class FetchHistoryCandlesticks {
  FetchHistoryCandlesticks(this._repository);
  final CandlestickRepository _repository;

  Future<Result<CandlestickDataSourceEntity>> call({
    required String network,
    required String tokenContractAddress,
    required String? bar,
    required String? limit,
    required String? from,
    required String? to,
    CancelToken? cancelToken,
  }) async {
    return await _repository.getHistoryCandlestick(
      network: network,
      tokenContractAddress: tokenContractAddress,
      bar: bar,
      limit: limit,
      from: from,
      to: to,
      cancelToken: cancelToken,
    );
  }
}

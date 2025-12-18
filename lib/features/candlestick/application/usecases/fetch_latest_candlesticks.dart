import 'package:dio/dio.dart';

import '../../../../core/types/result.dart';
import '../../domain/entities/candlestick_datasource_entity.dart';
import '../../domain/repositories/candlestick_repository.dart';

class FetchLatestCandlesticks {
  FetchLatestCandlesticks(this._repository);
  final CandlestickRepository _repository;

  Future<Result<CandlestickDataSourceEntity>> call({
    required String network,
    required String tokenContractAddress,
    String? bar,
    String? limit,
    CancelToken? cancelToken,
  }) async {
    return await _repository.getLatestCandlestick(
      network: network,
      tokenContractAddress: tokenContractAddress,
      bar: bar,
      limit: limit,
      cancelToken: cancelToken,
    );
  }
}

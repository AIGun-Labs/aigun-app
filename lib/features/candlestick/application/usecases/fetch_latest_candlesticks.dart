import 'package:dio/dio.dart';

import '../../../../core/types/result.dart';
import '../../domain/entities/candlestick_entity.dart';
import '../../domain/repositories/candlestick_repository.dart';

class FetchLatestCandlesticks {
  final CandlestickRepository _repository;

  FetchLatestCandlesticks(this._repository);

  Future<Result<List<CandlestickEntity>>> call({
    required String network,
    required String tokenContractAddress,
    String? bar,
    int? limit,
    bool? isInitial,
    CancelToken? cancelToken,
  }) async {
    return _repository.getLatestCandlestick(
      network: network,
      tokenContractAddress: tokenContractAddress,
      bar: bar,
      limit: limit,
      // isInitial: isInitial,
      cancelToken: cancelToken,
    );
  }
}

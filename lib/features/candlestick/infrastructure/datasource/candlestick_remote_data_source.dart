import '../../../../data/services/http/dio_client.dart';
import '../models/candlestick_model.dart';

class CandlestickRemoteDataSource {
  final DioClient _dioClient;

  final String _basePath = '/api/v1/trade/candles';

  CandlestickRemoteDataSource(this._dioClient);

  Future<List<CandlestickModel>> getHistoryCandlestick({
    required String network,
    required String tokenContractAddress,
    required String bar,
    required int limit,
    required int from,
    required int to,
  }) async {
    final response = _dioClient.get(
      _basePath,
      queryParameters: {
        'network': network,
        'tokenContractAddress': tokenContractAddress,
        'bar': bar,
        'limit': limit,
      },
    );

    return (response as List<dynamic>)
        .map((e) => CandlestickModel.fromJson(e))
        .toList();
  }

  Future<List<CandlestickModel>> getLatestCandlestick({
    required String network,
    required String tokenContractAddress,
  }) async {
    final response = _dioClient.get(
      _basePath,
      queryParameters: {
        'network': network,
        'tokenContractAddress': tokenContractAddress,
        'is_latest': true,
      },
    );

    return (response as List<dynamic>)
        .map((e) => CandlestickModel.fromJson(e))
        .toList();
  }
}

import 'package:dio/dio.dart';

import '../../../../core/enums/api_version.dart';
import '../../../../data/services/http/dio_client.dart';
import '../../../../utils/logger.dart';
import '../models/candlestick_datasource_model.dart';
import '../models/candlestick_model.dart';

class CandlestickRemoteDataSource {
  final DioClient _dioClient;

  final String _basePath = '/api/v1/trade/candles';

  CandlestickRemoteDataSource(this._dioClient);

  Future<CandlestickDataSourceModel> getHistoryCandlestick({
    required String network,
    required String tokenContractAddress,
    required String? bar,
    required String? limit,
    required String? from,
    required String? to,
    CancelToken? cancelToken,
  }) async {
    final queryParameters = {
      'network': network,
      'tokenContractAddress': tokenContractAddress,
    };

    if (bar?.isNotEmpty ?? false) {
      queryParameters['bar'] = bar.toString();
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    }
    if (from != null) {
      queryParameters['from'] = from.toString();
    }
    if (to != null) {
      queryParameters['to'] = to.toString();
    }

    final response = await _dioClient.get(
      _basePath,
      queryParameters: queryParameters,
      options: APIVersion.v2.options,
      cancelToken: cancelToken,
    );

    Logger.info('getHistoryCandlestick response: $response');

    // return (response['quotes'] as List<dynamic>)
    //     .map((e) => CandlestickModel.fromJson(e))
    //     .toList();
    return CandlestickDataSourceModel.fromJson(response);
  }

  Future<List<CandlestickModel>> getLatestCandlestick({
    required String network,
    required String tokenContractAddress,
    String? bar,
    String? limit,
    CancelToken? cancelToken,
  }) async {
    final response = await _dioClient.get(
      _basePath,
      queryParameters: {
        'network': network,
        'tokenContractAddress': tokenContractAddress,
        'bar': bar,
        'limit': limit,
        'is_latest': true,
      },
      cancelToken: cancelToken,
    );

    return (response as List<dynamic>)
        .map((e) => CandlestickModel.fromJson(e))
        .toList();
  }
}

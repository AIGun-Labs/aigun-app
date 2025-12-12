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
    required int? limit,
    required int? from,
    required int? to,
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
    // if (from != null) {
    //   queryParameters['from'] = from.toString();
    // }
    // if (to != null) {
    //   queryParameters['to'] = to.toString();
    // }

    final response = await _dioClient.get(
      _basePath,
      queryParameters: queryParameters,
      options: APIVersion.v2.options,
    );

    Logger.info('getHistoryCandlestick response: $response');

    return CandlestickDataSourceModel.fromJson(response);
  }

  Future<List<CandlestickModel>> getLatestCandlestick({
    required String network,
    required String tokenContractAddress,
    String? bar,
    int? limit,
    // bool? isInitial,
    CancelToken? cancelToken,
  }) async {
    final queryParameters = {
      'network': network,
      'tokenContractAddress': tokenContractAddress,
      'bar': bar,
      'latest': true,
    };

    limit != null ? queryParameters['limit'] = limit.toString() : null;

    // 如果 isInitial 为 true 则设置 is_initial 为 true
    //
    // if (isInitial != null && isInitial == true) {
    //   queryParameters['is_initial'] = 'true';
    // } else {
    //   queryParameters['is_latest'] = 'true';
    // }

    final response = await _dioClient.get(
      _basePath,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );

    return (response as List<dynamic>)
        .map((e) => CandlestickModel.fromJson(e))
        .toList();
  }
}

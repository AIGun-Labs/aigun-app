import 'package:dio/dio.dart';
import 'package:k_chart/flutter_k_chart.dart';

import '../../../utils/logger.dart';
import '../../models/candle/candle.dart';
import '../index.dart';

class CandleApi {
  final DioClient _dioClient;
  CandleApi(this._dioClient);

  static const String _basePath = '/api/v1/trade/candles';

  Future<List<KLineEntity>> getCandlesHistory({
    required String network,
    required String tokenContractAddress,
    required dynamic bar,
    required dynamic limit,
    bool isLatest = false,
    dynamic from,
    dynamic to,
    CancelToken? cancel,
  }) async {
    final queryParameters = {
      'network': network,
      'tokenContractAddress': tokenContractAddress,
      'bar': bar,
      'limit': limit,
      'is_latest': isLatest,
    };

    // if (from != null) {
    //   queryParameters['from'] = from;
    // }

    if (to != null) {
      queryParameters['to'] = to;
    }

    final response = await _dioClient.get(
      _basePath,
      queryParameters: queryParameters,
      cancelToken: cancel ?? CancelToken(),
    );

    // 调试日志：检查 API 返回的数据
    if (response is List && response.isEmpty) {
      Logger.info('⚠️ API 返回空数组');
    } else if (response is List && response.isNotEmpty) {
      Logger.info('✅ API 返回 ${response.length} 条K线数据');
    }

    return (response as List<dynamic>)
        .map((candle) => Candle.fromJson(candle).toKLineEntity())
        .toList();
  }
}

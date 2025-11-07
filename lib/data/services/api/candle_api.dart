import 'package:flutter_aigun/data/models/candle/candle.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:k_chart/flutter_k_chart.dart';

class CandleApi {
  final DioClient dioClient = GetIt.instance<DioClient>();
  static const String _basePath = "/api/v1/trade/candles";

  Future<List<KLineEntity>> getCandlesHistory(
      {required String network,
      required String tokenContractAddress,
      required dynamic bar,
      required dynamic limit,
      bool isLatest = false,
      dynamic from,
      dynamic to,
      CancelToken? cancel}) async {
    final queryParameters = {
      "network": network,
      "tokenContractAddress": tokenContractAddress,
      "bar": bar,
      "limit": limit,
      "is_latest": isLatest
    };

    if (from != null) {
      queryParameters["from"] = from;
    }

    if (to != null) {
      queryParameters['to'] = to;
    }

    final response = await dioClient.get(_basePath,
        queryParameters: queryParameters, cancelToken: cancel ?? CancelToken());

    // 调试日志：检查 API 返回的数据
    if (response is List && response.isEmpty) {
      print('⚠️ API 返回空数组');
    } else if (response is List && response.isNotEmpty) {
      print('✅ API 返回 ${response.length} 条K线数据');
      print('第一条数据示例: ${response.first}');
    }

    return (response as List<dynamic>)
        .map((candle) => Candle.fromJson(candle).toKLineEntity())
        .toList();
  }
}

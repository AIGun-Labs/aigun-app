import 'package:flutter_aigun/data/models/candle/candle.dart';
import 'package:flutter_aigun/data/services/index.dart';
import 'package:get_it/get_it.dart';

class CandleApi {
  final DioClient dioClient = GetIt.instance<DioClient>();
  static const String _basePath = "/api/v1/trade/candles";

  Future<List<Candle>> getCandlesHistory(
      {required String network,
      required String tokenContractAddress,
      required int bar,
      required int limit,
      bool isLatest = false,
      int? from,
      int? to}) async {
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

    final response =
        await dioClient.get(_basePath, queryParameters: queryParameters);

    return (response as List<dynamic>)
        .map((candle) => Candle.fromJson(candle))
        .toList();
  }
}

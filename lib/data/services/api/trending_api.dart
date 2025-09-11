import 'package:flutter_aigun/data/models/trending/index.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:get_it/get_it.dart';

class TrendingApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  static const String _basePath = "/api/v1/intelligence";

// TODO：LastestToken 改成 LatestToken 记得改
  Future<List<LastestToken>> getLastestTokens() async {
    final response = await _dioClient.get("$_basePath/latest-tokens");

    if (response == null) {
      throw Exception('API response is null');
    }

    if (response is! List<dynamic>) {
      throw Exception('API response is not a list: ${response.runtimeType}');
    }

    return response.map((token) {
      if (token['id'] == null) {

      }


       return LastestToken.fromJson(token);
    }).toList();
  }
}

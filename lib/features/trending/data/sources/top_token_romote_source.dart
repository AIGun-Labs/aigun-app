import '../../../../data/services/http/dio_client.dart';
import '../models/top_token_model.dart';

class TopTokenRemoteSource {
  final DioClient _dioClient;
  TopTokenRemoteSource(this._dioClient);

  static const String _basePath = '/api/v1/intelligence';

  static const String _topTokensPath = '$_basePath/token/latest';

  Future<List<TopTokenModel>> fetchTopTokens(String? lastQueryTime) async {
    try {
      final response =
          await _dioClient.get<List<dynamic>>(_topTokensPath, queryParameters: {
        'last_query_time': lastQueryTime,
      });
      return response.map((e) => TopTokenModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

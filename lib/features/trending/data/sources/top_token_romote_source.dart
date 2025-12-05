import '../../../../data/services/http/dio_client.dart';
import '../models/realtime_model.dart';
import '../models/realtime_request_model.dart';
import '../models/top_token_model.dart';

class TopTokenRemoteSource {
  final DioClient _dioClient;
  TopTokenRemoteSource(this._dioClient);

  static const String _basePath = '/api/v1/intelligence';

  static const String _topTokensPath = '$_basePath/token/latest';

  static const String _topTokenRealtimePath = '/api/v1/trade/tokens-realtime';

  Future<List<TopTokenModel>> fetchTopTokens(String? lastTime) async {
    final queryParameters = <String, dynamic>{};
    if (lastTime != null && lastTime.trim() != '') {
      queryParameters['last_query_time'] = lastTime;
    }

    try {
      final response = await _dioClient.get<List<dynamic>>(
        _topTokensPath,
        queryParameters: queryParameters,
      );
      return response.map((e) => TopTokenModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RealtimeModel>> fetchTopTokenRealtime(
    List<RealtimeRequestModel> data,
  ) async {
    final response = await _dioClient.post<List<dynamic>>(
      _topTokenRealtimePath,
      data: data.map((e) => e.toJson()).toList(),
    );
    return response.map((e) => RealtimeModel.fromJson(e)).toList();
  }
}

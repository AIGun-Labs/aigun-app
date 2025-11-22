import '../../models/index.dart' show AiAgent;
import '../../models/trending/index.dart';
import '../http/dio_client.dart';

class TrendingApi {
  final DioClient _dioClient;
  TrendingApi(this._dioClient);

  static const String _basePath = '/api/v1/intelligence';

  static const String _agentPath = '/api/v1/intel-user/ai-agents';

  Future<List<LatestToken>> getLastestTokens(
      {String? lastQueryTime = ''}) async {
    final queryParameters = <String, dynamic>{};
    if (lastQueryTime?.trim() != '') {
      queryParameters['last_query_time'] = lastQueryTime;
    }

    final response = await _dioClient.get('$_basePath/token/latest',
        queryParameters: queryParameters);

    if (response == null) {
      throw Exception('API response is null');
    }

    if (response is! List<dynamic>) {
      throw Exception('API response is not a list: ${response.runtimeType}');
    }

    return response.map((token) {
      if (token['id'] == null) {}

      return LatestToken.fromJson(token);
    }).toList();
  }

  //特工列表
  Future<List<AiAgent>> getAiAgents() async {
    final response = await _dioClient.get(
      '$_agentPath/follow-info',
    );

    if (response == null) {
      throw Exception('API response is null');
    }

    if (response is! List<dynamic>) {
      throw Exception('API response is not a list: ${response.runtimeType}');
    }

    return response.map((agent) => AiAgent.fromJson(agent)).toList();
  }

  //关注特工
  Future<void> followAiAgent(
      {required String agentId, required String subsetId}) async {
    await _dioClient.post('$_agentPath/follow', data: {
      'ai_agent_id': agentId,
      'subset_id': subsetId,
    });
  }

  //取消关注特工
  Future<void> unfollowAiAgent(
      {required String agentId, required String subsetId}) async {
    await _dioClient.delete('$_agentPath/follow', data: {
      'ai_agent_id': agentId,
      'subset_id': subsetId,
    });
  }
}

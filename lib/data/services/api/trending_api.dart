import 'package:flutter_aigun/data/models/trending/index.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:get_it/get_it.dart';

import '../../models/index.dart' show AiAgent;

class TrendingApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();

  static const String _basePath = "/api/v1/intelligence";

  static const String _agentPath = "/api/v1/ai-agents";

// TODO：LastestToken 改成 LatestToken 记得改
  Future<List<LastestToken>> getLastestTokens() async {
    final response = await _dioClient.get("$_basePath/token/latest");

    if (response == null) {
      throw Exception('API response is null');
    }

    if (response is! List<dynamic>) {
      throw Exception('API response is not a list: ${response.runtimeType}');
    }

    return response.map((token) {
      if (token['id'] == null) {}

      return LastestToken.fromJson(token);
    }).toList();
  }

  //特工列表
  Future<List<AiAgent>> getAiAgents({int? page, int? pageSize}) async {
    Map<String, dynamic>? queryParameters;

    // 如果提供了分页参数，则添加到查询参数中
    if (page != null && pageSize != null) {
      queryParameters = {
        'page': page,
        'pageSize': pageSize,
      };
    }

    final response = await _dioClient.get(
      "$_agentPath/follow-info",
      queryParameters: queryParameters,
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
    await _dioClient.post("$_agentPath/follow", data: {
      'ai_agent_id': agentId,
      'subset_id': subsetId,
    });
  }

  //取消关注特工
  Future<void> unfollowAiAgent(
      {required String agentId, required String subsetId}) async {
    await _dioClient.delete("$_agentPath/follow", data: {
      'ai_agent_id': agentId,
      'subset_id': subsetId,
    });
  }
}

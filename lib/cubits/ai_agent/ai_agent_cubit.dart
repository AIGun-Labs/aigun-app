import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/cubits/ai_agent/ai_agent_state.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/trending/ai_agent/ai_agent.dart';
import 'package:flutter_aigun/data/services/api/trending_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AiAgentCubit extends Cubit<AiAgentState> {
  final TrendingApi _trendingApi = GetIt.instance<TrendingApi>();

  AiAgentCubit() : super(const AiAgentState()) {
    init();
  }

  void init() {
    getAiAgents();
  }

  /// 获取 AI 特工列表
  Future<void> getAiAgents() async {
    emit(const AiAgentState(status: AiAgentStatus.loading()));

    try {
      final agents = await _trendingApi.getAiAgents();
      emit(state.copyWith(
        agents: agents,
        status: AiAgentStatus.success(agents),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AiAgentStatus.error(e.toString()),
      ));
    }
  }

  /// 刷新 AI 特工列表
  Future<void> refreshAgents() async {
    await getAiAgents();
  }

  /// 关注特工
  Future<void> followAgent(AiAgent agent) async {
    try {
      await _trendingApi.followAiAgent(
        agentId: agent.id,
        subsetId: agent.subsetId,
      );

      // 更新本地状态
      final updatedAgents = state.agents.map((a) {
        if (a.id == agent.id) {
          return a.copyWith(isFollowed: true);
        }
        return a;
      }).toList();

      await getIt<IntelCubit>().connectWebSocket();

      emit(state.copyWith(
        agents: updatedAgents,
        status: AiAgentStatus.success(updatedAgents),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AiAgentStatus.error(e.toString()),
      ));
    }
  }

  /// 取消关注特工
  Future<void> unfollowAgent(AiAgent agent) async {
    try {
      await _trendingApi.unfollowAiAgent(
        agentId: agent.id,
        subsetId: agent.subsetId,
      );

      // 更新本地状态
      final updatedAgents = state.agents.map((a) {
        if (a.id == agent.id) {
          return a.copyWith(isFollowed: false);
        }
        return a;
      }).toList();

      emit(state.copyWith(
        agents: updatedAgents,
        status: AiAgentStatus.success(updatedAgents),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AiAgentStatus.error(e.toString()),
      ));
    }
  }

  /// 切换关注状态
  Future<void> toggleFollowAgent(AiAgent agent) async {
    if (agent.isFollowed) {
      await unfollowAgent(agent);
    } else {
      await followAgent(agent);
    }
  }

  /// 判断特工是否已关注
  bool isFollowed(String agentId) {
    return state.agents.any((agent) => agent.id == agentId && agent.isFollowed);
  }

  /// 根据 ID 获取特工
  AiAgent? getAgentById(String agentId) {
    try {
      return state.agents.firstWhere((agent) => agent.id == agentId);
    } catch (e) {
      return null;
    }
  }
}

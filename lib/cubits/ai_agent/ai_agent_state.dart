import 'package:flutter_aigun/data/models/trending/ai_agent/ai_agent.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_agent_state.freezed.dart';

@freezed
class AiAgentStatus with _$AiAgentStatus {
  const factory AiAgentStatus.initial() = _Initial;
  const factory AiAgentStatus.loading() = _Loading;
  const factory AiAgentStatus.success(List<AiAgent> agents) = _Success;
}

@freezed
class AiAgentState with _$AiAgentState {
  const factory AiAgentState({
    @Default([]) List<AiAgent> agents,
    @Default(AiAgentStatus.initial()) AiAgentStatus status,
  }) = _AiAgentState;
}

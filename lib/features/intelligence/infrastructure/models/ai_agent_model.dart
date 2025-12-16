import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';

part 'ai_agent_model.freezed.dart';
part 'ai_agent_model.g.dart';

@freezed
sealed class IntelligenceAIAgentModel with _$IntelligenceAIAgentModel {
  const factory IntelligenceAIAgentModel({
    MultilingualModel? name,
    String? avatar,
  }) = _IntelligenceAIAgentModel;

  factory IntelligenceAIAgentModel.fromJson(Map<String, dynamic> json) =>
      _$IntelligenceAIAgentModelFromJson(json);
}

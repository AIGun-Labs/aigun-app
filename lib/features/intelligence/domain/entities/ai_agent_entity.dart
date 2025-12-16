import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/data/models/multilingual_model.dart';

part 'ai_agent_entity.freezed.dart';

/// AI Agent Entity
///
/// Represents an AI agent that generates intelligence
@freezed
sealed class AIAgentEntity with _$AIAgentEntity {
  const factory AIAgentEntity({MultilingualModel? name, String? avatar}) =
      _AIAgentEntity;
  const AIAgentEntity._();

  /// Get English name
  String? get englishName => name?.en;

  /// Get Chinese name
  String? get chineseName => name?.zh;

  /// Check if avatar is available
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;
}

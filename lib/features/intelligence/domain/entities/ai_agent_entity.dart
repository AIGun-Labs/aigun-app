import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_agent_entity.freezed.dart';

/// AI Agent Entity
///
/// Represents an AI agent that generates intelligence
@freezed
sealed class AIAgentEntity with _$AIAgentEntity {
  const AIAgentEntity._();

  const factory AIAgentEntity({
    Map<String, String>? name,
    String? avatar,
  }) = _AIAgentEntity;

  /// Get localized name based on language code
  String? getLocalizedName(String languageCode) {
    if (name == null) return null;
    return name![languageCode] ?? name!['en'] ?? name!.values.firstOrNull;
  }

  /// Get English name
  String? get englishName => name?['en'];

  /// Get Chinese name
  String? get chineseName => name?['zh'];

  /// Check if avatar is available
  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;
}

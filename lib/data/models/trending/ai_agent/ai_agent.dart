import 'package:freezed_annotation/freezed_annotation.dart';

import '../../language/language.dart';

part 'ai_agent.freezed.dart';
part 'ai_agent.g.dart';

@freezed
class AiAgent with _$AiAgent {
  const factory AiAgent({
    @Default('') String id,
    @Default(Multilingual()) Multilingual name,
    @Default(Multilingual()) Multilingual description,
    @Default('') String avatar,
    @Default(0) int rank,
    @JsonKey(
      name: 'is_followed',
    )
    @Default(false)
    bool isFollowed,
    @JsonKey(
      name: 'subset_id',
    )
    @Default('')
    String subsetId,
    @JsonKey(
      name: 'tag_id',
    )
    @Default('')
    String tagId,
  }) = _AiAgent;

  factory AiAgent.fromJson(Map<String, dynamic> json) =>
      _$AiAgentFromJson(json);
}

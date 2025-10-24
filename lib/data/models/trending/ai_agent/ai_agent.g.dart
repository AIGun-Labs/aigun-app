// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiAgentImpl _$$AiAgentImplFromJson(Map<String, dynamic> json) =>
    _$AiAgentImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] == null
          ? const Language()
          : Language.fromJson(json['name'] as Map<String, dynamic>),
      description: json['description'] == null
          ? const Language()
          : Language.fromJson(json['description'] as Map<String, dynamic>),
      avatar: json['avatar'] as String? ?? '',
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      isFollowed: json['is_followed'] as bool? ?? false,
      subsetId: json['subset_id'] as String? ?? '',
      tagId: json['tag_id'] as String? ?? '',
    );

Map<String, dynamic> _$$AiAgentImplToJson(_$AiAgentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'avatar': instance.avatar,
      'rank': instance.rank,
      'is_followed': instance.isFollowed,
      'subset_id': instance.subsetId,
      'tag_id': instance.tagId,
    };

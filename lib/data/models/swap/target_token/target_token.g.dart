// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TargetTokenImpl _$$TargetTokenImplFromJson(Map<String, dynamic> json) =>
    _$TargetTokenImpl(
      chainId: json['chain_id'] as String?,
      tokenName: json['token_name'] as String?,
      tokenAddress: json['token_address'] as String?,
      tokenAvatar: json['token_avatar'] as String?,
    );

Map<String, dynamic> _$$TargetTokenImplToJson(_$TargetTokenImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'token_name': instance.tokenName,
      'token_address': instance.tokenAddress,
      'token_avatar': instance.tokenAvatar,
    };

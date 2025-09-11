// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NativeTokenImpl _$$NativeTokenImplFromJson(Map<String, dynamic> json) =>
    _$NativeTokenImpl(
      chainId: (json['chain_id'] as num).toInt(),
      chainType: json['chain_type'] as String,
      chainName: json['chain_name'] as String,
      chainLogo: json['chain_logo'] as String,
      logo: json['logo'] as String? ?? "",
      name: json['name'] as String? ?? "",
      decimals: (json['decimals'] as num).toInt(),
    );

Map<String, dynamic> _$$NativeTokenImplToJson(_$NativeTokenImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'chain_type': instance.chainType,
      'chain_name': instance.chainName,
      'chain_logo': instance.chainLogo,
      'logo': instance.logo,
      'name': instance.name,
      'decimals': instance.decimals,
    };

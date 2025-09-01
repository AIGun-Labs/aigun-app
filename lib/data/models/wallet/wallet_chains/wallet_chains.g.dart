// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_chains.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletChainsImpl _$$WalletChainsImplFromJson(Map<String, dynamic> json) =>
    _$WalletChainsImpl(
      chainId: (json['chain_id'] as num).toInt(),
      chainType: json['chain_type'] as String,
      chainName: json['chain_name'] as String,
      logoUrl: json['logo_url'] as String,
      explorer: json['explorer'] as String,
    );

Map<String, dynamic> _$$WalletChainsImplToJson(_$WalletChainsImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'chain_type': instance.chainType,
      'chain_name': instance.chainName,
      'logo_url': instance.logoUrl,
      'explorer': instance.explorer,
    };

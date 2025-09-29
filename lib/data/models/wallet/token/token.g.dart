// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenImpl _$$TokenImplFromJson(Map<String, dynamic> json) => _$TokenImpl(
      chainId: (json['chain_id'] as num).toInt(),
      chainName: json['chain_name'] as String,
      chainType: json['chain_type'] as String,
      tokenAddress: json['token_address'] as String,
      symbol: json['symbol'] as String,
      balance: json['balance'] as String,
      tokenPrice: json['token_price'] as String,
      decimals: (json['decimals'] as num).toInt(),
      chainLogo: json['chain_logo'] as String,
      tokenAvatar: json['token_avatar'] as String,
      tokenName: json['token_name'] as String,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$$TokenImplToJson(_$TokenImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'chain_name': instance.chainName,
      'chain_type': instance.chainType,
      'token_address': instance.tokenAddress,
      'symbol': instance.symbol,
      'balance': instance.balance,
      'token_price': instance.tokenPrice,
      'decimals': instance.decimals,
      'chain_logo': instance.chainLogo,
      'token_avatar': instance.tokenAvatar,
      'token_name': instance.tokenName,
      'slug': instance.slug,
    };

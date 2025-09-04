// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenImpl _$$TokenImplFromJson(Map<String, dynamic> json) => _$TokenImpl(
      chainId: (json['chain_id'] as num).toInt(),
      chainLogo: json['chain_logo'] as String,
      tokenAvatar: json['token_avatar'] as String,
      tokenName: json['token_name'] as String,
      address: json['address'] as String,
      tokenPrice: json['token_price'] as String,
      rawBalance: json['raw_balance'] as String,
      balance: json['balance'] as String,
      decimals: (json['decimals'] as num).toInt(),
    );

Map<String, dynamic> _$$TokenImplToJson(_$TokenImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'chain_logo': instance.chainLogo,
      'token_avatar': instance.tokenAvatar,
      'token_name': instance.tokenName,
      'address': instance.address,
      'token_price': instance.tokenPrice,
      'raw_balance': instance.rawBalance,
      'balance': instance.balance,
      'decimals': instance.decimals,
    };

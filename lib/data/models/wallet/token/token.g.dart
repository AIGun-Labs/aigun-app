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
      isRiskToken: json['is_risk_token'] as bool,
      decimals: (json['decimals'] as num).toInt(),
      chainLogo: json['chain_logo'] as String,
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
      'is_risk_token': instance.isRiskToken,
      'decimals': instance.decimals,
      'chain_logo': instance.chainLogo,
    };

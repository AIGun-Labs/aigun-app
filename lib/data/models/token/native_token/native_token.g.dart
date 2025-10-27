// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NativeTokenImpl _$$NativeTokenImplFromJson(Map<String, dynamic> json) =>
    _$NativeTokenImpl(
      decimals: (json['decimals'] as num).toInt(),
      symbol: json['symbol'] as String,
      balance: json['balance'] as String,
      tokenPrice: json['token_price'] as String,
      chainId: json['chain_id'] as String,
      chainName: json['chain_name'] as String,
      chainType: json['chain_type'] as String,
      rawBalance: json['raw_balance'] as String,
      network: json['network'] as String,
      chainLogo: json['chain_logo'] as String,
      tokenAddress: json['token_address'] as String,
      tokenAvatar: json['token_avatar'] as String,
    );

Map<String, dynamic> _$$NativeTokenImplToJson(_$NativeTokenImpl instance) =>
    <String, dynamic>{
      'decimals': instance.decimals,
      'symbol': instance.symbol,
      'balance': instance.balance,
      'token_price': instance.tokenPrice,
      'chain_id': instance.chainId,
      'chain_name': instance.chainName,
      'chain_type': instance.chainType,
      'raw_balance': instance.rawBalance,
      'network': instance.network,
      'chain_logo': instance.chainLogo,
      'token_address': instance.tokenAddress,
      'token_avatar': instance.tokenAvatar,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      chainId: json['chain_id'] as String,
      chainName: json['chain_name'] as String,
      logoUrl: json['logo_url'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'chain_name': instance.chainName,
      'logo_url': instance.logoUrl,
      'address': instance.address,
    };

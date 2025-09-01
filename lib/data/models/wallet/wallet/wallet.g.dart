// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletAddressImpl _$$WalletAddressImplFromJson(Map<String, dynamic> json) =>
    _$WalletAddressImpl(
      chain_id: (json['chain_id'] as num?)?.toInt(),
      chain_name: json['chain_name'] as String?,
      logo_url: json['logo_url'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$WalletAddressImplToJson(_$WalletAddressImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chain_id,
      'chain_name': instance.chain_name,
      'logo_url': instance.logo_url,
      'address': instance.address,
    };

_$WalletImpl _$$WalletImplFromJson(Map<String, dynamic> json) => _$WalletImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => WalletAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WalletImplToJson(_$WalletImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'addresses': instance.addresses,
    };

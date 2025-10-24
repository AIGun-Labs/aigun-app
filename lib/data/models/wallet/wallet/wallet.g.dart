// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletAddressImpl _$$WalletAddressImplFromJson(Map<String, dynamic> json) =>
    _$WalletAddressImpl(
      chainId: json['chain_id'] as String?,
      chainName: json['chain_name'] as String?,
      logoUrl: json['logo_url'] as String?,
      addressType: json['address_type'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$WalletAddressImplToJson(_$WalletAddressImpl instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'chain_name': instance.chainName,
      'logo_url': instance.logoUrl,
      'address_type': instance.addressType,
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

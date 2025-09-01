// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletListImpl _$$WalletListImplFromJson(Map<String, dynamic> json) =>
    _$WalletListImpl(
      wallets: (json['wallets'] as List<dynamic>?)
              ?.map((e) => Wallet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WalletListImplToJson(_$WalletListImpl instance) =>
    <String, dynamic>{
      'wallets': instance.wallets,
    };

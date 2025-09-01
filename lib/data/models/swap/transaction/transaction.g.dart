// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SwapTransactionImpl _$$SwapTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$SwapTransactionImpl(
      type: json['type'] as String?,
      txHash: json['tx_hash'] as String?,
      txUrl: json['tx_url'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$SwapTransactionImplToJson(
        _$SwapTransactionImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'tx_hash': instance.txHash,
      'tx_url': instance.txUrl,
      'status': instance.status,
    };

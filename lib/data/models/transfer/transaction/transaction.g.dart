// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferTransactionImpl _$$TransferTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferTransactionImpl(
      type: json['type'] as String?,
      captcha: json['captcha'] == null
          ? null
          : Captcha.fromJson(json['captcha'] as Map<String, dynamic>),
      sms: json['sms'] == null
          ? null
          : Sms.fromJson(json['sms'] as Map<String, dynamic>),
      txHash: json['tx_hash'] as String?,
      txUrl: json['tx_url'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$TransferTransactionImplToJson(
        _$TransferTransactionImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'captcha': instance.captcha,
      'sms': instance.sms,
      'tx_hash': instance.txHash,
      'tx_url': instance.txUrl,
      'status': instance.status,
    };

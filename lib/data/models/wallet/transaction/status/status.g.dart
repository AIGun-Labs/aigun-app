// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletTransactionStatusImpl _$$WalletTransactionStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletTransactionStatusImpl(
      status:
          $enumDecodeNullable(_$TransactionStatusEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$$WalletTransactionStatusImplToJson(
        _$WalletTransactionStatusImpl instance) =>
    <String, dynamic>{
      'status': _$TransactionStatusEnumEnumMap[instance.status],
    };

const _$TransactionStatusEnumEnumMap = {
  TransactionStatusEnum.success: 'success',
  TransactionStatusEnum.pending: 'pending',
  TransactionStatusEnum.failed: 'failed',
};

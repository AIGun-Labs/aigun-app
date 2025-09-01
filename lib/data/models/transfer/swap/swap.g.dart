// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferSwapImpl _$$TransferSwapImplFromJson(Map<String, dynamic> json) =>
    _$TransferSwapImpl(
      fromChainId: (json['from_chain_id'] as num?)?.toInt(),
      toChainId: (json['to_chain_id'] as num?)?.toInt(),
      inputMint: json['input_mint'] as String?,
      outputMint: json['output_mint'] as String?,
      amount: json['amount'] as String?,
      walletId: json['wallet_id'] as String?,
      organizationId: json['organization_id'] as String?,
      walletUserId: json['wallet_user_id'] as String?,
    );

Map<String, dynamic> _$$TransferSwapImplToJson(_$TransferSwapImpl instance) =>
    <String, dynamic>{
      'from_chain_id': instance.fromChainId,
      'to_chain_id': instance.toChainId,
      'input_mint': instance.inputMint,
      'output_mint': instance.outputMint,
      'amount': instance.amount,
      'wallet_id': instance.walletId,
      'organization_id': instance.organizationId,
      'wallet_user_id': instance.walletUserId,
    };

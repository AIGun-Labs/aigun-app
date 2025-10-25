// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferQuoteImpl _$$TransferQuoteImplFromJson(Map<String, dynamic> json) =>
    _$TransferQuoteImpl(
      inputMint: json['input_mint'] as String?,
      inAmount: json['in_amount'] as String?,
      inUsdValue: json['in_usd_value'] as String?,
      outputMint: json['output_mint'] as String?,
      outUsdValue: json['out_usd_value'] as String?,
      outAmount: json['out_amount'] as String?,
      gasFee: json['gas_fee'] as String?,
      impactPrice: json['impact_price'] as String?,
    );

Map<String, dynamic> _$$TransferQuoteImplToJson(_$TransferQuoteImpl instance) =>
    <String, dynamic>{
      'input_mint': instance.inputMint,
      'in_amount': instance.inAmount,
      'in_usd_value': instance.inUsdValue,
      'output_mint': instance.outputMint,
      'out_usd_value': instance.outUsdValue,
      'out_amount': instance.outAmount,
      'gas_fee': instance.gasFee,
      'impact_price': instance.impactPrice,
    };

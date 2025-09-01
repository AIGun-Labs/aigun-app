// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SwapQuoteImpl _$$SwapQuoteImplFromJson(Map<String, dynamic> json) =>
    _$SwapQuoteImpl(
      inputMint: json['input_mint'] as String?,
      inAmount: json['in_amount'] as String?,
      inUsdValue: (json['in_usd_value'] as num?)?.toDouble(),
      outputMint: json['output_mint'] as String?,
      outAmount: json['out_amount'] as String?,
      outUsdValue: (json['out_usd_value'] as num?)?.toDouble(),
      gasFee: json['gas_fee'] as String?,
      impactPrice: json['impact_price'] as String?,
    );

Map<String, dynamic> _$$SwapQuoteImplToJson(_$SwapQuoteImpl instance) =>
    <String, dynamic>{
      'input_mint': instance.inputMint,
      'in_amount': instance.inAmount,
      'in_usd_value': instance.inUsdValue,
      'output_mint': instance.outputMint,
      'out_amount': instance.outAmount,
      'out_usd_value': instance.outUsdValue,
      'gas_fee': instance.gasFee,
      'impact_price': instance.impactPrice,
    };

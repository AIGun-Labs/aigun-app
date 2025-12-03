import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/quote_entity.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
sealed class QuoteModel with _$QuoteModel {
  const QuoteModel._();
  const factory QuoteModel({
    @JsonKey(name: 'input_mint') String? inputMint,
    @JsonKey(name: 'in_amount') String? inAmount,
    @JsonKey(name: 'in_usd_value') String? inUsdValue,
    @JsonKey(name: 'output_mint') String? outputMint,
    @JsonKey(name: 'out_usd_value') String? outUsdValue,
    @JsonKey(name: 'out_amount') String? outAmount,
    @JsonKey(name: 'gas_fee') String? gasFee,
    @JsonKey(name: 'fee') String? fee,
    @JsonKey(name: 'impact_price') String? impactPrice,
  }) = _QuoteModel;

  factory QuoteModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteModelFromJson(json);

  QuoteEntity toEntity() => QuoteEntity(
    inputMint: inputMint,
    inAmount: inAmount,
    inUsdValue: inUsdValue,
    outputMint: outputMint,
    outAmount: outAmount,
    outUsdValue: outUsdValue,
    gasFee: gasFee,
    fee: fee,
    impactPrice: impactPrice,
  );
}

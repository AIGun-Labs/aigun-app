import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_entity.freezed.dart';
part 'quote_entity.g.dart';

@freezed
sealed class QuoteEntity with _$QuoteEntity {
  const factory QuoteEntity({
    @JsonKey(name: 'input_mint') String? inputMint,
    @JsonKey(name: 'in_amount') String? inAmount,
    @JsonKey(name: 'in_usd_value') String? inUsdValue,
    @JsonKey(name: 'output_mint') String? outputMint,
    @JsonKey(name: 'out_usd_value') String? outUsdValue,
    @JsonKey(name: 'out_amount') String? outAmount,
    @JsonKey(name: 'gas_fee') String? gasFee,
    @JsonKey(name: 'fee') String? fee,
    @JsonKey(name: 'impact_price') String? impactPrice,
  }) = _QuoteEntity;

  factory QuoteEntity.fromJson(Map<String, dynamic> json) =>
      _$QuoteEntityFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';
part 'quote.g.dart';

@freezed
sealed class SwapQuote with _$SwapQuote {
  const factory SwapQuote({
    @JsonKey(name: 'input_mint') String? inputMint, //
    @JsonKey(name: 'in_amount') String? inAmount,
    @JsonKey(name: 'in_usd_value') double? inUsdValue,
    @JsonKey(name: 'output_mint') String? outputMint,
    @JsonKey(name: 'out_amount') String? outAmount,
    @JsonKey(name: 'out_usd_value') double? outUsdValue,
    @JsonKey(name: 'gas_fee') String? gasFee,
    @JsonKey(name: 'impact_price') String? impactPrice,
  }) = _SwapQuote;

  factory SwapQuote.fromJson(Map<String, dynamic> json) =>
      _$SwapQuoteFromJson(json);
}

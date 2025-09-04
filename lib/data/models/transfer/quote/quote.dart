import 'package:freezed_annotation/freezed_annotation.dart';

part "quote.freezed.dart";
part "quote.g.dart";

@freezed
class TransferQuote with _$TransferQuote {
  const factory TransferQuote({
    @JsonKey(name: "input_mint") String? inputMint,
    @JsonKey(name: "in_amount") String? inAmount,
    @JsonKey(name: "in_usd_value") String? inUsdValue,
    @JsonKey(name: "output_mint") String? outputMint,
    @JsonKey(name: "out_usd_value") int? outUsdValue,
    @JsonKey(name: "out_amount") String? outAmount,
    @JsonKey(name: "gas_fee") int? gasFee,
    @JsonKey(name: "impact_price") int? impactPrice,
  }) = _TransferQuote;

  factory TransferQuote.fromJson(Map<String, dynamic> json) =>
      _$TransferQuoteFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap.freezed.dart';
part 'swap.g.dart';

@freezed
sealed class TransferSwap with _$TransferSwap {
  const factory TransferSwap({
    @JsonKey(name: 'from_chain_id') int? fromChainId,
    @JsonKey(name: 'to_chain_id') int? toChainId,
    @JsonKey(name: 'input_mint') String? inputMint,
    @JsonKey(name: 'output_mint') String? outputMint,
    @JsonKey(name: 'amount') String? amount,
    @JsonKey(name: 'wallet_id') String? walletId,
    @JsonKey(name: 'organization_id') String? organizationId,
    @JsonKey(name: 'wallet_user_id') String? walletUserId,
  }) = _TransferSwap;

  factory TransferSwap.fromJson(Map<String, dynamic> json) =>
      _$TransferSwapFromJson(json);
}

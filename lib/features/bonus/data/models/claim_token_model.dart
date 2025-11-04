import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_token_model.freezed.dart';
part 'claim_token_model.g.dart';

@freezed
class ClaimTokenModel with _$ClaimTokenModel {
  @JsonSerializable(checked: true)
  const factory ClaimTokenModel(
      {@JsonKey(defaultValue: '') required String network,
      @JsonKey(name: "contract_address", defaultValue: '')
      required String contractAddress,
      @JsonKey(defaultValue: '') required String symbol,
      @JsonKey(name: "chain_name", defaultValue: '') required String chainName,
      @JsonKey(defaultValue: '') required String logo,
      @JsonKey(defaultValue: '') required String price,
      @JsonKey(defaultValue: '') required String amount,
      @JsonKey(name: "min_claim_amount", defaultValue: '')
      required String minClaimAmount,
      @JsonKey(name: "claimable_amount", defaultValue: '')
      required String claimableAmount,
      @JsonKey(defaultValue: 0) required int rank}) = _ClaimTokenModel;

  factory ClaimTokenModel.fromJson(Map<String, dynamic> json) =>
      _$ClaimTokenModelFromJson(json);
}

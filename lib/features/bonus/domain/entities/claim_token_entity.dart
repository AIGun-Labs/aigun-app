import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_token_entity.freezed.dart';

@freezed
class ClaimTokenEntity with _$ClaimTokenEntity {
  const ClaimTokenEntity._();

  const factory ClaimTokenEntity({
    required String network,
    required String contract,
    required String chainName,
    required String symbol,
    required String logo,
    required String price,
    required String amount,
    required String minClaimAmount,
    required String claimableAmount,
    required int rank,
  }) = _ClaimTokenEntity;

  double get amountDouble => (double.tryParse(amount) ?? 0.0);

  double get minClaimAmountDouble => (double.tryParse(minClaimAmount) ?? 0.0);

  double get claimableAmountDouble =>
      amountDouble >= minClaimAmountDouble ? amountDouble : 0.0;
}

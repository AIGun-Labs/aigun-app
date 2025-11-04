import '../../domain/entities/claim_token_entity.dart';
import '../models/claim_token_model.dart';

extension ClaimTokenMapper on ClaimTokenModel {
  ClaimTokenEntity toEntity() {
    return ClaimTokenEntity(
      network: network,
      contract: contractAddress,
      chainName: chainName,
      symbol: symbol,
      logo: logo,
      price: price,
      amount: amount,
      minClaimAmount: minClaimAmount,
      claimableAmount: claimableAmount,
      rank: rank,
    );
  }
}

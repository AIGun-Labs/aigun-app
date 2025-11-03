import 'package:flutter_aigun/core/types/result.dart';

import '../entities/claim_token_entity.dart';

abstract class ClaimTokenRepo {
  Future<Result<List<ClaimTokenEntity>>> fetchUnclaimedTokens();

  Future<Result<bool>> claimToken(
      String network, String contract, String amount);
}

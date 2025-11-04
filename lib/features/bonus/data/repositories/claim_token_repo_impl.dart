import 'package:flutter_aigun/core/types/result.dart';
import 'package:flutter_aigun/features/bonus/data/mappers/claim_token_mapper.dart';

import 'package:flutter_aigun/features/bonus/domain/entities/claim_token_entity.dart';

import '../../domain/repositories/claim_token_repo.dart';
import '../sources/claim_token_remote_source.dart';

class ClaimTokenRepoImpl implements ClaimTokenRepo {
  final ClaimTokenRemoteSource _remote;

  ClaimTokenRepoImpl(this._remote);

  @override
  Future<Result<bool>> claimToken(
      String network, String contract, String amount) async {
    try {
      final result = await _remote.fetchClaimToken(network, contract, amount);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<ClaimTokenEntity>>> fetchUnclaimedTokens() async {
    try {
      final result = await _remote.fetchUnclaimedTokens();
      return Result.success(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/claim_token_entity.dart';

part 'claim_token_state.freezed.dart';

@freezed
class ClaimTokenState with _$ClaimTokenState {
  const factory ClaimTokenState.initial() = _Initial;
  const factory ClaimTokenState.loading() = _Loading;
  const factory ClaimTokenState.success(
      List<ClaimTokenEntity> unclaimedTokens) = _Success;
  const factory ClaimTokenState.error(String message) = _Error;
}

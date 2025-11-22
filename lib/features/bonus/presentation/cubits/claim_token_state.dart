part of 'claim_token_cubit.dart';

@freezed
class ClaimTokenState with _$ClaimTokenState {
  const factory ClaimTokenState.initial() = _Initial;
  const factory ClaimTokenState.loading() = _Loading;
  const factory ClaimTokenState.success(
      List<ClaimTokenEntity> unclaimedTokens) = _Success;
  const factory ClaimTokenState.error(String message) = _Error;
}

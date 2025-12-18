part of 'invite_cubit.dart';

enum InviteStateStatus { initial, loading, success, error }

enum InviteStateEffect {
  claimGoldSuccess,
  claimGoldFailure,
  bindInviteSuccess,
  bindInviteFailure,
}

@freezed
class InviteState with _$InviteState {
  const InviteState({
    this.status = InviteStateStatus.initial,
    this.inviteInfo,
    this.errorMessage,
    this.effect,
  });

  @override
  final InviteStateStatus status;
  @override
  final InviteInfoEntity? inviteInfo;
  @override
  final String? errorMessage;
  @override
  final InviteStateEffect? effect;
}

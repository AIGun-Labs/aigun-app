part of 'invite_cubit.dart';

enum InviteStateStatus { initial, loading, success, error }

enum InviteStateEffect {
  claimGoldSuccess,
  claimGoldFailure,
  bindInviteSuccess,
  bindInviteFailure,
}

enum InviteFailureType { format, invalid }

@freezed
sealed class InviteCodeStatus with _$InviteCodeStatus {
  const factory InviteCodeStatus.initial() = _Initial;
  const factory InviteCodeStatus.success() = _Success;
  const factory InviteCodeStatus.error(InviteFailureType type) = _Error;
}

@freezed
class InviteState with _$InviteState {
  const InviteState({
    this.status = InviteStateStatus.initial,
    this.inviteInfo,
    this.errorMessage,
    this.effect,
    this.inviteCodeStatus = const InviteCodeStatus.initial(),
    this.inviteCode = '',
  });

  @override
  final InviteStateStatus status;
  @override
  final InviteInfoEntity? inviteInfo;
  @override
  final String? errorMessage;
  @override
  final InviteStateEffect? effect;
  @override
  final InviteCodeStatus inviteCodeStatus;

  @override
  final String inviteCode;
}

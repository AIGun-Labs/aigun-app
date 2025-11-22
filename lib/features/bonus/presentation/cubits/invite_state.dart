part of 'invite_cubit.dart';

@freezed
class InviteState with _$InviteState {
  const factory InviteState.initial() = _Initial;
  const factory InviteState.loading() = _Loading;
  const factory InviteState.success(InviteInfoEntity inviteInfo) = _Success;
  const factory InviteState.error(String message) = _Error;
}

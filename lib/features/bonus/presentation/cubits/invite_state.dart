import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/invite_info_entity.dart';

part 'invite_state.freezed.dart';

@freezed
class InviteState with _$InviteState {
  const factory InviteState.initial() = _Initial;
  const factory InviteState.loading() = _Loading;
  const factory InviteState.success(InviteInfoEntity inviteInfo) = _Success;
  const factory InviteState.error(String message) = _Error;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_entity.freezed.dart';

/// Auth User Entity - Domain layer representation of a user
///
/// This entity contains only the essential user information needed
/// for the authentication flow.
@freezed
sealed class AuthUserEntity with _$AuthUserEntity {
  const AuthUserEntity._();

  const factory AuthUserEntity({
    required String pk,
    String? tid,
    required String email,
    required String nickname,
    required String avatar,
    required String inviteCode,
    String? superiorId,
    String? ancestorId,
    required String? inviteAmount,
    required String? indirectInviteAmount,
    required String expandInviteList,
    required String cn,
    required String c0,
    required String sn,
    required String s0,
    required String t0,
    required String claimedAmount,
    required String destroyedAmount,
    required String receivedAt,
    required String rewardClaimedAmount,
    required String rewardDestroyedAmount,
    required String rewardUnclaimedAmount,
    required String rewardT0,
    required String createdAt,
    required String isActive,
    required String isObsolete,
    required String roleId,
    required String deviceId,
    String? walletUserId,
    String? organizationId,
  }) = _AuthUserEntity;

  /// Check if user has completed profile setup
  bool get hasNickname => nickname.isNotEmpty;

  /// Check if user has an invite code
  bool get hasInviteCode => inviteCode.isNotEmpty;
}

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
    required String id,
    required String email,
    String? nickname,
    String? avatar,
    String? inviteCode,
    DateTime? createdAt,
  }) = _AuthUserEntity;

  /// Check if user has completed profile setup
  bool get hasNickname => nickname != null && nickname!.isNotEmpty;

  /// Check if user has an invite code
  bool get hasInviteCode => inviteCode != null && inviteCode!.isNotEmpty;
}

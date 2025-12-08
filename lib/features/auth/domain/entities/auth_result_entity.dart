import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_token_entity.dart';
import 'auth_user_entity.dart';

part 'auth_result_entity.freezed.dart';

/// Auth Result Entity - Sealed union representing authentication outcomes
///
/// This entity represents all possible outcomes of authentication operations:
/// - [existingUser]: User already exists and is now authenticated
/// - [newUserRequired]: User needs to complete registration
/// - [registered]: User has successfully registered
@freezed
sealed class AuthResultEntity with _$AuthResultEntity {
  const AuthResultEntity._();

  /// Verification successful - existing user authenticated
  const factory AuthResultEntity.existingUser({
    required AuthUserEntity user,
    required AuthTokenEntity tokens,
  }) = AuthResultExistingUser;

  /// Verification successful - but user needs to register (new user)
  const factory AuthResultEntity.newUserRequired() = AuthResultNewUserRequired;

  /// Registration successful
  const factory AuthResultEntity.registered({
    required AuthUserEntity user,
    required AuthTokenEntity tokens,
    required bool hasInviteCode,
  }) = AuthResultRegistered;

  /// Check if the result indicates authentication success
  bool get isAuthenticated => maybeWhen(
        existingUser: (_, __) => true,
        registered: (_, __, ___) => true,
        orElse: () => false,
      );

  /// Get user if authenticated
  AuthUserEntity? get user => whenOrNull(
        existingUser: (user, _) => user,
        registered: (user, _, __) => user,
      );

  /// Get tokens if authenticated
  AuthTokenEntity? get tokens => whenOrNull(
        existingUser: (_, tokens) => tokens,
        registered: (_, tokens, __) => tokens,
      );
}

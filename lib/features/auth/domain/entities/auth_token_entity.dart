import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token_entity.freezed.dart';

/// Auth Token Entity - Domain layer representation of authentication tokens
@freezed
sealed class AuthTokenEntity with _$AuthTokenEntity {
  const AuthTokenEntity._();

  const factory AuthTokenEntity({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokenEntity;

  /// Check if tokens are valid (non-empty)
  bool get isValid => accessToken.isNotEmpty && refreshToken.isNotEmpty;
}

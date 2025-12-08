import '../../domain/entities/auth_token_entity.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../models/auth_response_model.dart';
import '../models/auth_user_model.dart';

/// Extension to convert AuthUserModel to AuthUserEntity
extension AuthUserModelMapper on AuthUserModel {
  AuthUserEntity toEntity() => AuthUserEntity(
        id: id ?? '',
        email: email ?? '',
        nickname: nickname,
        avatar: avatar,
        inviteCode: inviteCode,
        createdAt: createdAt,
      );
}

/// Extension to convert AuthUserEntity to AuthUserModel
extension AuthUserEntityMapper on AuthUserEntity {
  AuthUserModel toModel() => AuthUserModel(
        id: id,
        email: email,
        nickname: nickname,
        avatar: avatar,
        inviteCode: inviteCode,
        createdAt: createdAt,
      );
}

/// Extension to extract tokens from AuthResponseModel
extension AuthResponseModelMapper on AuthResponseModel {
  /// Check if response contains valid authentication data
  bool get hasValidAuth =>
      user != null &&
      accessToken != null &&
      accessToken!.isNotEmpty &&
      refreshToken != null &&
      refreshToken!.isNotEmpty;

  /// Extract token entity from response
  AuthTokenEntity? toTokenEntity() {
    if (accessToken == null || refreshToken == null) return null;
    return AuthTokenEntity(
      accessToken: accessToken!,
      refreshToken: refreshToken!,
    );
  }

  /// Extract user entity from response
  AuthUserEntity? toUserEntity() => user?.toEntity();
}

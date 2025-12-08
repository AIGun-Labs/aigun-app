import 'dart:convert';

import '../../../../utils/storage/secure/token_storage_service.dart';
import '../../../../utils/storage/secure/user_storage_service.dart';
import '../models/auth_user_model.dart';

/// Auth Local Data Source
///
/// Handles local storage operations for authentication data.
/// Uses secure storage for sensitive data like tokens.
class AuthLocalSource {
  final TokenStorageService _tokenStorage;
  final UserStorageService _userStorage;

  AuthLocalSource(this._tokenStorage, this._userStorage);

  // ==================== Token Operations ====================

  /// Save authentication tokens to secure storage
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _tokenStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// Get stored access token
  Future<String?> getAccessToken() async {
    return await _tokenStorage.getAccessToken();
  }

  /// Get stored refresh token
  Future<String?> getRefreshToken() async {
    return await _tokenStorage.getRefreshToken();
  }

  /// Get both tokens as a tuple
  Future<(String?, String?)> getTokens() async {
    final access = await _tokenStorage.getAccessToken();
    final refresh = await _tokenStorage.getRefreshToken();
    return (access, refresh);
  }

  /// Clear stored tokens
  Future<void> clearTokens() async {
    await _tokenStorage.deleteTokens();
  }

  // ==================== User Operations ====================

  /// Save user model to storage
  ///
  /// Note: We save the AuthUserModel as JSON string, but the underlying
  /// storage uses the legacy User model format for compatibility.
  Future<void> saveUser(AuthUserModel user) async {
    // Convert to JSON and save
    final json = {
      'pk': user.id,
      'email': user.email,
      'nickname': user.nickname,
      'avatar': user.avatar,
      'invite_code': user.inviteCode,
      'created_at': user.createdAt?.toIso8601String(),
    };
    await _userStorage.saveUser(jsonEncode(json));
  }

  /// Get stored user model
  ///
  /// Note: The underlying storage returns a legacy User model,
  /// so we convert it to our AuthUserModel.
  Future<AuthUserModel?> getUser() async {
    try {
      final user = await _userStorage.getUser();
      // Convert legacy User to AuthUserModel
      // Note: user.createdAt is a String in the legacy model
      DateTime? createdAt;
      try {
        createdAt = DateTime.tryParse(user.createdAt);
      } catch (_) {
        // Ignore parse errors
      }
      return AuthUserModel(
        id: user.pk,
        email: user.email,
        nickname: user.nickname,
        avatar: user.avatar,
        inviteCode: user.inviteCode,
        createdAt: createdAt,
      );
    } catch (e) {
      // User not found or parsing error
      return null;
    }
  }

  /// Clear stored user data
  Future<void> clearUser() async {
    await _userStorage.deleteUser();
  }

  // ==================== Combined Operations ====================

  /// Clear all authentication data (tokens + user)
  Future<void> clearAll() async {
    await Future.wait([
      clearTokens(),
      clearUser(),
    ]);
  }
}

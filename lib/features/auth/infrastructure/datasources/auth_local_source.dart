import '../../../../core/services/secure_token_storage_service.dart';
import '../../../../core/services/secure_user_storage_service.dart';
import '../models/auth_user_model.dart';

/// Auth Local Data Source
///
/// Handles local storage operations for authentication data.
/// Uses secure storage for sensitive data like tokens.
class AuthLocalSource {
  AuthLocalSource(this._tokenStorage, this._userStorage);
  final SecureTokenStorageService _tokenStorage;
  final SecureUserStorageService _userStorage;

  // ==================== Token Operations ====================

  /// Save authentication tokens to secure storage
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _tokenStorage.writeTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// Get stored access token
  Future<String?> getAccessToken() async {
    return await _tokenStorage.readAccessToken();
  }

  /// Get stored refresh token
  Future<String?> getRefreshToken() async {
    return await _tokenStorage.readRefreshToken();
  }

  /// Get both tokens as a tuple
  Future<(String?, String?)> getTokens() async {
    final access = await _tokenStorage.readAccessToken();
    final refresh = await _tokenStorage.readRefreshToken();
    return (access, refresh);
  }

  /// Clear stored tokens
  Future<void> clearTokens() async {
    await _tokenStorage.clearTokens();
  }

  // ==================== User Operations ====================

  /// Save user model to storage
  ///
  /// Note: We save the AuthUserModel as JSON string, but the underlying
  /// storage uses the legacy User model format for compatibility.
  Future<void> saveUser(AuthUserModel user) async {
    // Convert to JSON and save

    await _userStorage.writeUserInfo(user);
  }

  /// Get stored user model
  ///
  /// Note: The underlying storage returns a legacy User model,
  /// so we convert it to our AuthUserModel.
  Future<AuthUserModel?> getUser() async {
    try {
      final user = await _userStorage.readUserInfo();
      // Convert legacy User to AuthUserModel
      // Note: user.createdAt is a String in the legacy model
      DateTime? createdAt;
      try {
        createdAt = DateTime.tryParse(user.createdAt);
      } catch (_) {
        // Ignore parse errors
      }
      return AuthUserModel.fromJson(user.toJson());
    } catch (e) {
      // User not found or parsing error
      return null;
    }
  }

  /// Clear stored user data
  Future<void> clearUser() async {
    await _userStorage.clearUserInfo();
  }

  // ==================== Combined Operations ====================

  /// Clear all authentication data (tokens + user)
  Future<void> clearAll() async {
    await Future.wait([clearTokens(), clearUser()]);
  }
}

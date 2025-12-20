abstract interface class SecureTokenStorageService {
  Future<void> writeTokens({String? accessToken, String? refreshToken});

  Future<String?> readAccessToken();

  Future<String?> readRefreshToken();

  Future<void> clearTokens();

  Future<({String? access, String? refresh})> readTokens();
}

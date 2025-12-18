import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constant/storage_keys.dart';

class TokenStorageService {
  TokenStorageService(this._storage);
  static const _accessTokenKey = StorageKeys.accessToken;
  static const _refreshTokenKey = StorageKeys.refreshToken;

  final FlutterSecureStorage _storage;

  Future<void> saveTokens({String? accessToken, String? refreshToken}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<bool> hasAccessToken() async {
    return await _storage.containsKey(key: _accessTokenKey);
  }
}

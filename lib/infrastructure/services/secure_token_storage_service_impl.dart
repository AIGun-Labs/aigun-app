import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constant/storage_keys.dart';
import '../../core/services/secure_token_storage_service.dart';

class SecureTokenStorageServiceImpl implements SecureTokenStorageService {
  SecureTokenStorageServiceImpl(this._storage);
  static const _accessTokenKey = StorageKeys.accessToken;
  static const _refreshTokenKey = StorageKeys.refreshToken;

  final FlutterSecureStorage _storage;

  @override
  Future<void> writeTokens({String? accessToken, String? refreshToken}) async {
    final tasks = <Future<void>>[];
    if (accessToken != null) {
      tasks.add(_storage.write(key: _accessTokenKey, value: accessToken));
    }
    if (refreshToken != null) {
      tasks.add(_storage.write(key: _refreshTokenKey, value: refreshToken));
    }
    await Future.wait(tasks);
  }

  @override
  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);

  @override
  Future<String?> readRefreshToken() => _storage.read(key: _refreshTokenKey);

  @override
  Future<void> clearTokens() async {
    final tasks = <Future<void>>[];
    tasks.add(_storage.delete(key: _accessTokenKey));
    tasks.add(_storage.delete(key: _refreshTokenKey));
    await Future.wait(tasks);
  }

  @override
  Future<({String? access, String? refresh})> readTokens() async {
    final results = await Future.wait([readAccessToken(), readRefreshToken()]);
    return (access: results[0], refresh: results[1]);
  }
}

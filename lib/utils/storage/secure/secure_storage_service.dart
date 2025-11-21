import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../logger.dart';

class SecureStorageService {
  static const _tokenKey = 'auth_token';

  final FlutterSecureStorage _storage;
  SecureStorageService(this._storage);

  Future<void> saveToken(String tokens) async {
    Logger.info('saveToken: $tokens');
    await _storage.write(key: _tokenKey, value: tokens);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}

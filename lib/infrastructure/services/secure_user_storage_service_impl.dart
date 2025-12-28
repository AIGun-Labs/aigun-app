import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constant/storage_keys.dart';
import '../../core/services/secure_user_storage_service.dart';
import '../../features/auth/infrastructure/models/auth_user_model.dart';

class SecureUserStorageServiceImpl implements SecureUserStorageService {
  SecureUserStorageServiceImpl(this._storage);
  static const _userKey = 'auth_user';

  static const _userInfoKey = StorageKeys.userInfo;

  final FlutterSecureStorage _storage;

  Future<void> migrateUser() async {
    final userString = await _storage.read(key: _userKey);
    if (userString != null && userString.isNotEmpty) {
      await _storage.write(key: _userInfoKey, value: userString);
    }
  }

  @override
  Future<void> writeUserInfo(AuthUserModel user) async {
    await _storage.write(key: _userInfoKey, value: jsonEncode(user.toJson()));
  }

  @override
  Future<AuthUserModel> readUserInfo() async {
    try {
      final userInfo = await _storage.read(key: _userInfoKey);
      if (userInfo == null || userInfo.isEmpty) {
        throw Exception('User info not found');
      }
      return AuthUserModel.fromJson(jsonDecode(userInfo));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearUserInfo() async {
    await _storage.delete(key: _userInfoKey);
  }
}

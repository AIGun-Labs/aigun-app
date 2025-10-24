import 'dart:convert';

import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorageService {
  static const _userKey = "auth_user";
  final _storage = const FlutterSecureStorage();

  Future<void> saveUser(String user) async {
    Logger.info("saveUser: $user");
    // 验证是否为有效的JSON字符串
    try {
      if (user.isNotEmpty) {
        jsonDecode(user); // 验证JSON格式
        await _storage.write(key: _userKey, value: user);
      }
    } catch (e) {
      Logger.error("保存用户数据失败，无效的JSON格式: $e");
      throw const FormatException("无效的用户数据格式");
    }
  }

  Future<User> getUser() async {
    final userString = await _storage.read(key: _userKey);

    // 如果没有用户数据，抛出异常
    if (userString == null || userString.isEmpty) {
      throw Exception("用户数据不存在");
    }

    final userMap = jsonDecode(userString);

    return User.fromJson(userMap);
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: _userKey);
  }

  Future<String?> getUserId() async {
    final user = await getUser();
    return user.pk;
  }

  Future<void> saveUserSubscriptions(String subscriptions) async {
    try {
      await _storage.write(key: _userKey, value: subscriptions);
    } catch (e) {
      Logger.error("保存用户订阅失败: $e");
      throw const FormatException("无效的用户订阅数据格式");
    }
  }

  Future<String> getUserSubscriptions() async {
    try {
      final subscriptions = await _storage.read(key: _userKey);
      if (subscriptions == null || subscriptions.isEmpty) {
        return '';
      }
      return subscriptions;
    } catch (e) {
      Logger.error("获取用户订阅失败: $e");
      throw const FormatException("无效的用户订阅数据格式");
    }
  }
}

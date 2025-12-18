import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/models/index.dart';
import '../../logger.dart';

class UserStorageService {
  UserStorageService(this._storage);
  static const _userKey = 'auth_user';
  static const _userSubscriptionsKey = 'user_subscriptions'; // 新增专门的订阅键
  final FlutterSecureStorage _storage;

  Future<void> saveUser(String user) async {
    Logger.info('saveUser: $user');
    // 验证是否为有效的JSON字符串
    try {
      if (user.isNotEmpty) {
        jsonDecode(user); // 验证JSON格式
        await _storage.write(key: _userKey, value: user);
      }
    } catch (e) {
      Logger.error('save user data failed: $e');
      throw const FormatException('Invalid user data format');
    }
  }

  Future<User> getUser() async {
    try {
      final userString = await _storage.read(key: _userKey);

      // 如果没有用户数据，抛出异常
      if (userString == null || userString.isEmpty) {
        throw Exception('User not found');
      }

      // 解析 JSON
      final decoded = jsonDecode(userString);

      // 类型检查：确保是 Map 类型
      if (decoded is! Map<String, dynamic>) {
        Logger.error('用户数据格式错误，不是有效的 Map 类型: ${decoded.runtimeType}');
        throw const FormatException('用户数据格式错误');
      }

      return User.fromJson(decoded);
    } on FormatException catch (e) {
      Logger.error('解析用户数据失败，JSON 格式错误: $e');
      rethrow;
    } catch (e) {
      Logger.error('获取用户数据失败: $e');
      rethrow;
    }
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
      await _storage.write(key: _userSubscriptionsKey, value: subscriptions);
    } catch (e) {
      Logger.error('save user subscriptions failed: $e');
      throw const FormatException('Invalid user subscriptions data format');
    }
  }

  // Future<String> getUserSubscriptions() async {
  //   try {
  //     final subscriptions = await _storage.read(key: _userSubscriptionsKey);
  //     if (subscriptions == null || subscriptions.isEmpty) {
  //       return '';
  //     }

  //     return subscriptions;
  //   } catch (e) {
  //     Logger.error('get user subscriptions failed: $e');
  //     throw const FormatException('Invalid user subscriptions data format');
  //   }
  // }
}

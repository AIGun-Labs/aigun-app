import 'package:shared_preferences/shared_preferences.dart';

class PermissionStorage {
  static const String _privacyPermissionKey = "privacy_permission";

  /// 获取用户是否同意隐私协议
  Future<bool> getPrivacyPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_privacyPermissionKey) ?? false;
  }

  /// 保存用户隐私协议同意状态
  Future<void> setPrivacyPermission(bool agreed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_privacyPermissionKey, agreed);
  }

  /// 清除隐私协议同意状态（用于重置或测试）
  Future<void> clearPrivacyPermission() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_privacyPermissionKey);
  }
}

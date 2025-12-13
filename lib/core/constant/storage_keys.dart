// lib/core/constants/storage_keys.dart

// 使用 abstract class 防止被实例化
abstract class StorageKeys {
  // 私有构造函数，彻底禁止实例化
  StorageKeys._();

  /// 用户访问令牌
  static const String accessToken = 'ACCESS_TOKEN';

  /// 用户刷新令牌 (如果有)
  static const String refreshToken = 'REFRESH_TOKEN';

  /// 动态标签
  static const String optionTab = 'OPTION_TAB';
}

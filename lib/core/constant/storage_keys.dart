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

  /// 语言代码
  static const String kLangCode = 'LANGUAGE_CODE';

  /// 国家代码
  static const String kCountryCode = 'COUNTRY_CODE';

  /// 是否跟随系统
  static const String kFollowSystemLang = 'FOLLOW_SYSTEM_LANG';

  /// 本地化字符串
  static const String kLocaleStr = 'LOCALE_STR';

  /// 用户信息
  static const String userInfo = 'USER_INFO';
}

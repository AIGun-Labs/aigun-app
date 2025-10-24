/// 存储键枚举
///
/// 定义应用中所有用到的存储键，避免硬编码字符串
/// 提供类型安全和代码自动完成功能
enum StorageKey {
  // ===============================
  // 用户相关
  // ===============================

  /// 用户ID
  userId('user_id'),

  /// 用户名
  username('username'),

  /// 用户邮箱
  userEmail('user_email'),

  /// 用户头像URL
  userAvatar('user_avatar'),

  /// 用户登录状态
  isLoggedIn('is_logged_in'),

  /// 最后登录时间
  lastLoginTime('last_login_time'),

  // ===============================
  // 认证相关
  // ===============================

  /// 访问令牌
  accessToken('access_token'),

  /// 刷新令牌
  refreshToken('refresh_token'),

  /// 令牌过期时间
  tokenExpireTime('token_expire_time'),

  // ===============================
  // 应用设置
  // ===============================

  /// 应用语言
  appLanguageCode('app_language_code'),

  /// 主题模式 (light/dark/system)
  themeMode('theme_mode'),

  /// 是否首次启动
  isFirstLaunch('is_first_launch'),

  /// 应用版本号
  appVersion('app_version'),

  /// 是否启用通知
  notificationEnabled('notification_enabled'),

  /// 是否启用生物识别
  biometricEnabled('biometric_enabled'),

  // ===============================
  // 交易相关
  // ===============================

  /// 默认交易对
  defaultTradePair('default_trade_pair'),

  /// 交易滑点设置
  tradeSlippage('trade_slippage'),

  /// 交易确认设置
  tradeConfirmation('trade_confirmation'),

  /// 最近交易历史
  recentTrades('recent_trades'),

  /// 收藏的交易对
  favoritePairs('favorite_pairs'),

  // ===============================
  // 钱包相关
  // ===============================

  /// 钱包地址
  walletAddress('wallet_address'),

  /// 钱包类型
  walletType('wallet_type'),

  /// 钱包余额缓存
  walletBalance('wallet_balance'),

  /// 钱包连接状态
  walletConnected('wallet_connected'),

  /// 最后更新余额时间
  lastBalanceUpdate('last_balance_update'),

  // ===============================
  // 缓存相关
  // ===============================

  /// 价格数据缓存
  priceCache('price_cache'),

  /// 市场数据缓存
  marketCache('market_cache'),

  /// 新闻数据缓存
  newsCache('news_cache'),

  /// 缓存过期时间
  cacheExpireTime('cache_expire_time'),

  // ===============================
  // 安全相关
  // ===============================

  /// PIN码哈希
  pinHash('pin_hash'),

  /// 自动锁定时间
  autoLockTime('auto_lock_time'),

  /// 登录失败次数
  loginFailCount('login_fail_count'),

  /// 账户锁定时间
  accountLockTime('account_lock_time'),

  // ===============================
  // 开发和调试
  // ===============================

  /// 调试模式
  debugMode('debug_mode'),

  /// API环境 (dev/staging/prod)
  apiEnvironment('api_environment'),

  /// 日志级别
  logLevel('log_level'),

  /// 是否显示性能监控
  showPerformanceOverlay('show_performance_overlay');

  /// 构造函数
  const StorageKey(this.value);

  /// 存储键的字符串值
  final String value;

  /// 重写 toString 方法，返回存储键的值
  @override
  String toString() => value;

  /// 根据字符串值查找对应的枚举
  ///
  /// [value] 要查找的字符串值
  /// 返回对应的 StorageKey 枚举，如果未找到则返回 null
  static StorageKey? fromString(String value) {
    for (StorageKey key in StorageKey.values) {
      if (key.value == value) {
        return key;
      }
    }
    return null;
  }

  /// 获取所有用户相关的键
  static List<StorageKey> get userKeys => [
        userId,
        username,
        userEmail,
        userAvatar,
        isLoggedIn,
        lastLoginTime,
      ];

  /// 获取所有认证相关的键
  static List<StorageKey> get authKeys => [
        accessToken,
        refreshToken,
        tokenExpireTime,
      ];

  /// 获取所有应用设置相关的键
  static List<StorageKey> get settingsKeys => [
        appLanguageCode,
        themeMode,
        isFirstLaunch,
        appVersion,
        notificationEnabled,
        biometricEnabled,
      ];

  /// 获取所有交易相关的键
  static List<StorageKey> get tradeKeys => [
        defaultTradePair,
        tradeSlippage,
        tradeConfirmation,
        recentTrades,
        favoritePairs,
      ];

  /// 获取所有钱包相关的键
  static List<StorageKey> get walletKeys => [
        walletAddress,
        walletType,
        walletBalance,
        walletConnected,
        lastBalanceUpdate,
      ];

  /// 获取所有缓存相关的键
  static List<StorageKey> get cacheKeys => [
        priceCache,
        marketCache,
        newsCache,
        cacheExpireTime,
      ];

  /// 获取所有安全相关的键
  static List<StorageKey> get securityKeys => [
        pinHash,
        autoLockTime,
        loginFailCount,
        accountLockTime,
      ];

  /// 获取所有开发调试相关的键
  static List<StorageKey> get debugKeys => [
        debugMode,
        apiEnvironment,
        logLevel,
        showPerformanceOverlay,
      ];

  /// 获取需要安全存储的键（通常存储在 SecureStorage 中）
  static List<StorageKey> get secureKeys => [
        accessToken,
        refreshToken,
        pinHash,
        ...authKeys,
        ...securityKeys,
      ];

  /// 获取可以普通存储的键（可以存储在 SharedPreferences 中）
  static List<StorageKey> get regularKeys => [
        ...userKeys,
        ...settingsKeys,
        ...tradeKeys,
        ...walletKeys,
        ...cacheKeys,
        ...debugKeys,
      ];
}

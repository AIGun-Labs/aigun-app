///

enum StorageKey {
  // ===============================

  // ===============================

  userId('user_id'),

  username('username'),

  userEmail('user_email'),

  userAvatar('user_avatar'),

  isLoggedIn('is_logged_in'),

  lastLoginTime('last_login_time'),

  // ===============================

  // ===============================

  accessToken('access_token'),

  refreshToken('refresh_token'),

  tokenExpireTime('token_expire_time'),

  // ===============================

  // ===============================

  appLanguageCode('app_language_code'),

  themeMode('theme_mode'),

  isFirstLaunch('is_first_launch'),

  appVersion('app_version'),

  notificationEnabled('notification_enabled'),

  biometricEnabled('biometric_enabled'),

  // ===============================

  // ===============================

  defaultTradePair('default_trade_pair'),

  tradeSlippage('trade_slippage'),

  tradeConfirmation('trade_confirmation'),

  recentTrades('recent_trades'),

  favoritePairs('favorite_pairs'),

  // ===============================

  // ===============================

  walletAddress('wallet_address'),

  walletType('wallet_type'),

  walletBalance('wallet_balance'),

  walletConnected('wallet_connected'),

  lastBalanceUpdate('last_balance_update'),

  // ===============================

  // ===============================

  priceCache('price_cache'),

  marketCache('market_cache'),

  newsCache('news_cache'),

  cacheExpireTime('cache_expire_time'),

  // ===============================

  // ===============================

  pinHash('pin_hash'),

  autoLockTime('auto_lock_time'),

  loginFailCount('login_fail_count'),

  accountLockTime('account_lock_time'),

  // ===============================

  // ===============================

  debugMode('debug_mode'),

  apiEnvironment('api_environment'),

  logLevel('log_level'),

  showPerformanceOverlay('show_performance_overlay');

  const StorageKey(this.value);

  final String value;

  @override
  String toString() => value;

  ///

  static StorageKey? fromString(String value) {
    for (StorageKey key in StorageKey.values) {
      if (key.value == value) {
        return key;
      }
    }
    return null;
  }

  static List<StorageKey> get userKeys => [
    userId,
    username,
    userEmail,
    userAvatar,
    isLoggedIn,
    lastLoginTime,
  ];

  static List<StorageKey> get authKeys => [
    accessToken,
    refreshToken,
    tokenExpireTime,
  ];

  static List<StorageKey> get settingsKeys => [
    appLanguageCode,
    themeMode,
    isFirstLaunch,
    appVersion,
    notificationEnabled,
    biometricEnabled,
  ];

  static List<StorageKey> get tradeKeys => [
    defaultTradePair,
    tradeSlippage,
    tradeConfirmation,
    recentTrades,
    favoritePairs,
  ];

  static List<StorageKey> get walletKeys => [
    walletAddress,
    walletType,
    walletBalance,
    walletConnected,
    lastBalanceUpdate,
  ];

  static List<StorageKey> get cacheKeys => [
    priceCache,
    marketCache,
    newsCache,
    cacheExpireTime,
  ];

  static List<StorageKey> get securityKeys => [
    pinHash,
    autoLockTime,
    loginFailCount,
    accountLockTime,
  ];

  static List<StorageKey> get debugKeys => [
    debugMode,
    apiEnvironment,
    logLevel,
    showPerformanceOverlay,
  ];

  static List<StorageKey> get secureKeys => [
    accessToken,
    refreshToken,
    pinHash,
    ...authKeys,
    ...securityKeys,
  ];

  static List<StorageKey> get regularKeys => [
    ...userKeys,
    ...settingsKeys,
    ...tradeKeys,
    ...walletKeys,
    ...cacheKeys,
    ...debugKeys,
  ];
}

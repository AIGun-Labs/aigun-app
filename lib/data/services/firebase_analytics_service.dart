// class FirebaseAnalyticsService {
//   static final FirebaseAnalyticsService _instance =
//       FirebaseAnalyticsService._internal();

//   factory FirebaseAnalyticsService() => _instance;

//   FirebaseAnalyticsService._internal();

//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//   final Logger _logger = Logger();

//   /// 获取 FirebaseAnalytics 实例
//   FirebaseAnalytics get analytics => _analytics;

//   /// 获取 FirebaseAnalyticsObserver 用于路由追踪
//   FirebaseAnalyticsObserver get observer =>
//       FirebaseAnalyticsObserver(analytics: _analytics);

//   /// 设置用户 ID
//   Future<void> setUserId(String? userId) async {
//     try {
//       await _analytics.setUserId(id: userId);
//       _logger.d('Analytics: User ID set to $userId');
//     } catch (e) {
//       _logger.e('Error setting user ID: $e');
//     }
//   }

//   /// 设置用户属性
//   Future<void> setUserProperty({
//     required String name,
//     required String? value,
//   }) async {
//     try {
//       await _analytics.setUserProperty(name: name, value: value);
//       _logger.d('Analytics: User property set - $name: $value');
//     } catch (e) {
//       _logger.e('Error setting user property: $e');
//     }
//   }

//   /// 记录自定义事件
//   Future<void> logEvent({
//     required String name,
//     Map<String, Object>? parameters,
//   }) async {
//     try {
//       await _analytics.logEvent(
//         name: name,
//         parameters: parameters,
//       );
//       _logger.d('Analytics: Event logged - $name: $parameters');
//     } catch (e) {
//       _logger.e('Error logging event: $e');
//     }
//   }

//   /// 记录屏幕浏览
//   Future<void> logScreenView({
//     required String screenName,
//     String? screenClass,
//   }) async {
//     try {
//       await _analytics.logScreenView(
//         screenName: screenName,
//         screenClass: screenClass,
//       );
//       _logger.d('Analytics: Screen view - $screenName');
//     } catch (e) {
//       _logger.e('Error logging screen view: $e');
//     }
//   }

//   // ==================== 登录/注册相关事件 ====================

//   /// 记录登录事件
//   Future<void> logLogin({String? method}) async {
//     await logEvent(
//       name: 'login',
//       parameters: {
//         'method': method ?? 'email' as Object,
//       },
//     );
//   }

//   /// 记录注册事件
//   Future<void> logSignUp({String? method}) async {
//     await logEvent(
//       name: 'sign_up',
//       parameters: {
//         'method': method ?? 'email' as Object,
//       },
//     );
//   }

//   // ==================== 交易相关事件 ====================

//   /// 记录交易开始
//   Future<void> logTradeStart({
//     required String tokenSymbol,
//     required String tradeType, // 'buy' or 'sell'
//     String? chain,
//   }) async {
//     final params = <String, Object>{
//       'token_symbol': tokenSymbol,
//       'trade_type': tradeType,
//     };
//     if (chain != null) params['chain'] = chain;

//     await logEvent(name: 'trade_start', parameters: params);
//   }

//   /// 记录交易确认
//   Future<void> logTradeConfirm({
//     required String tokenSymbol,
//     required String tradeType,
//     required double amount,
//     String? chain,
//   }) async {
//     final params = <String, Object>{
//       'token_symbol': tokenSymbol,
//       'trade_type': tradeType,
//       'amount': amount,
//     };
//     if (chain != null) params['chain'] = chain;

//     await logEvent(name: 'trade_confirm', parameters: params);
//   }

//   /// 记录交易成功
//   Future<void> logTradeSuccess({
//     required String tokenSymbol,
//     required String tradeType,
//     required double amount,
//     String? transactionHash,
//     String? chain,
//   }) async {
//     final params = <String, Object>{
//       'token_symbol': tokenSymbol,
//       'trade_type': tradeType,
//       'amount': amount,
//     };
//     if (transactionHash != null) params['transaction_hash'] = transactionHash;
//     if (chain != null) params['chain'] = chain;

//     await logEvent(name: 'trade_success', parameters: params);
//   }

//   /// 记录交易失败
//   Future<void> logTradeFailure({
//     required String tokenSymbol,
//     required String tradeType,
//     String? errorReason,
//     String? chain,
//   }) async {
//     final params = <String, Object>{
//       'token_symbol': tokenSymbol,
//       'trade_type': tradeType,
//     };
//     if (errorReason != null) params['error_reason'] = errorReason;
//     if (chain != null) params['chain'] = chain;

//     await logEvent(name: 'trade_failure', parameters: params);
//   }

//   // ==================== 钱包相关事件 ====================

//   /// 记录钱包连接
//   Future<void> logWalletConnect({
//     required String walletType,
//     String? chain,
//   }) async {
//     final params = <String, Object>{'wallet_type': walletType};
//     if (chain != null) params['chain'] = chain;

//     await logEvent(name: 'wallet_connect', parameters: params);
//   }

//   /// 记录钱包切换
//   Future<void> logWalletSwitch({
//     required String fromChain,
//     required String toChain,
//   }) async {
//     await logEvent(
//       name: 'wallet_switch',
//       parameters: {
//         'from_chain': fromChain,
//         'to_chain': toChain,
//       },
//     );
//   }

//   /// 记录代币添加
//   Future<void> logTokenAdd({
//     required String tokenSymbol,
//     required String tokenAddress,
//     String? chain,
//   }) async {
//     final params = <String, Object>{
//       'token_symbol': tokenSymbol,
//       'token_address': tokenAddress,
//     };
//     if (chain != null) params['chain'] = chain;

//     await logEvent(name: 'token_add', parameters: params);
//   }

//   // ==================== 发送代币相关事件 ====================

//   /// 记录发送代币
//   Future<void> logTokenSend({
//     required String tokenSymbol,
//     required double amount,
//     String? chain,
//   }) async {
//     final params = <String, Object>{
//       'token_symbol': tokenSymbol,
//       'amount': amount,
//     };
//     if (chain != null) params['chain'] = chain;

//     await logEvent(name: 'token_send', parameters: params);
//   }

//   /// 记录接收地址查看
//   Future<void> logReceiveAddressView({String? chain}) async {
//     final params = <String, Object>{};
//     if (chain != null) params['chain'] = chain;

//     await logEvent(
//       name: 'receive_address_view',
//       parameters: params.isNotEmpty ? params : null,
//     );
//   }

//   // ==================== 设置相关事件 ====================

//   /// 记录语言切换
//   Future<void> logLanguageChange({
//     required String fromLanguage,
//     required String toLanguage,
//   }) async {
//     await logEvent(
//       name: 'language_change',
//       parameters: {
//         'from_language': fromLanguage,
//         'to_language': toLanguage,
//       },
//     );
//   }

//   /// 记录主题切换
//   Future<void> logThemeChange({required String theme}) async {
//     await logEvent(
//       name: 'theme_change',
//       parameters: {
//         'theme': theme,
//       },
//     );
//   }

//   /// 记录交易设置修改
//   Future<void> logTradeSettingChange({
//     double? slippage,
//     double? gasPrice,
//   }) async {
//     await logEvent(
//       name: 'trade_setting_change',
//       parameters: {
//         if (slippage != null) 'slippage': slippage,
//         if (gasPrice != null) 'gas_price': gasPrice,
//       },
//     );
//   }

//   // ==================== 代币查看相关事件 ====================

//   /// 记录代币详情查看
//   Future<void> logTokenDetailView({
//     required String tokenSymbol,
//     String? tokenAddress,
//     String? chain,
//   }) async {
//     final params = <String, Object>{'token_symbol': tokenSymbol};
//     if (tokenAddress != null) params['token_address'] = tokenAddress;
//     if (chain != null) params['chain'] = chain;

//     await logEvent(name: 'token_detail_view', parameters: params);
//   }

//   // ==================== 搜索相关事件 ====================

//   /// 记录搜索事件
//   Future<void> logSearch({
//     required String searchTerm,
//     String? searchCategory,
//   }) async {
//     final params = <String, Object>{'search_term': searchTerm};
//     if (searchCategory != null) params['search_category'] = searchCategory;

//     await logEvent(name: 'search', parameters: params);
//   }

//   // ==================== 错误追踪 ====================

//   /// 记录应用错误
//   Future<void> logAppError({
//     required String errorMessage,
//     String? errorCode,
//     String? screenName,
//   }) async {
//     final params = <String, Object>{'error_message': errorMessage};
//     if (errorCode != null) params['error_code'] = errorCode;
//     if (screenName != null) params['screen_name'] = screenName;

//     await logEvent(name: 'app_error', parameters: params);
//   }

//   // ==================== 调试工具 ====================

//   /// 启用/禁用分析收集（仅在开发模式下可用）
//   Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
//     if (kDebugMode) {
//       await _analytics.setAnalyticsCollectionEnabled(enabled);
//       _logger.d('Analytics collection ${enabled ? "enabled" : "disabled"}');
//     }
//   }
// }

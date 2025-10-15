// file: services/analytics_service.dart

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  // 使用单例模式
  AnalyticsService._privateConstructor();
  static final AnalyticsService instance =
      AnalyticsService._privateConstructor();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // 提供一个 observer 以便集成到 MaterialApp 中进行自动屏幕跟踪
  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  /// 设置用户ID，在用户登录后调用
  void setUserId({required String userId}) {
    _analytics.setUserId(id: userId);
  }

  /// 设置用户属性，例如用户等级
  void setUserTierProperty({required String tier}) {
    _analytics.setUserProperty(name: 'user_tier', value: tier);
  }

  /// 清除用户数据，在用户登出时调用
  void clearUserData() {
    _analytics.setUserId(id: null);
  }

  /// 记录用户注册事件
  void logSignUp(
      {required String signUpMethod, Map<String, Object>? parameters}) {
    _analytics.logSignUp(signUpMethod: signUpMethod, parameters: parameters);
  }

  /// 记录用户登录事件
  void logLogin(
      {required String loginMethod, Map<String, Object>? parameters}) {
    _analytics.logLogin(loginMethod: loginMethod, parameters: parameters);
  }

  /// 记录用户登出事件
  void logLogout() {
    _analytics.logEvent(name: 'logout');
  }

  /// 记录交易事件
  void logTrade({
    required String fromCurrency,
    required String toCurrency,
    required double fromAmount,
    required double toAmount,
  }) {
    _analytics.logEvent(
      name: 'trade',
      parameters: {
        'from_currency': fromCurrency,
        'to_currency': toCurrency,
        'from_amount': fromAmount,
        'to_amount': toAmount,
      },
    );
  }

  /// 记录充值事件
  void logDeposit({required String currency, required double amount}) {
    _analytics.logEvent(
      name: 'deposit',
      parameters: {
        'currency': currency,
        'value': amount,
      },
    );
  }

  /// 记录提现事件
  void logWithdrawal({required String currency, required double amount}) {
    _analytics.logEvent(
      name: 'withdrawal',
      parameters: {
        'currency': currency,
        'value': amount,
      },
    );
  }

  /// 记录用户点击分享
  void logShare({required String contentType, required String itemId}) {
    _analytics.logShare(
      contentType: contentType,
      itemId: itemId,
      method: 'app',
    );
  }
}

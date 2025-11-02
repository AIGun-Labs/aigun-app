import 'package:flutter_aigun/services/analytics/analytics_adapter.dart';
import 'package:flutter_aigun/services/analytics/firebase_analytics_adapter.dart';
import 'package:flutter_aigun/services/analytics/umeng_analytics_adapter.dart';
import 'package:flutter_aigun/utils/logger.dart';

/// 统计分析管理器
/// 单例模式，根据地区自动选择使用 Firebase Analytics 或友盟统计
class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._internal();
  factory AnalyticsManager() => _instance;
  AnalyticsManager._internal();

  late final AnalyticsAdapter _adapter;
  bool _isInitialized = false;

  /// 初始化统计分析
  /// [isInChina] 是否在中国大陆地区，true 使用友盟统计，false 使用 Firebase Analytics
  Future<void> init({required bool isInChina}) async {
    if (_isInitialized) {
      Logger.debug('AnalyticsManager 已经初始化，跳过重复初始化');
      return;
    }

    try {
      // 根据地区选择统计平台
      _adapter = isInChina 
          ? UmengAnalyticsAdapter() 
          : FirebaseAnalyticsAdapter();
      
      await _adapter.init();
      _isInitialized = true;

      final platform = isInChina ? '友盟统计' : 'Firebase Analytics (已禁用)';
      Logger.info('AnalyticsManager 初始化完成，使用平台: $platform');
    } catch (e) {
      Logger.error('AnalyticsManager 初始化失败', e);
      rethrow;
    }
  }

  /// 记录事件
  /// [name] 事件名称
  /// [parameters] 事件参数
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager 未初始化，跳过事件记录');
      return;
    }

    return _adapter.logEvent(name, parameters: parameters);
  }

  /// 设置用户 ID
  /// [userId] 用户唯一标识
  Future<void> setUserId(String userId) async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager 未初始化，跳过设置用户 ID');
      return;
    }

    return _adapter.setUserId(userId);
  }

  /// 设置用户属性
  /// [name] 属性名称
  /// [value] 属性值
  Future<void> setUserProperty(String name, String value) async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager 未初始化，跳过设置用户属性');
      return;
    }

    return _adapter.setUserProperty(name, value);
  }

  /// 清除用户 ID（用于退出登录）
  Future<void> clearUserId() async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager 未初始化，跳过清除用户 ID');
      return;
    }

    return _adapter.clearUserId();
  }

  /// 记录页面浏览
  /// [screenName] 页面名称
  /// [screenClass] 页面类名
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager 未初始化，跳过页面浏览记录');
      return;
    }

    return _adapter.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  /// 便捷方法：记录登录事件
  Future<void> logLogin({required String method}) async {
    return logEvent('login', parameters: {'method': method});
  }

  /// 便捷方法：记录注册事件
  Future<void> logSignUp({required String method}) async {
    return logEvent('sign_up', parameters: {'method': method});
  }

  /// 便捷方法：记录购买事件
  Future<void> logPurchase({
    required String currency,
    required double value,
    Map<String, dynamic>? items,
  }) async {
    return logEvent('purchase', parameters: {
      'currency': currency,
      'value': value,
      ...?items,
    });
  }

  /// 便捷方法：记录分享事件
  Future<void> logShare({
    required String contentType,
    required String itemId,
  }) async {
    return logEvent('share', parameters: {
      'content_type': contentType,
      'item_id': itemId,
    });
  }

  /// 便捷方法：记录搜索事件
  Future<void> logSearch({required String searchTerm}) async {
    return logEvent('search', parameters: {'search_term': searchTerm});
  }
}


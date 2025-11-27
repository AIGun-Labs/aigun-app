import '../../utils/logger.dart';
import 'analytics_adapter.dart';

/// Firebase Analytics 适配器
/// 提供 Firebase Analytics 的统计实现
/// 注意：当前已禁用，仅保留空实现
class FirebaseAnalyticsAdapter implements AnalyticsAdapter {
  @override
  Future<void> init() async {
    // TODO: Firebase Analytics 暂时禁用
    Logger.info('Firebase Analytics 已禁用（空实现）');
  }

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    // 空实现 - Firebase Analytics 已禁用
    Logger.debug('Firebase Analytics (已禁用) - 事件: $name, 参数: $parameters');
  }

  @override
  Future<void> setUserId(String userId) async {
    // 空实现 - Firebase Analytics 已禁用
    Logger.debug('Firebase Analytics (已禁用) - 设置用户 ID: $userId');
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    // 空实现 - Firebase Analytics 已禁用
    Logger.debug('Firebase Analytics (已禁用) - 设置用户属性: $name = $value');
  }

  @override
  Future<void> clearUserId() async {
    // 空实现 - Firebase Analytics 已禁用
    Logger.debug('Firebase Analytics (已禁用) - 清除用户 ID');
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    // 空实现 - Firebase Analytics 已禁用
    Logger.debug('Firebase Analytics (已禁用) - 页面浏览: $screenName');
  }
}

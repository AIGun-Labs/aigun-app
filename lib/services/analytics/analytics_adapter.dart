/// 统计分析适配器接口
/// 定义统一的统计分析接口，支持多种统计平台
abstract class AnalyticsAdapter {
  /// 初始化统计 SDK
  Future<void> init();

  /// 记录事件
  /// [name] 事件名称
  /// [parameters] 事件参数
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});

  /// 设置用户 ID
  /// [userId] 用户唯一标识
  Future<void> setUserId(String userId);

  /// 设置用户属性
  /// [name] 属性名称
  /// [value] 属性值
  Future<void> setUserProperty(String name, String value);

  /// 清除用户 ID（用于退出登录）
  Future<void> clearUserId();

  /// 记录页面浏览
  /// [screenName] 页面名称
  /// [screenClass] 页面类名
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  });
}

import 'package:flutter_aigun/services/analytics/analytics_adapter.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';

/// 友盟统计适配器
/// 提供友盟（Umeng）统计的实现
class UmengAnalyticsAdapter implements AnalyticsAdapter {
  bool _isInitialized = false;

  // 友盟 AppKey 配置
  static const String _androidAppKey =
      '6906f92e644c9e2c206d53c2'; // 替换为你的 Android AppKey
  static const String _iosAppKey =
      '6906f92e644c9e2c206d53c3'; // 替换为你的 iOS AppKey
  static const String _channel = 'AIGun'; // 渠道名称

  @override
  Future<void> init() async {
    try {
      // 初始化友盟 SDK
      await UmengCommonSdk.initCommon(
        _androidAppKey,
        _iosAppKey,
        _channel,
      );

      // 设置页面采集模式为手动
      UmengCommonSdk.setPageCollectionModeManual();

      _isInitialized = true;
      Logger.info('友盟统计初始化成功');
    } catch (e) {
      Logger.error('友盟统计初始化失败', e);
      rethrow;
    }
  }

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    if (!_isInitialized) {
      Logger.debug('友盟统计未初始化，跳过事件: $name');
      return;
    }

    try {
      // 友盟的 onEvent 方法接受事件名和参数 Map
      UmengCommonSdk.onEvent(name, parameters ?? {});
      Logger.debug('友盟统计事件记录: $name, 参数: $parameters');
    } catch (e) {
      Logger.error('友盟统计记录事件失败', e);
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    if (!_isInitialized) {
      Logger.debug('友盟统计未初始化，跳过设置用户 ID');
      return;
    }

    try {
      UmengCommonSdk.onProfileSignIn(userId);
      Logger.debug('友盟统计设置用户 ID: $userId');
    } catch (e) {
      Logger.error('友盟统计设置用户 ID 失败', e);
    }
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    if (!_isInitialized) {
      Logger.debug('友盟统计未初始化，跳过设置用户属性');
      return;
    }

    try {
      // 友盟不直接支持用户属性，可以通过自定义事件实现
      UmengCommonSdk.onEvent('user_property', {
        'property_name': name,
        'property_value': value,
      });
      Logger.debug('友盟统计设置用户属性: $name = $value');
    } catch (e) {
      Logger.error('友盟统计设置用户属性失败', e);
    }
  }

  @override
  Future<void> clearUserId() async {
    if (!_isInitialized) {
      Logger.debug('友盟统计未初始化，跳过清除用户 ID');
      return;
    }

    try {
      UmengCommonSdk.onProfileSignOff();
      Logger.debug('友盟统计清除用户 ID');
    } catch (e) {
      Logger.error('友盟统计清除用户 ID 失败', e);
    }
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!_isInitialized) {
      Logger.debug('友盟统计未初始化，跳过页面浏览');
      return;
    }

    try {
      // 友盟页面统计
      UmengCommonSdk.onPageStart(screenName);
      Logger.debug('友盟统计记录页面浏览: $screenName');

      // 注意：在实际使用中，应该在页面关闭时调用 onPageEnd
      // 这里仅作为示例，实际应该在对应页面的 dispose 中调用
    } catch (e) {
      Logger.error('友盟统计记录页面浏览失败', e);
    }
  }

  /// 页面结束统计（需要在页面销毁时调用）
  Future<void> logScreenEnd(String screenName) async {
    if (!_isInitialized) {
      return;
    }

    try {
      UmengCommonSdk.onPageEnd(screenName);
      Logger.debug('友盟统计页面结束: $screenName');
    } catch (e) {
      Logger.error('友盟统计页面结束失败', e);
    }
  }
}

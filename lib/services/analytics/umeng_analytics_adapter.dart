import 'package:umeng_common_sdk/umeng_common_sdk.dart';

import '../../utils/logger.dart';
import 'analytics_adapter.dart';

class UmengAnalyticsAdapter implements AnalyticsAdapter {
  bool _isInitialized = false;
  static const String _androidAppKey =
      '6906f92e644c9e2c206d53c2'; //  Android AppKey
  static const String _iosAppKey = '6906f92e644c9e2c206d53c3'; //  iOS AppKey
  static const String _channel = 'AIGun'; //

  @override
  Future<void> init() async {
    Logger.info('');
    _isInitialized = false;
    return;

    // try {
    //   await UmengCommonSdk.initCommon(
    //     _androidAppKey,
    //     _iosAppKey,
    //     _channel,
    //   );
    //   UmengCommonSdk.setPageCollectionModeManual();

    //   _isInitialized = true;
    // } catch (e) {
    //   rethrow;
    // }
  }

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    if (!_isInitialized) {
      Logger.debug('，: $name');
      return;
    }

    try {
      UmengCommonSdk.onEvent(name, parameters ?? {});
      Logger.debug(': $name, : $parameters');
    } catch (e) {
      Logger.error('', e);
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    if (!_isInitialized) {
      Logger.debug('， ID');
      return;
    }

    try {
      UmengCommonSdk.onProfileSignIn(userId);
      Logger.debug(' ID: $userId');
    } catch (e) {
      Logger.error(' ID ', e);
    }
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    if (!_isInitialized) {
      Logger.debug('，');
      return;
    }

    try {
      UmengCommonSdk.onEvent('user_property', {
        'property_name': name,
        'property_value': value,
      });
      Logger.debug(': $name = $value');
    } catch (e) {
      Logger.error('', e);
    }
  }

  @override
  Future<void> clearUserId() async {
    if (!_isInitialized) {
      Logger.debug('， ID');
      return;
    }

    try {
      UmengCommonSdk.onProfileSignOff();
      Logger.debug(' ID');
    } catch (e) {
      Logger.error(' ID ', e);
    }
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!_isInitialized) {
      Logger.debug('，');
      return;
    }

    try {
      UmengCommonSdk.onPageStart(screenName);
      Logger.debug(': $screenName');
    } catch (e) {
      Logger.error('', e);
    }
  }

  Future<void> logScreenEnd(String screenName) async {
    if (!_isInitialized) {
      return;
    }

    try {
      UmengCommonSdk.onPageEnd(screenName);
      Logger.debug(': $screenName');
    } catch (e) {
      Logger.error('', e);
    }
  }
}

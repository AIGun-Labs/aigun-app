import '../../utils/logger.dart';
import 'analytics_adapter.dart';
import 'firebase_analytics_adapter.dart';
import 'umeng_analytics_adapter.dart';

class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._internal();
  factory AnalyticsManager() => _instance;
  AnalyticsManager._internal();

  late final AnalyticsAdapter _adapter;
  bool _isInitialized = false;
  Future<void> init({required bool isInChina}) async {
    if (_isInitialized) {
      Logger.debug('AnalyticsManager ，');
      return;
    }

    try {
      _adapter = isInChina
          ? UmengAnalyticsAdapter()
          : FirebaseAnalyticsAdapter();

      await _adapter.init();
      _isInitialized = true;

      final platform = isInChina ? '' : 'Firebase Analytics ()';
      Logger.info('AnalyticsManager ，: $platform');
    } catch (e) {
      Logger.error('AnalyticsManager ', e);
      rethrow;
    }
  }

  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager ，');
      return;
    }

    return _adapter.logEvent(name, parameters: parameters);
  }

  Future<void> setUserId(String userId) async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager ， ID');
      return;
    }

    return _adapter.setUserId(userId);
  }

  Future<void> setUserProperty(String name, String value) async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager ，');
      return;
    }

    return _adapter.setUserProperty(name, value);
  }

  Future<void> clearUserId() async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager ， ID');
      return;
    }

    return _adapter.clearUserId();
  }

  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!_isInitialized) {
      Logger.debug('AnalyticsManager ，');
      return;
    }

    return _adapter.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  Future<void> logLogin({required String method}) async {
    return logEvent('login', parameters: {'method': method});
  }

  Future<void> logSignUp({required String method}) async {
    return logEvent('sign_up', parameters: {'method': method});
  }

  Future<void> logPurchase({
    required String currency,
    required double value,
    Map<String, dynamic>? items,
  }) async {
    return logEvent(
      'purchase',
      parameters: {'currency': currency, 'value': value, ...?items},
    );
  }

  Future<void> logShare({
    required String contentType,
    required String itemId,
  }) async {
    return logEvent(
      'share',
      parameters: {'content_type': contentType, 'item_id': itemId},
    );
  }

  Future<void> logSearch({required String searchTerm}) async {
    return logEvent('search', parameters: {'search_term': searchTerm});
  }
}

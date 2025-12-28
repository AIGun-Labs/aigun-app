import '../../utils/logger.dart';
import 'analytics_adapter.dart';

class FirebaseAnalyticsAdapter implements AnalyticsAdapter {
  @override
  Future<void> init() async {
    Logger.info('Firebase Analytics （）');
  }

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    Logger.debug('Firebase Analytics () - : $name, : $parameters');
  }

  @override
  Future<void> setUserId(String userId) async {
    Logger.debug('Firebase Analytics () -  ID: $userId');
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    Logger.debug('Firebase Analytics () - : $name = $value');
  }

  @override
  Future<void> clearUserId() async {
    Logger.debug('Firebase Analytics () -  ID');
  }

  @override
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    Logger.debug('Firebase Analytics () - : $screenName');
  }
}

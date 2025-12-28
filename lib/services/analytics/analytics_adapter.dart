abstract class AnalyticsAdapter {
  Future<void> init();
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});
  Future<void> setUserId(String userId);
  Future<void> setUserProperty(String name, String value);
  Future<void> clearUserId();
  Future<void> logScreenView({required String screenName, String? screenClass});
}

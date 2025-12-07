/// Feature Flags for gradual feature rollout
///
/// This class provides feature flags to enable/disable features
/// during migration and A/B testing.
abstract class FeatureFlags {
  FeatureFlags._();

  /// Whether to use the new Intelligence feature architecture
  ///
  /// When `true`, uses the new Clean Architecture implementation
  /// in `lib/features/intelligence/`
  ///
  /// When `false`, uses the legacy implementation
  /// in `lib/screens/intel/` and `lib/cubits/intel/`
  static bool get useNewIntelligenceFeature {
    // TODO: Can be controlled via:
    // - Remote config (Firebase Remote Config)
    // - Environment variable
    // - Local storage setting
    // - Build flavor
    return const bool.fromEnvironment(
      'USE_NEW_INTELLIGENCE_FEATURE',
      defaultValue: false,
    );
  }

  /// Check if we're in development mode for testing new features
  static bool get isDevelopmentMode {
    return const bool.fromEnvironment(
      'FLUTTER_DEBUG',
      defaultValue: false,
    );
  }

  /// Force enable new Intelligence feature (for testing)
  static bool _forceNewIntelligence = false;

  /// Enable new Intelligence feature for testing
  static void enableNewIntelligenceFeature() {
    _forceNewIntelligence = true;
  }

  /// Disable new Intelligence feature
  static void disableNewIntelligenceFeature() {
    _forceNewIntelligence = false;
  }

  /// Effective flag considering force override
  static bool get isNewIntelligenceEnabled {
    return _forceNewIntelligence || useNewIntelligenceFeature;
  }
}

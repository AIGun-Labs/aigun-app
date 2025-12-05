// lib/config/app_config.dart

abstract class AppConfig {
  static String get baseApiUrl =>
      String.fromEnvironment("BASE_API_URL", defaultValue: "");

  static bool get isProd => String.fromEnvironment("ENV") == "prod";

  static String get wsUrl => String.fromEnvironment("WS_URL", defaultValue: "");
  static String get cdn => String.fromEnvironment("CDN", defaultValue: "");
  static String get privateKey =>
      String.fromEnvironment("PRIVATEKEY", defaultValue: "");

  void init() {}
}

// lib/config/env/app_env.dart

abstract interface class IAppEnv {
  String get baseApiUrl;
  String get sentryDsn;
  String get wsUrl;
  String get privateKey;
  String get cdn;
  String get candleStickUrl;

  String get envString;
  bool get isProd;
  bool get isDev;
}

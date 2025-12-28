// lib/config/env/app_env_dev.dart
import 'package:envied/envied.dart';

import 'i_app_env.dart';

part 'app_env_dev.g.dart';

@Envied(path: '.env.development')
class EnvDev implements IAppEnv {
  @override
  @EnviedField(varName: 'BASE_API_URL')
  final String baseApiUrl = _EnvDev.baseApiUrl;

  @override
  @EnviedField(varName: 'SENTRY_DSN')
  final String sentryDsn = _EnvDev.sentryDsn;

  @override
  @EnviedField(varName: 'BASE_WS_URL')
  final String wsUrl = _EnvDev.wsUrl;

  @override
  @EnviedField(varName: 'PRIVATE_KEY', obfuscate: true)
  final String privateKey = _EnvDev.privateKey;

  @override
  @EnviedField(varName: 'BASE_CDN_URL')
  final String cdn = _EnvDev.cdn;

  @override
  @EnviedField(varName: 'CANDLESTICK_URL')
  final String candleStickUrl = _EnvDev.candleStickUrl;

  @override
  bool get isDev => true;

  @override
  bool get isProd => false;
}

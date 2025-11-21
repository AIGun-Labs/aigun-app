// lib/config/env/app_env_dev.dart
import 'package:envied/envied.dart';

import 'app_env.dart';

part 'app_env_dev.g.dart';

// 指向 .env.dev 文件
@Envied(path: '.env.development')
class EnvDev implements AppEnv {
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
}

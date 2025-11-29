// lib/config/env/app_env_dev.dart
import 'package:envied/envied.dart';

import 'env_minxin.dart';
import 'i_app_env.dart';

part 'app_env_prod.g.dart';

// 指向 .env.dev 文件
@Envied(path: '.env.production', obfuscate: true)
class EnvProd with EnvMinxin implements IAppEnv {
  @override
  @EnviedField(varName: 'BASE_API_URL')
  final String baseApiUrl = _EnvProd.baseApiUrl;

  @override
  @EnviedField(varName: 'SENTRY_DSN')
  final String sentryDsn = _EnvProd.sentryDsn;

  @override
  @EnviedField(varName: 'BASE_WS_URL')
  final String wsUrl = _EnvProd.wsUrl;

  @override
  @EnviedField(varName: 'PRIVATE_KEY')
  final String privateKey = _EnvProd.privateKey;

  @override
  @EnviedField(varName: 'BASE_CDN_URL')
  final String cdn = _EnvProd.cdn;

  @override
  @EnviedField(varName: 'CANDLESTICK_URL')
  final String candleStickUrl = _EnvProd.candleStickUrl;

  @override
  bool get isDev => false;

  @override
  bool get isProd => true;
}

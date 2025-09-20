import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart' as foundation;

part 'env.g.dart';

/**
 * 环境配置
 * debug : kDebugMode = true
 * profile : kDebugMode = true
 * release : kDebugMode = false
 * 开发环境：.env.development -> flutter run
 * 生产环境：.env.production -> flutter build apk --release
 */
@Envied(path: ".env.production", name: "ProdEnv")
@Envied(path: ".env.development", name: "DebugEnv")
final class EnvConfig {
  static const bool kDebugMode = foundation.kDebugMode;

  factory EnvConfig() => _instance;

  static final EnvConfig _instance = switch (kDebugMode) {
    true => _DebugEnv(),
    false => _ProdEnv(),
  };

  @EnviedField(varName: "BASE_API_URL")
  final String baseApiUrl = _instance.baseApiUrl;

  @EnviedField(varName: "SENTRY_DSN")
  final String sentryDsn = _instance.sentryDsn;

  @EnviedField(varName: "BASE_WS_URL")
  final String wsUrl = _instance.wsUrl;

  @EnviedField(varName: "PRIVATE_KEY")
  final String privateKey = _instance.privateKey;

  @EnviedField(varName: "BASE_CND_URL")
  final String cdn = _instance.cdn;
}

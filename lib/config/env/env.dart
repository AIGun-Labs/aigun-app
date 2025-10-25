import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart' as foundation;

part 'env.g.dart';

/// 环境配置类型
enum EnvType {
  /// 生产环境
  production,

  /// 开发环境 (默认)
  development,
}

/// 配置文件：
/// - .env.production: 生产环境配置
/// - .env.development: 默认开发环境配置
@Envied(path: ".env.production", name: "ProdEnv", obfuscate: true)
@Envied(path: ".env.development", name: "DebugEnv", obfuscate: false)
final class EnvConfig {
  static const bool kDebugMode = foundation.kDebugMode;

  /// 当前环境类型
  static EnvType get currentEnvType {
    const envString = String.fromEnvironment('ENV', defaultValue: '');

    if (envString.isNotEmpty) {
      return switch (envString.toLowerCase()) {
        'production' => EnvType.production,
        'development' => EnvType.development,
        _ => EnvType.development,
      };
    }

    return kDebugMode ? EnvType.development : EnvType.production;
  }

  factory EnvConfig() => _instance;

  static final EnvConfig _instance = switch (currentEnvType) {
    EnvType.production => _ProdEnv(),
    EnvType.development => _DebugEnv(),
    _ => _DebugEnv(),
  };

  @EnviedField(varName: "BASE_API_URL")
  final String baseApiUrl = _ProdEnv.baseApiUrl;

  @EnviedField(varName: "SENTRY_DSN")
  final String sentryDsn = _ProdEnv.sentryDsn;

  @EnviedField(varName: "BASE_WS_URL")
  final String wsUrl = _ProdEnv.wsUrl;

  @EnviedField(varName: "PRIVATE_KEY")
  final String privateKey = _ProdEnv.privateKey;

  @EnviedField(varName: "BASE_CDN_URL")
  final String cdn = _ProdEnv.cdn;

  @EnviedField(varName: "CANDLESTICK_URL")
  final String candleStickUrl = _ProdEnv.candleStickUrl;
}

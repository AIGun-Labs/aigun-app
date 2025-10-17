import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart' as foundation;

part 'env.g.dart';

/// 环境配置类型
enum EnvType {
  /// 生产环境
  production,

  /// 开发环境 (默认)
  development,

  /// 本地开发环境1 (192.168.4.55)
  development1,

  /// 本地开发环境2 (192.168.4.67)
  development2,
}

/// 环境配置
///
/// 使用方式：
/// 1. 生产环境：flutter build apk --release
/// 2. 开发环境：flutter run (默认使用 .env.development)
/// 3. 本地环境1：flutter run --dart-define=ENV=development1
/// 4. 本地环境2：flutter run --dart-define=ENV=development2
///
/// 配置文件：
/// - .env.production: 生产环境配置
/// - .env.development: 默认开发环境配置
/// - .env.development1.local: 本地开发环境1配置
/// - .env.development2.local: 本地开发环境2配置
@Envied(path: ".env.production", name: "ProdEnv", obfuscate: true)
@Envied(path: ".env.development", name: "DebugEnv", obfuscate: true)
@Envied(path: ".env.development1.local", name: "Dev1Env", obfuscate: true)
@Envied(path: ".env.development2.local", name: "Dev2Env", obfuscate: true)
final class EnvConfig {
  static const bool kDebugMode = foundation.kDebugMode;

  /// 当前环境类型
  static EnvType get currentEnvType {
    if (!kDebugMode) {
      return EnvType.production;
    }

    // 通过 --dart-define=ENV=xxx 指定环境
    const envString =
        String.fromEnvironment('ENV', defaultValue: 'development');
    return switch (envString.toLowerCase()) {
      'production' => EnvType.production,
      'development1' => EnvType.development1,
      'development2' => EnvType.development2,
      _ => EnvType.development,
    };
  }

  factory EnvConfig() => _instance;

  static final EnvConfig _instance = switch (currentEnvType) {
    EnvType.production => _ProdEnv(),
    EnvType.development1 => _Dev1Env(),
    EnvType.development2 => _Dev2Env(),
    EnvType.development => _DebugEnv(),
  };

  @EnviedField(varName: "BASE_API_URL")
  final String baseApiUrl = _instance.baseApiUrl;

  @EnviedField(varName: "SENTRY_DSN")
  final String sentryDsn = _instance.sentryDsn;

  @EnviedField(varName: "BASE_WS_URL")
  final String wsUrl = _instance.wsUrl;

  @EnviedField(varName: "PRIVATE_KEY")
  final String privateKey = _instance.privateKey;

  @EnviedField(varName: "BASE_CDN_URL")
  final String cdn = _instance.cdn;
}

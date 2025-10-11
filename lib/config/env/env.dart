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

// 定义每个环境的抽象类
@Envied(path: ".env.production", obfuscate: true)
abstract class _ProdEnv {
  @EnviedField(varName: "BASE_API_URL")
  static String? baseApiUrl;

  @EnviedField(varName: "SENTRY_DSN")
  static String? sentryDsn;

  @EnviedField(varName: "BASE_WS_URL")
  static String? wsUrl;

  @EnviedField(varName: "PRIVATE_KEY")
  static String? privateKey;

  @EnviedField(varName: "BASE_CDN_URL")
  static String? cdn;
}

@Envied(path: ".env.development", obfuscate: true)
abstract class _DebugEnv {
  @EnviedField(varName: "BASE_API_URL")
  static String? baseApiUrl;

  @EnviedField(varName: "SENTRY_DSN")
  static String? sentryDsn;

  @EnviedField(varName: "BASE_WS_URL")
  static String? wsUrl;

  @EnviedField(varName: "PRIVATE_KEY")
  static String? privateKey;

  @EnviedField(varName: "BASE_CDN_URL")
  static String? cdn;
}

@Envied(path: ".env.development1.local", obfuscate: true)
abstract class _Dev1Env {
  @EnviedField(varName: "BASE_API_URL")
  static String? baseApiUrl;

  @EnviedField(varName: "SENTRY_DSN")
  static String? sentryDsn;

  @EnviedField(varName: "BASE_WS_URL")
  static String? wsUrl;

  @EnviedField(varName: "PRIVATE_KEY")
  static String? privateKey;

  @EnviedField(varName: "BASE_CDN_URL")
  static String? cdn;
}

@Envied(path: ".env.development2.local", obfuscate: true)
abstract class _Dev2Env {
  @EnviedField(varName: "BASE_API_URL")
  static String? baseApiUrl;

  @EnviedField(varName: "SENTRY_DSN")
  static String? sentryDsn;

  @EnviedField(varName: "BASE_WS_URL")
  static String? wsUrl;

  @EnviedField(varName: "PRIVATE_KEY")
  static String? privateKey;

  @EnviedField(varName: "BASE_CDN_URL")
  static String? cdn;
}

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

  static final EnvConfig _instance = EnvConfig._internal();

  EnvConfig._internal();

  String get baseApiUrl => switch (currentEnvType) {
        EnvType.production => _ProdEnv.baseApiUrl!,
        EnvType.development1 => _Dev1Env.baseApiUrl!,
        EnvType.development2 => _Dev2Env.baseApiUrl!,
        EnvType.development => _DebugEnv.baseApiUrl!,
      };

  String get sentryDsn => switch (currentEnvType) {
        EnvType.production => _ProdEnv.sentryDsn!,
        EnvType.development1 => _Dev1Env.sentryDsn!,
        EnvType.development2 => _Dev2Env.sentryDsn!,
        EnvType.development => _DebugEnv.sentryDsn!,
      };

  String get wsUrl => switch (currentEnvType) {
        EnvType.production => _ProdEnv.wsUrl!,
        EnvType.development1 => _Dev1Env.wsUrl!,
        EnvType.development2 => _Dev2Env.wsUrl!,
        EnvType.development => _DebugEnv.wsUrl!,
      };

  String get privateKey => switch (currentEnvType) {
        EnvType.production => _ProdEnv.privateKey!,
        EnvType.development1 => _Dev1Env.privateKey!,
        EnvType.development2 => _Dev2Env.privateKey!,
        EnvType.development => _DebugEnv.privateKey!,
      };

  String get cdn => switch (currentEnvType) {
        EnvType.production => _ProdEnv.cdn!,
        EnvType.development1 => _Dev1Env.cdn!,
        EnvType.development2 => _Dev2Env.cdn!,
        EnvType.development => _DebugEnv.cdn!,
      };
}

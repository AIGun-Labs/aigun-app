// lib/config/app_config.dart
import 'env/app_env.dart';
import 'env/app_env_dev.dart';
import 'env/app_env_prod.dart';

class AppConfig {
  // 单例模式（可选，视需求而定）
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  late final AppEnv _env;

  // 获取当前环境配置
  AppEnv get env => _env;

  void _initEnv() {
    const String envType =
        String.fromEnvironment('ENV', defaultValue: 'development');
    switch (envType) {
      case 'production':
        _env = EnvProd();
        break;
      case 'development':
      default:
        _env = EnvDev();
        break;
    }
  }

  // 初始化方法，在 main.dart 中调用
  void init() {
    _initEnv();
  }
}

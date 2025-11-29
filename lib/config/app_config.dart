// lib/config/app_config.dart
import 'env/app_env_dev.dart';
import 'env/app_env_prod.dart';
import 'env/i_app_env.dart';

class AppConfig {
  // 单例模式（可选，视需求而定）
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  late final IAppEnv _env;

  // 获取当前环境配置
  IAppEnv get env => _env;

  void _initEnv() {
    const envType = String.fromEnvironment('ENV', defaultValue: 'development');

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

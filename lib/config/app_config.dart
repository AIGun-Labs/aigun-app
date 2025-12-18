// lib/config/app_config.dart
import '../core/enums/environment.dart';
import 'env/app_env_dev.dart';
import 'env/app_env_prod.dart';
import 'env/i_app_env.dart';

class AppConfig {
  factory AppConfig() => _instance;
  AppConfig._internal();
  // 单例模式（可选，视需求而定）
  static final AppConfig _instance = AppConfig._internal();

  late final IAppEnv _envConfig;

  late final Environment environment;

  final bool enableInnerUpdate = bool.fromEnvironment(
    'ENABLE_INNER_UPDATE',
    defaultValue: true,
  );

  // 获取当前环境配置
  IAppEnv get env => _envConfig;

  //根据环境初始化环境配置
  void _initEnv(Environment env) {
    environment = env;

    switch (environment) {
      case Environment.production:
        _envConfig = EnvProd();
        break;
      case Environment.development:
      case Environment.staging:
        _envConfig = EnvDev();
    }
  }

  // 初始化方法，在 main.dart 中调用
  void init({required Environment environment}) {
    _initEnv(environment);
  }
}

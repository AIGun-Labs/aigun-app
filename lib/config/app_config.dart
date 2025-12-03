// lib/config/app_config.dart
import '../core/constant/enviroment.dart';
import 'env/app_env_dev.dart';
import 'env/app_env_prod.dart';
import 'env/i_app_env.dart';

class AppConfig {
  // 单例模式（可选，视需求而定）
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  late final IAppEnv _env;

  late final String envString;

  final bool enableInnerUpdate = bool.fromEnvironment(
    'ENABLE_INNER_UPDATE',
    defaultValue: true,
  );

  // 获取当前环境配置
  IAppEnv get env => _env;

  //根据环境初始化环境配置
  void _initEnv(String environment) {
    envString = environment;

    switch (environment) {
      case Enviroment.production:
        _env = EnvProd();
        break;
      case Enviroment.development:
      case Enviroment.staging:
        _env = EnvDev();
    }
  }

  // 初始化方法，在 main.dart 中调用
  void init({required String environment}) {
    _initEnv(environment);
  }
}

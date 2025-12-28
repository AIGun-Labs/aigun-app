// lib/config/app_config.dart
import '../core/enums/environment.dart';
import 'env/app_env_dev.dart';
import 'env/app_env_prod.dart';
import 'env/i_app_env.dart';

class AppConfig {
  factory AppConfig() => _instance;
  AppConfig._internal();
  static final AppConfig _instance = AppConfig._internal();

  late final IAppEnv _envConfig;

  late final Environment environment;

  final bool enableInnerUpdate = bool.fromEnvironment(
    'ENABLE_INNER_UPDATE',
    defaultValue: true,
  );
  IAppEnv get env => _envConfig;
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

  void init({required Environment environment}) {
    _initEnv(environment);
  }
}

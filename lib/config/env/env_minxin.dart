import 'i_app_env.dart';

mixin EnvMinxin implements IAppEnv {
  @override
  String get envString =>
      String.fromEnvironment('ENV', defaultValue: 'development');
}

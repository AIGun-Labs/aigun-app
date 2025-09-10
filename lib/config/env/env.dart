import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: ".env.production", name: "ProdEnv")
@Envied(path: ".env.development", name: "DebugEnv")
final class Env {
  static const bool kDebugMode = true;

  factory Env() => _instance;

  static final Env _instance = switch (kDebugMode) {
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

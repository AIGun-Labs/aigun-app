enum Environment { dev, prod }

class EnvConfig {
  final String baseUrl;
  final String sentryDsn;
  final String wsUrl;
  final String privateKey;
  final String? cdn; // signature private key
  const EnvConfig({
    required this.baseUrl,
    required this.sentryDsn,
    required this.wsUrl,
    required this.privateKey,
    required this.cdn, // signature private key
  });
}

class Env {
  static late final Environment environment;
  static late final EnvConfig config;

  static void initialize() {
    const env = String.fromEnvironment('ENV', defaultValue: 'dev');
    environment = env == 'prod' ? Environment.prod : Environment.dev;
    config = _getConfig(environment);
  }

  static bool get isDev => environment == Environment.dev;
  static bool get isProd => environment == Environment.prod;

  static EnvConfig _getConfig(Environment env) {
    switch (env) {
      case Environment.dev:
        return const EnvConfig(
            baseUrl: 'https://api.route.aigun.ai',
            // baseUrl: 'http://192.168.4.64:8000',
            wsUrl: 'api.route.aigun.ai',
            // wsUrl: 'http://192.168.4.64:8000',
            sentryDsn:
                'https://b27812d91398fba9a4dc4dc2f9d73d67@o4506023617822720.ingest.us.sentry.io/4508685044547584',
            privateKey:
                'd9596dbf26541c3dc2dc701d79afca18754f8eb4cbaf6a7794d4ee024eba4039',
            cdn: "https://cdn.route.aigun.ai");
      case Environment.prod:
        return const EnvConfig(
          baseUrl: 'https://api.route.aigun.ai', // 生产环境 URL
          wsUrl: 'api.route.aigun.ai',
          sentryDsn:
              'https://b27812d91398fba9a4dc4dc2f9d73d67@o4506023617822720.ingest.us.sentry.io/4508685044547584',
          privateKey:
              'd9596dbf26541c3dc2dc701d79afca18754f8eb4cbaf6a7794d4ee024eba4039',
          cdn: "https://cdn.route.aigun.ai",
        );
    }
  }
}

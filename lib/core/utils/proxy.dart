import '../../config/app_config.dart';

class ProxyUtils {
  static String video(String url) {
    return _joinProxyUrl(url, useProxy: true);
  }

  static String _joinProxyUrl(String? path, {required bool useProxy}) {
    if (path == null) {
      return '';
    }

    final appConfig = AppConfig();
    final baseUrl = appConfig.env.cdn;

    if (path.startsWith(baseUrl)) {
      return path;
    }

    // Remove trailing slash from baseUrl if present
    final cleanBaseUrl = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;

    // Remove leading slash from path if present
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;

    if (!path.startsWith('http')) {
      return '$cleanBaseUrl/$cleanPath';
    }

    if (useProxy) {
      final url = '${appConfig.env.baseApiUrl}/api/v1/proxy?url=$cleanPath';
      return url;
    }

    return path;
  }
}

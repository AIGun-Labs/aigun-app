import '../config/app_config.dart';
import '../shared/mixins/twitter_image_mixin.dart';

class ImageUtils with TwitterImageMixin {
  static final RegExp _numericRegex = RegExp(r'^\d+$');
  static const String _okLinkPrefix =
      'https://static.oklink.com/cdn/web3/currency/token/large/637-0xbae207659db88bea0cbead6da0ed00aac12edcdda169e591cd41c94180b46f3b-1';
  static const String _githubRawPrefix = 'https://raw.githubusercontent.com';

  static String getAvatarUrl(String? url) {
    return getImageUrl('/fission/images/avatar/$url');
  }

  static String getImageUrl(String? path) {
    return _resolveUrl(path, useProxy: false);
  }

  static String getImageProxyUrl(String? path) {
    return _resolveUrl(path, useProxy: true);
  }

  static String _resolveUrl(String? path, {required bool useProxy}) {
    if (path == null || path.trim().isEmpty || _numericRegex.hasMatch(path)) {
      return '';
    }

    // Special checks for URLs that should be returned directly
    if (path.startsWith(_okLinkPrefix) || isRawUrl(path)) {
      return path;
    }

    final baseUrl = AppConfig.cdn;

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
      return '${AppConfig.baseApiUrl}/api/v1/proxy?url=$cleanPath';
    }

    return path;
  }

  static bool isRawUrl(String? url) {
    return url?.startsWith(_githubRawPrefix) ?? false;
  }
}

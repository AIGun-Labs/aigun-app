class ProxyUtils {
  static String voide(String url) {
    return url.replaceAll('https://', 'https://proxy.aigun.io/');
  }
}

class TokenUtils {
  static getTokenSlugByValue(String value) {
    final newValue = value.toLowerCase();

    if (newValue == 'ethereum') {
      return 'eth';
    }
    return newValue;
  }
}

import '../../core/utils/twitter_image_utils.dart';

mixin TwitterImageMixin {
  static String processTwitterImage(String? url) {
    return TwitterImageUtils.removeTwitterImageSuffix(url);
  }

  static String getTwitterImageWithSize(
    String? url, {
    String size = 'original',
  }) {
    return TwitterImageUtils.getTwitterImageWithSize(url, size: size);
  }

  String getTwitterOriginalImage(String? url) {
    return getTwitterImageWithSize(url, size: 'original');
  }

  String getTwitterBiggerImage(String? url) {
    return getTwitterImageWithSize(url, size: 'bigger');
  }

  String getTwitterNormalImage(String? url) {
    return getTwitterImageWithSize(url, size: 'normal');
  }

  String getTwitterMiniImage(String? url) {
    return getTwitterImageWithSize(url, size: 'mini');
  }

  String getTwitter400x400Image(String? url) {
    return getTwitterImageWithSize(url, size: '400x400');
  }

  bool isTwitterImageUrl(String? url) {
    return url?.contains('pbs.twimg.com') ?? false;
  }
}

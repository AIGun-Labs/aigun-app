import '../../core/utils/twitter_image_utils.dart';

/// Twitter 图片处理 Mixin
/// 任何类都可以混入此 Mixin 来获得 Twitter 图片处理能力
mixin TwitterImageMixin {
  /// 处理 Twitter 图片 URL，移除尺寸后缀
  static String processTwitterImage(String? url) {
    return TwitterImageUtils.removeTwitterImageSuffix(url);
  }

  /// 获取指定尺寸的 Twitter 图片
  static String getTwitterImageWithSize(
    String? url, {
    String size = 'original',
  }) {
    return TwitterImageUtils.getTwitterImageWithSize(url, size: size);
  }

  /// 获取原始尺寸的 Twitter 图片
  String getTwitterOriginalImage(String? url) {
    return getTwitterImageWithSize(url, size: 'original');
  }

  /// 获取 bigger 尺寸的 Twitter 图片
  String getTwitterBiggerImage(String? url) {
    return getTwitterImageWithSize(url, size: 'bigger');
  }

  /// 获取 normal 尺寸的 Twitter 图片
  String getTwitterNormalImage(String? url) {
    return getTwitterImageWithSize(url, size: 'normal');
  }

  /// 获取 mini 尺寸的 Twitter 图片
  String getTwitterMiniImage(String? url) {
    return getTwitterImageWithSize(url, size: 'mini');
  }

  /// 获取 400x400 尺寸的 Twitter 图片
  String getTwitter400x400Image(String? url) {
    return getTwitterImageWithSize(url, size: '400x400');
  }

  /// 检查是否是 Twitter 图片 URL
  bool isTwitterImageUrl(String? url) {
    return url?.contains('pbs.twimg.com') ?? false;
  }
}

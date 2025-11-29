import '../../utils/image_utils.dart';
import '../../utils/logger.dart';

class TwitterImageUtils {
  static String removeTwitterImageSuffix(String? url) {
    if (url == null || url.isEmpty) {
      return '';
    }

    // if (!url.contains('pbs.twimg.com')) {
    //   return url;
    // }

    final regex = RegExp(r'(_normal|_bigger|_mini|_400x400)(\.[a-zA-Z]{3,4})$');

    return url.replaceFirstMapped(regex, (match) => match.group(2) ?? '');
  }

  static String removeTwitterNormalSuffix(String? url) {
    if (url == null || url.isEmpty) {
      return '';
    }

    // if (!url.contains('pbs.twimg.com')) {
    //   return url;
    // }

    // 只移除 _normal. 后缀
    final regex = RegExp(r'_normal(\.[a-zA-Z]{3,4})$');
    return url.replaceFirstMapped(regex, (match) => match.group(1) ?? '');
  }

  static String getTwitterImageWithSize(
    String? url, {
    String size = 'original',
  }) {
    if (url == null || url.isEmpty) {
      return '';
    }

    // 先移除所有已存在的尺寸后缀
    final cleanUrl = removeTwitterImageSuffix(url);

    // 如果要求原始尺寸，直接返回清理后的 URL
    if (size == 'original') {
      return cleanUrl;
    }

    // 在文件扩展名前添加新的尺寸后缀
    final regex = RegExp(r'(\.[a-zA-Z]{3,4})$');
    final result = cleanUrl.replaceFirstMapped(
      regex,
      (match) => '_$size${match.group(1)}',
    );

    final proxyResult = ImageUtils.getImageProxyUrl(result);
    Logger.info('proxy result url $proxyResult');
    return proxyResult;
  }
}

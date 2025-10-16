import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureImage extends StatelessWidget {
  const FeatureImage(
      {super.key,
      required this.url,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.errorWidget,
      this.loadingWidget,
      this.httpHeaders});

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Map<String, String>? httpHeaders;

  Map<String, String> _getDefaultHeaders() {
    return {
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.9',
    };
  }

  /// 判断是否有图片路径后缀
  // bool _hasImageExtension() {
  //   return RegExp(r'\.(jpe?g|png|gif|webp|bmp|svg)$', caseSensitive: false)
  //       .hasMatch(url.toLowerCase());
  // }

  @override
  Widget build(BuildContext context) {
    final isSvg = url.toLowerCase().endsWith('.svg');

// 如果不是以 http 开头的则证明是本地图片，直接返回 CachedNetworkImage
    if (!url.startsWith("http")) {
      if (isSvg) {
        return SvgPicture.asset(
          url,
          width: width,
          height: height,
          fit: fit,
          placeholderBuilder: (context) =>
              loadingWidget ?? const FeatureImagePlaceholder(),
          errorBuilder: (context, error, stackTrace) =>
              errorWidget ?? const FeatureImagePlaceholder(),
        );
      } else {
        return CachedImage(
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          placeholder: loadingWidget ?? const FeatureImagePlaceholder(),
          errorWidget: errorWidget ?? const FeatureImagePlaceholder(),
          httpHeaders: httpHeaders ?? _getDefaultHeaders(),
        );
      }
    } else {
      if (isSvg) {
        return CachedNetworkSVGImage(
          url,
          width: width,
          height: height,
          fit: fit,
          errorWidget: errorWidget ?? const SizedBox.shrink(),
          placeholderBuilder: (context) =>
              loadingWidget ?? const FeatureImagePlaceholder(),
          headers: httpHeaders ?? _getDefaultHeaders(),
        );
      } else {
        return CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          httpHeaders: httpHeaders ?? _getDefaultHeaders(),
          placeholder: (context, url) =>
              loadingWidget ?? const FeatureImagePlaceholder(),
          errorWidget: (context, url, error) =>
              errorWidget ?? const FeatureImagePlaceholder(),
        );
      }
    }
  }
}

class FeatureImagePlaceholder extends StatelessWidget {
  const FeatureImagePlaceholder({super.key, this.width, this.height});

  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.senary,
      width: width,
      height: height,
    );
  }
}

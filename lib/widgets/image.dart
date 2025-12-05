import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;
  final Map<String, String>? httpHeaders;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.httpHeaders,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: _buildImage(),
      ),
    );
  }

  Map<String, String> _getDefaultHeaders() {
    return {
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.9',
    };
  }

  Widget _buildImage() {
    if (imageUrl.isEmpty) {
      return errorWidget ??
          const CachedImage(imageUrl: "assets/images/icons/ai-agent.png");
    }

    if (imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        httpHeaders: httpHeaders ?? _getDefaultHeaders(),
        // placeholder: (context, url) =>
        //     placeholder ?? const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            errorWidget ??
            const CachedImage(imageUrl: "assets/images/icons/ai-agent.png"),
      );
    } else {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ??
            const CachedImage(imageUrl: "assets/images/icons/ai-agent.png"),
      );
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? placeholderText;
  final String? errorText;
  final bool showRetryButton;
  final VoidCallback? onRetry;
  final Map<String, String>? httpHeaders;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholderText,
    this.errorText,
    this.showRetryButton = true,
    this.onRetry,
    this.httpHeaders,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _buildErrorWidget('图片URL为空');
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      httpHeaders: httpHeaders ?? _getDefaultHeaders(),
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildErrorWidget(
        errorText ?? '加载失败: ${error.toString()}',
        url: url,
      ),
      cacheKey: 'network_image_${imageUrl.hashCode}',
      maxWidthDiskCache: 2000,
      maxHeightDiskCache: 2000,
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            if (placeholderText != null) ...[
              const SizedBox(height: 8),
              Text(placeholderText!, style: const TextStyle(fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message, {String? url}) {
    return Container(
      width: width,
      height: height,
      color: Colors.red[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.broken_image, size: 32, color: Colors.red),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.red),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (showRetryButton) ...[
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (onRetry != null) {
                  onRetry!();
                } else if (url != null) {
                  // 清除缓存并重试
                  CachedNetworkImage.evictFromCache(url);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(60, 30),
                textStyle: const TextStyle(fontSize: 12),
              ),
              child: const Text('重试'),
            ),
          ],
        ],
      ),
    );
  }

  Map<String, String> _getDefaultHeaders() {
    return {
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.9',
    };
  }
}

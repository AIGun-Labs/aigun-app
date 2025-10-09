import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class SmartNetworkImage extends StatefulWidget {
  const SmartNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.errorWidget,
    this.loadingWidget,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Widget? errorWidget;
  final Widget? loadingWidget;

  @override
  State<SmartNetworkImage> createState() => _SmartNetworkImageState();
}

class _SmartNetworkImageState extends State<SmartNetworkImage> {
  static final Map<String, bool> _globalSvgCache = {};
  Future<bool>? _isSvgFuture;

  @override
  void initState() {
    super.initState();
    // 在初始化时就开始判断图片类型，避免重复请求
    _isSvgFuture = _isSvgImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(SmartNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果URL改变了，重新判断
    if (oldWidget.url != widget.url) {
      _isSvgFuture = _isSvgImage();
    }
  }

  Future<bool> _isSvgImage() async {
    // 检查全局缓存
    if (_globalSvgCache.containsKey(widget.url)) {
      return _globalSvgCache[widget.url]!;
    }

    // 通过URL后缀快速判断
    final uri = Uri.parse(widget.url);
    final path = uri.path.toLowerCase();
    if (path.endsWith('.svg')) {
      _globalSvgCache[widget.url] = true;
      return true;
    } else if (path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.gif') ||
        path.endsWith('.webp')) {
      _globalSvgCache[widget.url] = false;
      return false;
    }

    // 如果无法通过后缀判断，则通过 content-type 判断（添加超时）
    try {
      final response = await http
          .head(Uri.parse(widget.url))
          .timeout(const Duration(seconds: 5));
      final contentType = response.headers['content-type'];
      final isSvg = contentType == 'image/svg+xml';

      _globalSvgCache[widget.url] = isSvg;
      return isSvg;
    } catch (e) {
      // 如果请求失败或超时，假设不是SVG
      _globalSvgCache[widget.url] = false;
      return false;
    }
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[200],
      child: const Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url.isEmpty) {
      return widget.errorWidget ?? _buildDefaultErrorWidget();
    }

    return FutureBuilder<bool>(
      future: _isSvgFuture,
      builder: (context, snapshot) {
        final errorWidget = widget.errorWidget ?? _buildDefaultErrorWidget();

        // 如果正在加载，并且有loadingWidget，则显示loadingWidget
        if (snapshot.connectionState == ConnectionState.waiting &&
            widget.loadingWidget != null) {
          return widget.loadingWidget!;
        }

        if (snapshot.hasError) {
          return errorWidget;
        }

        final isSvgImage = snapshot.data ?? false;

        return isSvgImage
            ? SvgPicture.network(
                widget.url,
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.cover,
                colorFilter: widget.color != null
                    ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                    : null,
                placeholderBuilder: (context) =>
                    widget.loadingWidget ??
                    Container(
                      width: widget.width,
                      height: widget.height,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorBuilder: (context, error, stackTrace) => errorWidget,
              )
            : CachedNetworkImage(
                imageUrl: widget.url,
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.cover,
                color: widget.color,
                memCacheWidth: widget.width?.toInt(),
                memCacheHeight: widget.height?.toInt(),
                cacheKey: widget.url,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholder: (context, url) =>
                    widget.loadingWidget ??
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => errorWidget,
              );
      },
    );
  }
}

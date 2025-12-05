import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    this.httpHeaders,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Map<String, String>? httpHeaders;

  @override
  State<SmartNetworkImage> createState() => _SmartNetworkImageState();
}

class _SmartNetworkImageState extends State<SmartNetworkImage> {
  static final Map<String, bool> _globalSvgCache = {};
  Future<bool>? _isSvgFuture;

  @override
  void initState() {
    super.initState();

    _isSvgFuture = _isSvgImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(SmartNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.url != widget.url) {
      _isSvgFuture = _isSvgImage();
    }
  }

  Map<String, String> _getDefaultHeaders() {
    return {
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.9',
    };
  }

  Future<bool> _isSvgImage() async {
    if (_globalSvgCache.containsKey(widget.url)) {
      return _globalSvgCache[widget.url]!;
    }

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

    try {
      final headers = widget.httpHeaders ?? _getDefaultHeaders();
      final response = await http
          .head(Uri.parse(widget.url), headers: headers)
          .timeout(const Duration(seconds: 5));
      final contentType = response.headers['content-type'];
      final isSvg = contentType?.startsWith('image/svg') ?? false;

      _globalSvgCache[widget.url] = isSvg;
      return isSvg;
    } catch (e) {
      _globalSvgCache[widget.url] = false;
      return false;
    }
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.transparent,
      child: const SizedBox.shrink(),
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
                headers: widget.httpHeaders ?? _getDefaultHeaders(),
                placeholderBuilder: (context) =>
                    widget.loadingWidget ??
                    Container(
                      width: widget.width,
                      height: widget.height,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
              )
            : CachedNetworkImage(
                imageUrl: widget.url,
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.contain,
                color: widget.color,
                cacheKey: widget.url,
                httpHeaders: widget.httpHeaders ?? _getDefaultHeaders(),
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

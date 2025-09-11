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
  _SmartNetworkImageState createState() => _SmartNetworkImageState();
}

class _SmartNetworkImageState extends State<SmartNetworkImage> {
  bool? _isSvgCache;
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
    // 如果URL改变了，重置缓存
    if (oldWidget.url != widget.url) {
      _isSvgCache = null;
      _isSvgFuture = _isSvgImage();
    }
  }

  Future<bool> _isSvgImage() async {
    // 如果已经缓存了结果，直接返回
    if (_isSvgCache != null) {
      return _isSvgCache!;
    }

    /// TODO: 图片有点离谱，图片链接后缀是 png，可响应的数据却是 svg，导致有些图片无法渲染
    /// 暂时通过 content-type 判断
    try {
      final response = await http.get(Uri.parse(widget.url));

      final contentType = response.headers['content-type'];

      _isSvgCache = contentType == 'image/svg+xml';
      return _isSvgCache!;
    } catch (e) {
      // 如果请求失败，假设不是SVG
      _isSvgCache = false;
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
                // placeholderBuilder: (context) => loadingWidget,
                errorBuilder: (context, error, stackTrace) => errorWidget,
              )
            : CachedNetworkImage(
                imageUrl: widget.url,
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.cover,
                color: widget.color,
                // placeholder: (context, url) => loadingWidget,
                errorWidget: (context, url, error) => errorWidget,
              );
      },
    );
  }
}

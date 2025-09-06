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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _isSvgImage() async {
    /// TODO: 图片有点离谱，图片链接后缀是 png，可响应的数据却是 svg，导致有些图片无法渲染
    /// 暂时通过 content-type 判断
    final response = await http.get(Uri.parse(widget.url));

    final contentType = response.headers['content-type'];

    if (contentType == 'image/svg+xml') {
      return true;
    }

    return false;
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[200],
      child: const Icon(Icons.error),
    );
  }

  Widget _buildDefaultLoadingWidget() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[100],
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url.isEmpty) {
      return widget.errorWidget ?? _buildDefaultErrorWidget();
    }

    return FutureBuilder<bool>(
      future: _isSvgImage(),
      builder: (context, snapshot) {
        final loadingWidget =
            widget.loadingWidget ?? _buildDefaultLoadingWidget();
        final errorWidget = widget.errorWidget ?? _buildDefaultErrorWidget();

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return loadingWidget;
        // }

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

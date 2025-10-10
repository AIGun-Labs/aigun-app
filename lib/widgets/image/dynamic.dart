import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

// class DynamicImage extends StatelessWidget {
//   final String imageUrl;
//   final double? width;
//   final double? height;
//   final BoxFit fit;
//   final Widget? errorWidget;
//   final Widget? placeholderWidget;

//   const DynamicImage(
//       {Key? key,
//       required this.imageUrl,
//       this.width,
//       this.height,
//       this.fit = BoxFit.cover,
//       this.errorWidget,
//       this.placeholderWidget})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (imageUrl.toLowerCase().endsWith('.svg')) {
//       return CachedNetworkSVGImage(
//         imageUrl,
//         width: width,
//         height: height,
//         fit: fit,
//         // errorBuilder: (context, error, stackTrace) =>
//         //     errorWidget ?? const SizedBox.shrink(),
//         placeholderBuilder: (BuildContext context) =>
//             placeholderWidget ?? const SizedBox.shrink(),
//       );
//     } else {
//       return CachedNetworkImage(
//         imageUrl: imageUrl,
//         width: width,
//         height: height,
//         fit: fit,
//         placeholder: (context, url) =>
//             placeholderWidget ?? const SizedBox.shrink(),
//         errorWidget: (context, url, error) =>
//             errorWidget ?? const SizedBox.shrink(),
//       );
//     }
//   }
// }

class DynamicImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;
  final Widget? placeholderWidget;

  const DynamicImage(
      {Key? key,
      required this.imageUrl,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.errorWidget,
      this.placeholderWidget})
      : super(key: key);

  @override
  State<DynamicImage> createState() => _DynamicImageState();
}

class _DynamicImageState extends State<DynamicImage> {
  String? _contentType;

  @override
  void initState() {
    super.initState();
    _checkImageType();
  }

  Future<void> _checkImageType() async {
    // 避免在组件销毁后还尝试更新状态
    if (!mounted) return;
    try {
      final response = await http.head(Uri.parse(widget.imageUrl));
      if (response.statusCode == 200 && mounted) {
        setState(() {
          _contentType = response.headers['content-type'];
        });
      }
    } catch (e) {
      print('无法获取图片类型: $e');
      if (mounted) {
        setState(() {
          // 发生错误时，设置一个可识别的错误类型
          _contentType = 'error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_contentType == null) {
      return widget.placeholderWidget ?? const SizedBox.shrink();
    }

    if (_contentType!.startsWith("image/svg")) {
      return CachedNetworkSVGImage(
        widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        // errorBuilder: (context, error, stackTrace) =>
        //     errorWidget ?? const SizedBox.shrink(),
        placeholderBuilder: (BuildContext context) =>
            widget.placeholderWidget ?? const SizedBox.shrink(),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        placeholder: (context, url) =>
            widget.placeholderWidget ?? const SizedBox.shrink(),
        errorWidget: (context, url, error) =>
            widget.errorWidget ?? const SizedBox.shrink(),
      );
    }
  }
}

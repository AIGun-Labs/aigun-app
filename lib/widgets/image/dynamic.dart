import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  final Map<String, String>? httpHeaders;

  const DynamicImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.placeholderWidget,
    this.httpHeaders,
  });

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

  Map<String, String> _getDefaultHeaders() {
    return {
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
      'Accept-Language': 'en-US,en;q=0.9',
    };
  }

  Future<void> _checkImageType() async {
    if (!mounted) return;
    try {
      final headers = widget.httpHeaders ?? _getDefaultHeaders();
      final response = await http.head(
        Uri.parse(widget.imageUrl),
        headers: headers,
      );
      if (response.statusCode == 200 && mounted) {
        setState(() {
          _contentType = response.headers['content-type'];
        });
      }
    } catch (e) {
      print(': $e');
      if (mounted) {
        setState(() {
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
      return SvgPicture.network(
        widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        headers: widget.httpHeaders ?? _getDefaultHeaders(),
        placeholderBuilder: (BuildContext context) =>
            widget.placeholderWidget ?? const SizedBox.shrink(),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        httpHeaders: widget.httpHeaders ?? _getDefaultHeaders(),
        placeholder: (context, url) =>
            widget.placeholderWidget ?? const SizedBox.shrink(),
        errorWidget: (context, url, error) =>
            widget.errorWidget ?? const SizedBox.shrink(),
      );
    }
  }
}

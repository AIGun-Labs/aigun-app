import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

// An enum to represent the state and type of the loaded image
enum _ImageType { loading, svg, raster, error }

class SmartNetworkImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color; // Only applicable for SVG

  const SmartNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  });

  @override
  State<SmartNetworkImage> createState() => _SmartNetworkImageState();
}

class _SmartNetworkImageState extends State<SmartNetworkImage> {
  _ImageType _imageType = _ImageType.loading;
  late Uint8List _imageData;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final response = await http.get(Uri.parse(widget.url));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // --- Content Sniffing Logic ---
        // Try to decode the start of the data as a string.
        // If it starts with '<svg' (allowing for whitespace), it's an SVG.
        String potentialSvg = utf8.decode(bytes, allowMalformed: true).trim();
        if (potentialSvg.startsWith('<svg') ||
            potentialSvg.startsWith('<?xml')) {
          setState(() {
            _imageData = bytes;
            _imageType = _ImageType.svg;
          });
        } else {
          // Otherwise, assume it's a standard raster image (PNG, JPG, etc.)
          setState(() {
            _imageData = bytes;
            _imageType = _ImageType.raster;
          });
        }
      } else {
        setState(() => _imageType = _ImageType.error);
      }
    } catch (e) {
      // This will catch network errors or decoding errors
      setState(() => _imageType = _ImageType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_imageType) {
      case _ImageType.loading:
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: const Center(child: CircularProgressIndicator()),
        );

      case _ImageType.svg:
        return SvgPicture.string(
          utf8.decode(_imageData), // Now we know it's a valid string
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          colorFilter: widget.color != null
              ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
              : null,
        );

      case _ImageType.raster:
        return Image.memory(
          _imageData,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          // The errorBuilder for Image.memory is a good fallback
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        );

      case _ImageType.error:
        return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: const Center(
        child: Icon(Icons.error_outline_rounded, color: Colors.red),
      ),
    );
  }
}

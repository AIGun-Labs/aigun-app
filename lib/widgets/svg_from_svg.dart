import 'dart:convert'; // 用于 utf8.decode
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class SvgFromPngUrl extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? color;

  const SvgFromPngUrl({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.color,
  });

  @override
  State<SvgFromPngUrl> createState() => _SvgFromPngUrlState();
}

class _SvgFromPngUrlState extends State<SvgFromPngUrl> {
  late Future<String> _svgFuture;

  @override
  void initState() {
    super.initState();
    _svgFuture = _fetchSvgData();
  }

  // 手动获取网络数据
  Future<String> _fetchSvgData() async {
    final response = await http.get(Uri.parse(widget.url));

    if (response.statusCode == 200) {
      // 成功获取数据，返回响应体字符串
      // 使用 utf8.decode 来防止因编码问题导致的乱码
      return utf8.decode(response.bodyBytes);
    } else {
      // 如果请求失败，则抛出异常
      throw Exception('Failed to load SVG from ${widget.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _svgFuture,
      builder: (context, snapshot) {
        // 正在加载
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 加载成功
        if (snapshot.hasData) {
          return SvgPicture.string(
            snapshot.data!,
            width: widget.width,
            height: widget.height,
            colorFilter: widget.color != null
                ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                : null,
            placeholderBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        }

        // 加载失败
        if (snapshot.hasError) {
          // 你可以显示一个错误图标或提示
          return Icon(Icons.error_outline,
              color: Colors.red, size: widget.width);
        }

        // 默认情况
        return SizedBox(width: widget.width, height: widget.height);
      },
    );
  }
}

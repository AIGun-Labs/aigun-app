import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class SmartNetworkImage extends StatefulWidget {
  SmartNetworkImage(
      {super.key,
      required this.url,
      this.width,
      this.height,
      this.fit,
      this.color});

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

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
    final response = await http.get(Uri.parse(widget.url));

    final contentType = response.headers['content-type'];

    if (contentType == 'image/svg+xml') {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isSvgImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: CircularProgressIndicator());
        }

        final isSvgImage = snapshot.data ?? false;
        return isSvgImage
            ? SvgPicture.network(widget.url,
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.cover,
                colorFilter: widget.color != null
                    ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                    : null)
            : CachedNetworkImage(
                imageUrl: widget.url,
                width: widget.width,
                height: widget.height,
                fit: widget.fit ?? BoxFit.cover,
                color: widget.color,
              );
      },
    );
  }
}

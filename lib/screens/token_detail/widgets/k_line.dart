import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KLine extends StatefulWidget {
  const KLine(
      {super.key,
      required this.address,
      required this.chainName,
      required this.height});

  final String address;
  final String chainName;
  final double height;
  @override
  _KLineState createState() => _KLineState();
}

final Map<String, String> chainNameMap = {
  "bsc": "0x1b13f21c2ec35d30eed8b443c08e5b9db3ae311365a675a5aea5bc44fc27d808",
  "ethereum": "0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640"
};

class _KLineState extends State<KLine> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // 允许 JS 执行
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          Logger.info('Navigation request: $request');
          return NavigationDecision.navigate;
        },
        onProgress: (progress) {
          Logger.info('Progress: $progress');
        },
        onPageStarted: (url) {
          Logger.info('Page started: $url');
        },
      ))
      ..loadRequest(Uri.parse(
          'https://www.geckoterminal.com/${widget.chainName}/pools/${widget.address}?embed=1&info=0&swaps=0&light_chart=1&chart_type=market_cap&resolution=1d&bg_color=ffffff'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height, child: WebViewWidget(controller: _controller));
  }
}

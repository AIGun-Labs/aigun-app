import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KLine extends StatefulWidget {
  const KLine({super.key, required this.address, required this.chainName});

  final String address;
  final String chainName;

  @override
  _KLineState createState() => _KLineState();
}

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
        height: 400.h, child: WebViewWidget(controller: _controller));
  }
}

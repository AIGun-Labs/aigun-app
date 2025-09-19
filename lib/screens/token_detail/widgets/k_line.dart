import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KLine extends StatefulWidget {
  const KLine({super.key});

  @override
  _KLineState createState() => _KLineState();
}

class _KLineState extends State<KLine> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onHttpError: (httpError) {
          Logger.error('Http error: $httpError');
        },
        onProgress: (progress) {
          Logger.info('Progress: $progress');
        },
        onPageStarted: (url) {
          Logger.info('Page started: $url');
        },
        onPageFinished: (url) {
          Logger.info('Page finished: $url');
        },
        onWebResourceError: (error) {
          Logger.error('Web resource error: $error');
        },
        onNavigationRequest: (request) {
          Logger.info('Navigation request: $request');
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(
          'https://www.geckoterminal.com/solana/pools/2zMMhcVQEXDtdE6vsFS7S7D5oUodfJHE8vd1gnBouauv?embed=1&info=0&swaps=0&light_chart=0&chart_type=market_cap&resolution=1d&bg_color=111827'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400.h, child: WebViewWidget(controller: _controller));
  }
}

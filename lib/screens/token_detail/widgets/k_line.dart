import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KLine extends StatefulWidget {
  const KLine(
      {super.key,
      required this.address,
      required this.chainId,
      required this.height});

  final String address;
  final String chainId;
  final double height;
  @override
  State<KLine> createState() => _KLineState();
}

class _KLineState extends State<KLine> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  String getChainName(String chainId) {
    switch (chainId) {
      case "56":
        return "bsc";
      case "1":
        return 'eth';
      case "8453":
        return 'base';
      case "1151111081099710":
        return 'solana';
      default:
        return '56';
    }
  }

  @override
  void initState() {
    super.initState();

    final chainName = getChainName(widget.chainId);
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
          setState(() {
            _isLoading = true;
            _hasError = false;
          });
        },
        onPageFinished: (url) {
          Logger.info('Page finished: $url');
          setState(() {
            _isLoading = false;
          });
        },
        onWebResourceError: (error) {
          Logger.error('WebView error: ${error.description}');
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        },
        onHttpError: (error) {
          Logger.error('HTTP error: ${error.response?.statusCode}');
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        },
      ))
      ..loadRequest(Uri.parse(
          'https://www.geckoterminal.com/$chainName/pools/${widget.address}?embed=1&info=0&swaps=0&light_chart=1&chart_type=market_cap&resolution=1d&bg_color=ffffff'));

    // Add timeout mechanism
    Future.delayed(const Duration(seconds: 10), () {
      if (_isLoading && mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        Logger.error('WebView loading timeout');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Hide widget if there's an error
    if (_hasError) {
      return const SizedBox.shrink();
    }

    // Show loading indicator while loading
    if (_isLoading) {
      // return Padding(
      //     padding: EdgeInsets.all(5.r),
      //     child: SizedBox(
      //       height: widget.height,
      //       child: Shimmer.fromColors(
      //           baseColor: AppColors.shimmerBaseColor(context),
      //           highlightColor: AppColors.shimmerHighlightColor(context),
      //           child: Container(
      //             width: double.infinity,
      //             height: widget.height,
      //             decoration: BoxDecoration(
      //               color: AppColors.shimmerBaseColor(context),
      //               borderRadius: BorderRadius.circular(5.r),
      //             ),
      //           )),
      //     ));
    }

    // Show WebView when successfully loaded
    return SizedBox(
        height: widget.height, child: WebViewWidget(controller: _controller));
  }
}

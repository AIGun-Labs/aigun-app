import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
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
  State<KLine> createState() => _KLineState();
}

final Map<String, String> chainNameMap = {
  "bsc": "0x1b13f21c2ec35d30eed8b443c08e5b9db3ae311365a675a5aea5bc44fc27d808",
  "ethereum": "0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640"
};

class _KLineState extends State<KLine> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

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
          'https://www.geckoterminal.com/${widget.chainName}/pools/${widget.address}?embed=1&info=0&swaps=0&light_chart=1&chart_type=market_cap&resolution=1d&bg_color=ffffff'));

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


      return const 
    }

    // Show WebView when successfully loaded
    return SizedBox(
        height: widget.height, child: WebViewWidget(controller: _controller));
  }
}

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
      ..setBackgroundColor(Colors.transparent) // 设置背景透明
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
        onPageFinished: (url) async {
          Logger.info('Page finished: $url');

          // 注入 JavaScript 来移除阴影和边框
          try {
            await _controller.runJavaScript('''
              // 移除所有阴影和边框
              var style = document.createElement('style');
              style.innerHTML = `
                * {
                  box-shadow: none !important;
                  -webkit-box-shadow: none !important;
                  -moz-box-shadow: none !important;
                }
                body {
                  margin: 0 !important;
                  padding: 0 !important;
                  border: none !important;
                }
                .chart-container, .chart-wrapper {
                  box-shadow: none !important;
                  border: none !important;
                }
                iframe {
                  border: none !important;
                  box-shadow: none !important;
                }
              `;
              document.head.appendChild(style);

              // 移除 body 的任何内联样式
              if (document.body) {
                document.body.style.boxShadow = 'none';
                document.body.style.border = 'none';
              }
            ''');
          } catch (e) {
            Logger.error('Failed to inject JavaScript: $e');
          }

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
      return Padding(
          padding: EdgeInsets.all(16.r),
          child: SizedBox(
            height: widget.height,
            child: Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor(context),
                highlightColor: AppColors.shimmerHighlightColor(context),
                child: Container(
                  width: double.infinity,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: AppColors.shimmerBaseColor(context),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                )),
          ));
    }

    // Show WebView when successfully loaded
    return ClipRRect(
      borderRadius: BorderRadius.zero, // 确保裁剪掉任何溢出的阴影
      child: SizedBox(
        height: widget.height,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/env/env.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Candlestick extends StatefulWidget {
  const Candlestick(
      {super.key,
      required this.address,
      required this.network,
      required this.symbol,
      required this.height});

  final String address;
  final double height;
  final String network;
  final String symbol;
  @override
  State<Candlestick> createState() => _CandlestickState();
}

class _CandlestickState extends State<Candlestick>
    with AutomaticKeepAliveClientMixin {
  WebViewController? _controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() async {
    if (!mounted) return;

    final url = _getCandleStickUrl();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // 允许 JS 执行
      ..enableZoom(true)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          return NavigationDecision.navigate;
        },
        onProgress: (progress) {},
        onPageStarted: (url) {
          setState(() {
            _isLoading = true;
            _hasError = false;
          });
        },
        onPageFinished: (url) {
          setState(() {
            _isLoading = false;
          });
        },
        onWebResourceError: (error) {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        },
        onHttpError: (error) {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        },
      ))
      // ..setNavigationDelegate(
      //   NavigationDelegate(
      //     onPageFinished: (String url) {
      //       // 页面加载完成后，执行JS移除缩放限制
      //       _controller?.runJavaScript(
      //           "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=10.0, user-scalable=yes');");
      //     },
      //   ),
      // )
      ..loadRequest(Uri.parse(url));

    if (mounted) {
      setState(() {});
    }
  }

  String _getCandleStickUrl() {
    return "${EnvConfig().candleStickUrl}/${widget.network}/${widget.symbol}/${widget.address}?theme=light";
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Hide widget if there's an error

    return SizedBox(
        height: widget.height,
        child: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50.w,
                      height: 50.h,
                      child: const CircularProgressIndicator(),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      S.of(context).candlestickLoading,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              )
            : _controller != null
                ? WebViewWidget(
                    controller: _controller!,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      // EagerGestureRecognizer 会立即赢得手势竞争，防止 TabView 响应
                      Factory<HorizontalDragGestureRecognizer>(
                        () => HorizontalDragGestureRecognizer(),
                      ),
                    },
                  )
                : const SizedBox.shrink());
  }
}

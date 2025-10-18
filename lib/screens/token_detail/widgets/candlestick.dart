import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/env/env.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/utils/logger.dart';
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
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() async {
    if (!mounted) return;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // 允许 JS 执行
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
      ..loadRequest(Uri.parse(_getCandleStickUrl()));

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
    if (_hasError) {
      return const SizedBox.shrink();
    }

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
            : GestureDetector(
                onHorizontalDragUpdate: (_) {
                  // 拦截水平滑动，防止触发 tab 切换
                },
                child: _controller != null
                    ? WebViewWidget(controller: _controller!)
                    : const SizedBox.shrink(),
              ));
  }
}

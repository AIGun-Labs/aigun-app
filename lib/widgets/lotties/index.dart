import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieConfig {
  const LottieConfig({
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
    this.controller,
    this.onLoaded,
    this.errorBuilder,
    this.frameRate,
    this.bundle,
  });

  final double? width;

  final double? height;

  final BoxFit fit;

  final bool repeat;

  final bool reverse;

  final bool animate;

  final AnimationController? controller;

  final void Function(LottieComposition)? onLoaded;

  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  final FrameRate? frameRate;

  /// AssetBundle
  final AssetBundle? bundle;
}

class LottieAsset extends StatefulWidget {
  const LottieAsset(
    this.assetPath, {
    super.key,
    this.config = const LottieConfig(),
    this.placeholder,
    this.loadingBuilder,
  });

  final String assetPath;

  final LottieConfig config;

  final Widget? placeholder;

  final Widget Function(BuildContext)? loadingBuilder;

  @override
  State<LottieAsset> createState() => _LottieAssetState();
}

class _LottieAssetState extends State<LottieAsset>
    with TickerProviderStateMixin {
  late AnimationController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    if (widget.config.controller == null) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );
    } else {
      _controller = widget.config.controller;
    }
    _isInitialized = true;
  }

  @override
  void didUpdateWidget(LottieAsset oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.config.controller != widget.config.controller) {
      if (oldWidget.config.controller == null) {
        _controller?.dispose();
      }

      if (widget.config.controller == null) {
        _controller = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
        );
      } else {
        _controller = widget.config.controller;
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    if (widget.config.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  void _handleLottieLoaded(LottieComposition composition) {
    if (widget.config.controller == null && _controller != null) {
      _controller!.duration = composition.duration;

      if (widget.config.animate) {
        if (widget.config.repeat) {
          _controller!.repeat(reverse: widget.config.reverse);
        } else {
          _controller!.forward();
        }
      }
    }

    widget.config.onLoaded?.call(composition);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return widget.placeholder ?? const SizedBox.shrink();
    }

    final isDotLottie = widget.assetPath.endsWith('.lottie');

    if (isDotLottie) {
      return DotLottieLoader.fromAsset(
        widget.assetPath,
        frameBuilder: (context, dotlottie) {
          if (dotlottie != null) {
            return Lottie.memory(
              dotlottie.animations.values.single,
              width: widget.config.width?.w,
              height: widget.config.height?.h,
              fit: widget.config.fit,
              controller: _controller,
              animate: widget.config.animate,
              repeat: widget.config.repeat,
              reverse: widget.config.reverse,
              frameRate: widget.config.frameRate,
              onLoaded: _handleLottieLoaded,
              errorBuilder: widget.config.errorBuilder ?? _defaultErrorBuilder,
            );
          }

          return widget.loadingBuilder?.call(context) ??
              widget.placeholder ??
              const SizedBox.shrink();
        },
      );
    } else {
      return Lottie.asset(
        widget.assetPath,
        width: widget.config.width?.w,
        height: widget.config.height?.h,
        fit: widget.config.fit,
        controller: _controller,
        animate: widget.config.animate,
        repeat: widget.config.repeat,
        reverse: widget.config.reverse,
        frameRate: widget.config.frameRate,
        onLoaded: _handleLottieLoaded,
        errorBuilder: widget.config.errorBuilder ?? _defaultErrorBuilder,
      );
    }
  }

  Widget _defaultErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Container(
      width: widget.config.width?.w ?? 50.w,
      height: widget.config.height?.h ?? 50.h,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(Icons.broken_image_outlined, size: 24.sp, color: Colors.grey),
    );
  }
}

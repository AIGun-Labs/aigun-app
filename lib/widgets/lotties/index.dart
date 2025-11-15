import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

/// Lottie动画组件配置
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

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 适应模式
  final BoxFit fit;

  /// 是否循环播放
  final bool repeat;

  /// 是否反向播放
  final bool reverse;

  /// 是否自动播放
  final bool animate;

  /// 动画控制器
  final AnimationController? controller;

  /// 加载完成回调
  final void Function(LottieComposition)? onLoaded;

  /// 错误构建器
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  /// 帧率
  final FrameRate? frameRate;

  /// AssetBundle
  final AssetBundle? bundle;
}

/// 通用的Lottie动画组件
class LottieAsset extends StatefulWidget {
  const LottieAsset(
    this.assetPath, {
    super.key,
    this.config = const LottieConfig(),
    this.placeholder,
    this.loadingBuilder,
  });

  /// 资源路径（支持 .lottie 和 .json 文件）
  final String assetPath;

  /// 配置
  final LottieConfig config;

  /// 占位符组件
  final Widget? placeholder;

  /// 加载中构建器
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
    // 如果配置了 controller，则使用配置的 controller，否则创建一个默认的 controller
    if (widget.config.controller == null) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1), // 设置默认时长
      );
    } else {
      _controller = widget.config.controller;
    }
    _isInitialized = true;
  }

  @override
  void didUpdateWidget(LottieAsset oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果配置的 controller 改变了，则重新创建一个 controller
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
    // 如果配置了 controller，则使用配置的 controller，否则释放 controller
    if (widget.config.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  void _handleLottieLoaded(LottieComposition composition) {
    // 设置正确的动画时长
    if (widget.config.controller == null && _controller != null) {
      _controller!.duration = composition.duration;

      // 根据配置启动动画
      if (widget.config.animate) {
        if (widget.config.repeat) {
          _controller!.repeat(reverse: widget.config.reverse);
        } else {
          _controller!.forward();
        }
      }
    }

    // 调用用户的回调
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
      // 处理 .json 文件
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
      BuildContext context, Object error, StackTrace? stackTrace) {
    return Container(
      width: widget.config.width?.w ?? 50.w,
      height: widget.config.height?.h ?? 50.h,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        Icons.broken_image_outlined,
        size: 24.sp,
        color: Colors.grey,
      ),
    );
  }
}

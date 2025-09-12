import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:video_player/video_player.dart';

/// 一个简洁的、可复用的视频播放器组件
///
/// 只需提供一个网络视频的 URL，即可拥有一个功能完整的播放器。
class IntelVideoPlayer extends StatefulWidget {
  /// 网络视频的 URL
  final String url;

  /// 占位图，可选
  ///
  /// 在视频初始化或加载时显示。
  final Widget? placeholder;

  /// 视频的宽高比，可选
  ///
  /// 如果不提供，默认会尝试使用视频本身的宽高比，如果获取失败，则使用 16/9。
  final double? aspectRatio;

  const IntelVideoPlayer({
    super.key,
    required this.url,
    this.placeholder,
    this.aspectRatio,
  });

  @override
  State<IntelVideoPlayer> createState() => _IntelVideoPlayerState();
}

class _IntelVideoPlayerState extends State<IntelVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // 基于传入的 url 初始化 video aplayer acontroller
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));

    // 使用一个 Future 来跟踪初始化过程，以便在 FutureBuilder 中使用
    _initializeVideoPlayerFuture =
        _videoPlayerController.initialize().then((_) {
      // 初始化完成后，创建 ChewieController
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        // autoPlay: true, // 可以根据需求调整
        looping: false,
        // 如果外部传入了宽高比，则使用它；否则尝试使用视频自身的宽高比
        aspectRatio:
            widget.aspectRatio ?? _videoPlayerController.value.aspectRatio,
      );
      // 立即刷新一帧，让 ChewieController 生效
      setState(() {});
    });
  }

  @override
  void dispose() {
    // 销毁所有控制器，释放资源
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // 如果 video aplayer 初始化完成，则显示视频
          // Chewie Widget 内部已经处理好了 UI 的展示
          if (_chewieController != null) {
            return AspectRatio(
              aspectRatio: _chewieController!.aspectRatio!,
              child: Chewie(
                controller: _chewieController!,
              ),
            );
          } else {
            // 如果 ChewieController 初始化失败，显示错误信息
            return AspectRatio(
              aspectRatio: widget.aspectRatio ?? 16 / 9,
              child: Center(
                child: Text(S.of(context).videoInitializationFailed),
              ),
            );
          }
        } else {
          // 如果 video aplayer 还在初始化，则显示一个加载指示器或占位图
          return AspectRatio(
            aspectRatio: widget.aspectRatio ?? 16 / 9,
            child: widget.placeholder ??
                const Center(
                  child: CircularProgressIndicator(),
                ),
          );
        }
      },
    );
  }
}

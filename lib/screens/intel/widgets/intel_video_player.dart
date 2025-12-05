import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../l10n/l10n.dart';

///

class IntelVideoPlayer extends StatefulWidget {
  final String url;

  ///

  final Widget? placeholder;

  ///

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

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((
      _,
    ) {
      if (!mounted) return;

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,

        looping: false,

        aspectRatio:
            widget.aspectRatio ?? _videoPlayerController.value.aspectRatio,

        allowPlaybackSpeedChanging: true,

        optionsTranslation: OptionsTranslation(
          playbackSpeedButtonText: S.of(context).playbackSpeed,
          subtitlesButtonText: S.of(context).subtitles,
          cancelButtonText: S.of(context).cancel,
        ),
      );

      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_chewieController != null) {
      _chewieController?.dispose();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        looping: false,
        aspectRatio:
            widget.aspectRatio ?? _videoPlayerController.value.aspectRatio,
        allowPlaybackSpeedChanging: true,

        optionsTranslation: OptionsTranslation(
          playbackSpeedButtonText: S.of(context).playbackSpeed,
          subtitlesButtonText: S.of(context).subtitles,
          cancelButtonText: S.of(context).cancel,
        ),
      );
      setState(() {});
    }
  }

  @override
  void dispose() {
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
          if (_chewieController != null) {
            return AspectRatio(
              aspectRatio: _chewieController!.aspectRatio!,
              child: Chewie(controller: _chewieController!),
            );
          } else {
            return AspectRatio(
              aspectRatio: widget.aspectRatio ?? 16 / 9,
              child: Center(
                child: Text(S.of(context).videoInitializationFailed),
              ),
            );
          }
        } else {
          return AspectRatio(
            aspectRatio: widget.aspectRatio ?? 16 / 9,
            child:
                widget.placeholder ??
                const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'intel_video_player.dart';

class IntelPlayerList extends StatelessWidget {
  const IntelPlayerList({super.key, required this.urls});

  final List<String> urls;

  // List<BetterPlayerDataSource> _buildPlayerList(List<IntelMedia> medias) {
  //   return medias
  //       .where((media) => media.type == "video")
  //       .map((media) => BetterPlayerDataSource(
  //             BetterPlayerDataSourceType.network,
  //             media.url ?? '',
  //           ))
  //       .toList();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return AspectRatio(
  //     aspectRatio: 16 / 9,
  //     child: BetterPlayerPlaylist(
  //       betterPlayerConfiguration: BetterPlayerConfiguration(),
  //       betterPlayerPlaylistConfiguration:
  //           const BetterPlayerPlaylistConfiguration(),
  //       betterPlayerDataSourceList: _buildPlayerList(medias),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      spacing: 6.h,
      children: [
        8.verticalSpace, // 顶部间距，只有在有视频时才生效
        // ListView.separated(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemCount: medias.length,
        //   separatorBuilder: (context, index) {
        //     return const SizedBox(height: 12);
        //   },
        //   itemBuilder: (context, index) {
        //     final media = medias[index];

        //     return VideoPlayer(media: media);
        //   },
        // ),
        ...urls.map((url) => VideoPlayer(url: url)),

        // SizedBox(height: 8.h), // 底部间距，只有在有视频时才生效
        8.verticalSpace,
      ],
    );
  }
}

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.black,
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: IntelVideoPlayer(url: url),
      ),
    );
  }
}

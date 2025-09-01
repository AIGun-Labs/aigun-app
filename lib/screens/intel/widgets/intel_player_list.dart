import 'package:flutter/material.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_video_player.dart';

class IntelPlayerList extends StatelessWidget {
  const IntelPlayerList({super.key, required this.medias});

  final List<IntelMedia> medias;

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
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: medias.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final media = medias[index];

        return _buildVideoPlayer(media);
      },
    );
  }

  Widget _buildVideoPlayer(IntelMedia media) {
    if (media.url == null || media.type != MediaType.video) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.black,
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: IntelVideoPlayer(url: media.url!),
      ),
    );
  }
}

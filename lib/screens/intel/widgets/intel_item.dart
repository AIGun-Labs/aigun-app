import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/data/models/intel/intel.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_player_list.dart";
import "package:flutter_aigun/screens/intel/widgets/token_list.dart";
import "package:flutter_aigun/themes/colors.dart";
import "package:flutter_aigun/utils/resource.dart";
import "package:flutter_aigun/widgets/smart_network_image.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class IntelMessageItem extends StatefulWidget {
  const IntelMessageItem({super.key, required this.intel});

  final Intel intel;

  @override
  State<IntelMessageItem> createState() => _IntelMessageItemState();
}

class _IntelMessageItemState extends State<IntelMessageItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final intelCreateAt =
        "${widget.intel.createdAt?.hour.toString().padLeft(2, '0')}:${widget.intel.createdAt?.minute.toString().padLeft(2, '0')} ${widget.intel.createdAt?.month.toString().padLeft(2, "0")}-${widget.intel.createdAt?.day.toString().padLeft(2, "0")}";

    final text = widget.intel.analyzed?.en ?? widget.intel.analyzed?.zh;

    return Container(
      key: ValueKey(widget.intel.id),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
              createAt: intelCreateAt,
              aiAgent: widget.intel.aiAgent,
              author: widget.intel.author),
          // 在这里监听 token 的信息变化，如果变化了，则重新构建 TokenInfo 组件
          IntelTokenList(tokens: widget.intel.entities),
          _buildAuthorInfo(widget.intel), // author info
          _buildExpandableText(text), // intel ai analyzed content
          _buildPlayerList(
              _getMediasByType(widget.intel.medias, MediaType.video)),
          // const SizedBox(
          //   height: 3,
          // ),
          _buildResourcesGrid(// intel media resources
              _getMediasByType(widget.intel.medias, MediaType.image)),
          _buildMessage(
              analyzedTime: widget.intel.analyzedTime,
              monitorTime: widget.intel.monitorTime),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo(Intel? intel) {
    final author = intel?.author;
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: SmartNetworkImage(url: getImageUrl(author?.avatar) ?? ""),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("@${author?.slug ?? ""}"), // author name
                  // Icon(Icons.arrow_forward_ios),
                  SmartNetworkImage(
                      url: getImageUrl(author?.platform?.logo) ??
                          ""), // platform logo
                  Text(intel?.publishedAt?.toString() ??
                      ""), // intel published time
                ],
              ),
              Text(author?.prompt ?? "") // intel content
            ],
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  // Widget _buildAuthorInfo(Author? author) {
  //   return Container(
  //     padding: const EdgeInsets.all(12),
  //     color: Colors.grey[200],
  //     child: Row(
  //       children: [
  //         CircleAvatar(
  //           radius: 10,
  //           child: ClipOval(
  //             child: CachedNetworkImage(
  //               imageUrl: getImageUrl(author?.avatar) ?? "",
  //             ),
  //           ),
  //         ),
  //         Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Text(author?.platform?.name ?? ""),
  //                 Text(author?.platform?.logo ?? ""),
  //               ],
  //             ),
  //             Text(author?.slug ?? "")
  //           ],
  //         ),
  //         const Icon(Icons.arrow_forward_ios)
  //       ],
  //     ),
  //   );
  // }

  Widget _buildExpandableText(String? text) {
    if (text!.isEmpty) {
      return const Text("No Analyzed");
    }

    return LayoutBuilder(
      builder: (context, size) {
        final TextSpan textSpan = TextSpan(
          text: text,
          style: const TextStyle(fontSize: 16),
        );

        final TextPainter textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: 5,
        );
        textPainter.layout(maxWidth: size.maxWidth);

        if (textPainter.didExceedMaxLines) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 16),
                maxLines: _isExpanded ? null : 5,
                overflow: _isExpanded ? null : TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Collapse' : 'Expand',
                  style: const TextStyle(
                    color: AppColors.yellow,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Text(
            text,
            style: const TextStyle(fontSize: 16),
          );
        }
      },
    );
  }

  List<IntelMedia> _getMediasByType(List<IntelMedia>? medias, MediaType type) {
    if (medias == null) return [];

    return medias.where((media) => media.type == type).toList();
  }

  Widget _buildPlayerList(List<IntelMedia>? medias) {
    return IntelPlayerList(medias: medias ?? []);
  }

  Widget _buildResourcesGrid(List<IntelMedia>? medias) {
    if (medias == null) return const SizedBox.shrink();
    return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        childAspectRatio: 1,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(medias.length, (index) {
          final media = medias[index];
          // if (media.type != MediaType.image) {
          return CachedNetworkImage(
            imageUrl: getImageUrl(media.url) ?? "",
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 18.w,
              height: 18.w,
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: 18.w,
              height: 18.w,
              color: Colors.grey[200],
              child: const Icon(Icons.error),
            ),
          );
          // }
        }));
  }

  Widget _buildMessage({
    required double? analyzedTime,
    required double? monitorTime,
  }) {
    final analyzedTimeStr = ((analyzedTime ?? 0) * 1000).toInt();
    final monitorTimeStr = ((monitorTime ?? 0) * 1000).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("AIGun：The world's fastest AI monitoring and analysis"),
        Row(
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 5),
            Text("Event monitor: $monitorTimeStr s"),
            const SizedBox(
              width: 10,
            ),
            Text("AI analysis: $analyzedTimeStr s"),
          ],
        )
      ],
    );
  }

  Widget _buildHeader(
      {required String createAt,
      required AIAgent? aiAgent,
      required Author? author}) {
    final tokenAvatar = author?.platform?.logo ?? '';
    return Row(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 28,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: getImageUrl(aiAgent?.avatar) ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 56.w,
                    height: 56.w,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 56.w,
                    height: 56.w,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, size: 28),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  aiAgent?.name ?? "",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  createAt,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ],
        ),
        const Spacer(),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.more_horiz),
            // Row(
            //   spacing: 4.w,
            //   children: [
            //     CircleAvatar(
            //       radius: 10,
            //       child: ClipOval(
            //         child: CachedNetworkImage(
            //           imageUrl: getImageUrl(author?.avatar) ?? "",
            //           fit: BoxFit.cover,
            //           placeholder: (context, url) => Container(
            //             width: 20.w,
            //             height: 20.w,
            //             color: Colors.grey[200],
            //             child: const Center(
            //               child: CircularProgressIndicator(strokeWidth: 1),
            //             ),
            //           ),
            //           errorWidget: (context, url, error) => Container(
            //             width: 20.w,
            //             height: 20.w,
            //             color: Colors.grey[200],
            //             child: const Icon(Icons.person, size: 12),
            //           ),
            //         ),
            //       ),
            //     ),
            //     CircleAvatar(
            //       radius: 10,
            //       child: ClipOval(
            //         child: CachedNetworkImage(
            //           imageUrl: getImageUrl(tokenAvatar) ?? "",
            //           fit: BoxFit.cover,
            //           placeholder: (context, url) => Container(
            //             width: 20.w,
            //             height: 20.w,
            //             color: Colors.grey[200],
            //             child: const Center(
            //               child: CircularProgressIndicator(strokeWidth: 1),
            //             ),
            //           ),
            //           errorWidget: (context, url, error) => Container(
            //             width: 20.w,
            //             height: 20.w,
            //             color: Colors.grey[200],
            //             child: const Icon(Icons.image, size: 12),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Text(
            //       "@${author?.slug ?? ''}",
            //       style: const TextStyle(color: Colors.grey),
            //     )
            //   ],
            // )
          ],
        )
      ],
    );
  }
}

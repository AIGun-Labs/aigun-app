import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/data/models/intel/intel.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_player_list.dart";
import "package:flutter_aigun/screens/intel/widgets/token_list.dart";
import "package:flutter_aigun/themes/colors.dart";
import "package:flutter_aigun/utils/format/date.dart";
import "package:flutter_aigun/utils/resource.dart";
import "package:flutter_aigun/widgets/smart_network_image.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:photo_view/photo_view.dart";
import "package:photo_view/photo_view_gallery.dart";

class IntelMessageItem extends StatefulWidget {
  const IntelMessageItem({super.key, required this.intel});

  final Intel intel;

  @override
  State<IntelMessageItem> createState() => _IntelMessageItemState();
}

class _IntelMessageItemState extends State<IntelMessageItem> {
  bool _isExpanded = false;

  /// 打开图片预览对话框
  void _openImagePreview(List<IntelMedia> images, int initialIndex) {
    int currentIndex = initialIndex;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog.fullscreen(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                itemCount: images.length,
                builder: (context, index) {
                  final imageUrl = getImageUrl(images[index].url) ?? "";
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(imageUrl),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                pageController: PageController(initialPage: initialIndex),
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              // 关闭按钮
              Positioned(
                top: 40.h,
                right: 20.w,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // 图片计数器
              Positioned(
                bottom: 40.h,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${currentIndex + 1} / ${images.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: SmartNetworkImage(
                url: getImageUrl(author?.avatar) ?? "",
                width: 40.w,
                height: 40.w),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.w,
                children: [
                  Text("@${author?.slug ?? ""}"), // author name
                  // SmartNetworkImage(
                  //     height: 16.h,
                  //     width: 16.w,
                  //     url: getImageUrl(author?.platform?.logo) ??
                  //         ""), // platform logo
                  CachedNetworkImage(
                      height: 16.h,
                      width: 16.w,
                      imageUrl: getImageUrl(author?.platform?.logo) ?? ""),
                  // Text(intel?.publishedAt?.toString() ??
                  //     ""), // intel published time
                  Text(formatDate(intel?.publishedAt ?? DateTime.now(),
                      format: "HH:mm"))
                ],
              ),
              Text(
                author?.prompt ?? "",
                softWrap: true,
                // maxLines: null, // 移除行数限制，允许无限换行
                // 或者设置更大的行数限制：
                maxLines: 2, // 允许最多5行
                overflow: TextOverflow.ellipsis, // 超出5行时显示省略号
              ) // intel content
            ],
          ),
          Expanded(child: SizedBox.shrink()),
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
      // return const Text("No Analyzed");
      return const SizedBox.shrink();
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
          return GestureDetector(
            onTap: () => _openImagePreview(medias, index),
            child: Hero(
              tag: 'image_$index',
              child: CachedNetworkImage(
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
              ),
            ),
          );
          // }
        }));
  }

  Widget _buildMessage({
    required double? analyzedTime,
    required double? monitorTime,
  }) {
    final analyzedTimeStr = ((analyzedTime ?? 0) / 1000).toInt();
    final monitorTimeStr = ((monitorTime ?? 0) / 1000).toInt();

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

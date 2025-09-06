import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/data/models/intel/intel.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_player_list.dart";
import "package:flutter_aigun/screens/intel/widgets/token_list.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/format/date.dart";
import "package:flutter_aigun/utils/timezone_utils.dart";
import "package:flutter_aigun/utils/format/number.dart";
import "package:flutter_aigun/utils/resource.dart";
import "package:flutter_aigun/utils/url.dart";
import "package:flutter_aigun/widgets/image.dart";
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
          // backgroundColor: AppColors.background(context),
          backgroundColor: Colors.transparent,
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
                backgroundDecoration: BoxDecoration(
                  color: AppColors.background(context),
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
                  icon: Icon(
                    Icons.close,
                    color: AppColors.textSecondary(context),
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
                      color: Colors.black.withValues(alpha: 0.5),
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
    final intelCreateAt = TimezoneUtils.formatTimeToLocal(
        widget.intel.createdAt!,
        format: "HH:mm MM-dd");
    // final intelCreateAt =
    //     "${widget.intel.createdAt?.hour.toString().padLeft(2, '0')}:${widget.intel.createdAt?.minute.toString().padLeft(2, '0')} ${widget.intel.createdAt?.month.toString().padLeft(2, "0")}-${widget.intel.createdAt?.day.toString().padLeft(2, "0")}";

    // final text = widget.intel.analyzed?.en != null
    //     ? widget.intel.analyzed?.en
    //     : widget.intel.analyzed?.zh;

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
          _buildExpandableText(
              widget.intel.analyzed?.zh), // intel ai analyzed content
          _buildPlayerList(
              _getMediasByType(widget.intel.medias, MediaType.video)),
          // const SizedBox(
          //   height: 3,z
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

  Widget _buildAuthorInfo(Intel intel) {
    final author = intel.author;
    return GestureDetector(
      onTap: () {
        launchUrl(intel.sourceUrl ?? "");
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card(context),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SmartNetworkImage(
                  errorWidget: CachedImage(
                      height: 40.w,
                      width: 40.w,
                      imageUrl: "assets/images/icons/ai-agent.png"),
                  url: getImageUrl(author?.avatar) ?? "",
                  width: 40.w,
                  height: 40.w),
            ),
            SizedBox(width: 12.w),
            // 使用Expanded包裹文字区域，确保文字不会被压缩
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "@${author?.slug ?? ""}",
                        style:
                            TextStyle(color: AppColors.textSecondary(context)),
                      ), // author name
                      SizedBox(width: 4.w),
                      ClipOval(
                        child: SmartNetworkImage(
                          url: getImageUrl(author?.platform?.logo) ?? "",
                          height: 16.h,
                          width: 16.w,
                          errorWidget: CachedImage(
                              height: 16.h,
                              width: 16.w,
                              imageUrl:
                                  "assets/images/logo/app-logo-trans.png"),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "${formatDate(intel.publishedAt ?? DateTime.now(), format: "HH:mm")} (${TimezoneUtils.getDeviceTimezone()})",
                        style:
                            TextStyle(color: AppColors.textSecondary(context)),
                      ),
                      // 确保时间文本不会被截断
                      const SizedBox(width: 8),
                    ],
                  ),
                  Text(
                    author?.prompt ?? "",
                    softWrap: true,
                    maxLines: 2, // 最多显示2行
                    overflow: TextOverflow.ellipsis, // 超出2行时显示省略号(...)
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary(context),
                      height: 1.3, // 行高，改善可读性
                    ),
                  ) // intel content
                ],
              ),
            ),
            // 右边图标区域，固定宽度避免被压缩
            SizedBox(
              width: 24.w, // 固定宽度
              child: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
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
      // return const SizedBox.shrink();
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
                    color: AppColors.primary,
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
                  color: AppColors.card(context),
                  child: const Center(
                    child: Text("图片加载失败！"),
                  ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "AIGun：The world's fastest AI monitoring and analysis",
          style: TextStyle(color: AppColors.textTertiary(context)),
        ),
        Row(
          children: [
            Icon(Icons.access_time, color: AppColors.textTertiary(context)),
            const SizedBox(width: 5),
            Text(
              "Event monitor: ${convertMillisecondToSecond(monitorTime ?? 0)} s",
              style: TextStyle(color: AppColors.textTertiary(context)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "AI analysis: ${convertMillisecondToSecond(analyzedTime ?? 0)} s",
              style: TextStyle(color: AppColors.textTertiary(context)),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildHeader(
      {required String createAt,
      required AIAgent? aiAgent,
      required Author? author}) {
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
                  placeholder: (context, url) => CachedImage(
                    imageUrl: "assets/images/icons/ai-agent.png",
                    height: 56.w,
                    width: 56.w,
                  ),
                  errorWidget: (context, url, error) => CachedImage(
                    imageUrl: "assets/images/icons/ai-agent.png",
                    height: 56.w,
                    width: 56.w,
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

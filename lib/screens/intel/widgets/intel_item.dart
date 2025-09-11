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
import "package:flutter_markdown/flutter_markdown.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
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
        widget.intel.createdAt,
        format: "HH:mm MM-dd");

    final analyzed = widget.intel.analyzed?.en?.isEmpty == true
        ? widget.intel.analyzed?.zh
        : widget.intel.analyzed?.en;

    return Container(
      key: ValueKey(widget.intel.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                spacing: 8.h,
                children: [
                  // 只有当 aiAgent 和 author 都不为空时才显示头部
                  if (widget.intel.aiAgent != null &&
                      widget.intel.author != null)
                    _buildHeader(
                        createAt: intelCreateAt,
                        aiAgent: widget.intel.aiAgent,
                        author: widget.intel.author),
                  IntelTokenList(tokens: widget.intel.entities),
                  // 只有当 author 不为空时才显示作者信息
                  if (widget.intel.author != null)
                    _buildAuthorInfo(widget.intel),
                  // 使用条件渲染，完全避免创建不可见组件
                  if (analyzed != null) _buildMarkdownContent(analyzed),
                  if (widget.intel.medias != null &&
                      widget.intel.medias!.isNotEmpty)
                    _buildPlayerList(
                        _getMediasByType(widget.intel.medias, MediaType.video)),
                  if (widget.intel.medias != null &&
                      widget.intel.medias!.isNotEmpty)
                    _buildResourcesGrid(// intel media resources
                        _getMediasByType(widget.intel.medias, MediaType.image)),
                  if (widget.intel.analyzedTime != null &&
                      widget.intel.monitorTime != null)
                    _buildMessage(
                        analyzedTime: widget.intel.analyzedTime,
                        monitorTime: widget.intel.monitorTime)
                ],
              ))
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
          color: AppColors.quinary,
          borderRadius: BorderRadius.circular(5.r),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SmartNetworkImage(
                  errorWidget: CachedImage(
                      height: 50.h,
                      width: 50.w,
                      imageUrl: "assets/images/icons/ai-agent.png"),
                  url: getImageUrl(author?.avatar) ?? "",
                  width: 50.w,
                  height: 50.w),
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
                              height: 14.h,
                              width: 14.w,
                              imageUrl:
                                  "assets/images/logo/app-logo-foreground.png"),
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
    if (text?.isEmpty == true) {
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
                text ?? '',
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
                  _isExpanded ? '收起' : '展开',
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Text(
            text ?? '',
            style: const TextStyle(fontSize: 16),
          );
        }
      },
    );
  }

  Widget _buildMarkdownContent(String text) {
    return MarkdownBody(
      data: text,
      shrinkWrap: true,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(fontSize: 16.sp),
        h1: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        h2: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        h3: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        a: const TextStyle(
            color: Colors.blue, decoration: TextDecoration.underline),
        blockquote: TextStyle(
          color: Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
        code: TextStyle(
          backgroundColor: Colors.grey[200],
          fontFamily: 'monospace',
        ),
      ),
      onTapLink: (text, href, title) {
        if (href != null) {
          launchUrl(href);
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
    if (medias == null || medias.isEmpty) return const SizedBox.shrink();
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
                  color: AppColors.card(context),
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
          style: TextStyle(
              color: AppColors.textTertiary(context), fontSize: 12.sp),
        ),
        Row(
          children: [
            // Icon(Icons.access_time, color: AppColors.textTertiary(context)),
            SvgPicture.asset(
              "assets/images/icons/time-monitor.svg",
              width: 17.w,
              height: 17.h,
              colorFilter: ColorFilter.mode(
                AppColors.textTertiary(context),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "Event monitor: ${convertMillisecondToSecond(monitorTime ?? 0)} s",
              style: TextStyle(
                  color: AppColors.textTertiary(context), fontSize: 12.sp),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "AI analysis: ${convertMillisecondToSecond(analyzedTime ?? 0)} s",
              style: TextStyle(
                  color: AppColors.textTertiary(context), fontSize: 12.sp),
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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              width: 45.w,
              height: 45.h,
              imageUrl: getImageUrl(aiAgent?.avatar) ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) => CachedImage(
                imageUrl: "assets/images/icons/ai-agent.png",
                height: 45.h,
                width: 45.w,
              ),
              errorWidget: (context, url, error) => CachedImage(
                imageUrl: "assets/images/icons/ai-agent.png",
                height: 45.h,
                width: 45.w,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  // aiAgent?.name ?? "",
                  "事件猎人",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  createAt,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary(context),
                  ),
                )
              ],
            ),
          ),
          SvgPicture.asset(
            "assets/images/icons/shared.svg",
            width: 24.w,
            height: 24.h,
          ),
        ],
      ),
    );
  }
}

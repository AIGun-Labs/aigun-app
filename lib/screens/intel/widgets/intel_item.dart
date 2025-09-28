import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/data/models/intel/intel.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_player_list.dart";
import "package:flutter_aigun/screens/intel/widgets/token_list.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/format/date.dart";
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
  const IntelMessageItem({super.key, required this.intel, required this.index});

  final Intel intel;
  final int index;

  @override
  State<IntelMessageItem> createState() => _IntelMessageItemState();
}

class _IntelMessageItemState extends State<IntelMessageItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // 根据用户地区格式化时间
    final intelCreateAt = DateUtilsHelper.formatUtcToLocal(
        widget.intel.createdAt ?? DateTime.now(), "HH:mm MM-dd");

    final analyzed = widget.intel.analyzed?.en?.isEmpty == true
        ? widget.intel.analyzed?.zh
        : widget.intel.analyzed?.en;

    return Padding(
      padding: EdgeInsets.only(top: widget.index == 0 ? 10.h : 0),
      child: Container(
        color: Colors.white,
        key: ValueKey(widget.intel.id),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 8.h,
            children: [
              // 只有当 aiAgent 和 author 都不为空时才显示头部
              IntelHeader(
                  createAt: intelCreateAt,
                  aiAgent: widget.intel.aiAgent,
                  author: widget.intel.author),
              IntelTokenList(tokens: widget.intel.entities),
              // 只有当 author 不为空时才显示作者信息
              if (widget.intel.author != null)
                IntelAuthorInfo(intel: widget.intel),
              // 使用条件渲染，完全避免创建不可见组件
              if (analyzed != null)
                IntelMarkdownContent(
                    text: analyzed,
                    isExpanded: _isExpanded,
                    onTap: (isExpanded) {
                      setState(() {
                        _isExpanded = isExpanded;
                      });
                    }),
              if (widget.intel.medias != null &&
                  widget.intel.medias!.isNotEmpty)
                IntelPlayerList(
                    medias:
                        _getMediasByType(widget.intel.medias, MediaType.video)),
              if (widget.intel.medias != null &&
                  widget.intel.medias!.isNotEmpty)
                IntelResourcesGrid(
                    medias:
                        _getMediasByType(widget.intel.medias, MediaType.image),
                    onTap: (medias, index) => _openImagePreview(medias, index)),

              if (widget.intel.analyzedTime != null &&
                  widget.intel.monitorTime != null)
                IntelMessage(
                    analyzedTime: widget.intel.analyzedTime,
                    monitorTime: widget.intel.monitorTime)
            ],
          ),
        ),
      ),
    );
  }

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

  List<IntelMedia> _getMediasByType(List<IntelMedia>? medias, MediaType type) {
    if (medias == null) return [];

    return medias.where((media) => media.type == type).toList();
  }
}

class IntelAuthorInfo extends StatelessWidget {
  const IntelAuthorInfo({super.key, required this.intel});

  final Intel intel;

  @override
  Widget build(BuildContext context) {
    final author = intel.author;

    final publishedAt = DateUtilsHelper.formatUtcToLocal(
        intel.publishedAt ?? DateTime.now(), "HH:mm");

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
                        publishedAt,
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
}

class IntelMarkdownContent extends StatefulWidget {
  const IntelMarkdownContent({
    super.key,
    required this.text,
    required this.isExpanded,
    required this.onTap,
  });

  final String text;
  final bool isExpanded;
  final Function(bool) onTap;

  @override
  State<IntelMarkdownContent> createState() => _IntelMarkdownContentState();
}

class _IntelMarkdownContentState extends State<IntelMarkdownContent> {
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(IntelMarkdownContent oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final markdownStyle = MarkdownStyleSheet(
      p: TextStyle(fontSize: 16.sp, height: 1.4),
      h1: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, height: 1.4),
      h2: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, height: 1.4),
      h3: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, height: 1.4),
      a: const TextStyle(
          height: 1.4,
          color: Colors.blue,
          decoration: TextDecoration.underline),
      blockquote: TextStyle(
        height: 1.4,
        color: Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
      code: TextStyle(
        height: 1.4,
        backgroundColor: Colors.grey[200],
        fontFamily: 'monospace',
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // 基于字体大小计算收起时的高度，确保显示完整的行
            final lineHeight = 16.sp * 1.4; // 行高 = 字体大小 * 行间距系数
            const maxLines = 3; // 收起时显示的行数
            final collapsedHeight = lineHeight * maxLines;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: widget.isExpanded ? null : collapsedHeight,
              clipBehavior: Clip.hardEdge, // 裁剪超出的内容
              decoration:
                  const BoxDecoration(), // 需要添加decoration才能使clipBehavior生效
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(), // 禁用滚动
                    child: MarkdownBody(
                      key: _key,
                      data: widget.text,
                      shrinkWrap: true,
                      styleSheet: markdownStyle,
                      onTapLink: (text, href, title) {
                        if (href != null) {
                          launchUrl(href);
                        }
                      },
                    ),
                  ),
                  if (!widget.isExpanded)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: lineHeight * 1.5, // 渐变区域高度为1.5行
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withValues(alpha: 0),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withValues(alpha: 0.7),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withValues(alpha: 0.95),
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                            stops: const [0.0, 0.3, 0.7, 1.0],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => widget.onTap(!widget.isExpanded),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.isExpanded
                    ? S.of(context).collapse
                    : S.of(context).expand,
                style: TextStyle(
                  color: AppColors.textSecondary(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 4.w),
              AnimatedRotation(
                turns: widget.isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.sp,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IntelResourcesGrid extends StatelessWidget {
  const IntelResourcesGrid(
      {super.key, required this.medias, required this.onTap});
  final List<IntelMedia>? medias;
  final Function(List<IntelMedia>, int) onTap;

  @override
  Widget build(BuildContext context) {
    if (medias == null || medias?.isEmpty == true)
      return const SizedBox.shrink();
    return GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        childAspectRatio: 1,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(medias?.length ?? 0, (index) {
          final media = medias?[index];
          // if (media.type != MediaType.image) {
          return GestureDetector(
            onTap: () => onTap(medias ?? [], index),
            child: Hero(
              tag: 'image_$index',
              child: CachedNetworkImage(
                imageUrl: getImageUrl(media?.url) ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 18.w,
                  height: 18.h,
                  color: AppColors.card(context),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 18.w,
                  height: 18.h,
                  color: AppColors.card(context),
                  child: Center(
                    child: Text(S.of(context).imageLoadFailed),
                  ),
                ),
              ),
            ),
          );
          // }
        }));
  }
}

class IntelMessage extends StatelessWidget {
  const IntelMessage(
      {super.key, required this.analyzedTime, required this.monitorTime});

  final double? analyzedTime;
  final double? monitorTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // "AIGun：The world's fastest AI monitoring and analysis",
          "AIGun：${S.of(context).intel_worldsFastest}",
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
              // "Event monitor: ${convertMillisecondToSecond(monitorTime ?? 0)} s",
              S.of(context).intel_eventMonitor(
                  convertMillisecondToSecond(monitorTime ?? 0)),
              style: TextStyle(
                  color: AppColors.textTertiary(context), fontSize: 12.sp),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              // "AI analysis: ${convertMillisecondToSecond(analyzedTime ?? 0)} s",
              S.of(context).inte_aiAnalysis(
                  convertMillisecondToSecond(analyzedTime ?? 0)),
              style: TextStyle(
                  color: AppColors.textTertiary(context), fontSize: 12.sp),
            ),
          ],
        )
      ],
    );
  }
}

class IntelHeader extends StatelessWidget {
  const IntelHeader(
      {super.key,
      required this.aiAgent,
      required this.createAt,
      required this.author});

  final AIAgent? aiAgent;
  final String createAt;
  final Author? author;
  @override
  Widget build(BuildContext context) {
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
                Text(
                  // aiAgent?.name ?? "",
                  S.of(context).eventHunter,
                  style: const TextStyle(
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

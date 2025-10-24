import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_aigun/data/models/intel/intel.dart";
import "package:flutter_aigun/l10n/l10n.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item/intel_author_info.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item/intel_header.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item/intel_markdown.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item/intel_resources_grid.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_player_list.dart";
import "package:flutter_aigun/screens/intel/widgets/token_list.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/format/date.dart";
import "package:flutter_aigun/utils/image_utils.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:photo_view/photo_view.dart";
import "package:photo_view/photo_view_gallery.dart";
import "package:flutter_aigun/screens/intel/widgets/intel_item/intel_message.dart";

class IntelItemInfo extends StatefulWidget {
  const IntelItemInfo({super.key, required this.intel, required this.index});

  final Intel intel;
  final int index;

  @override
  State<IntelItemInfo> createState() => _IntelItemInfoState();
}

class _IntelItemInfoState extends State<IntelItemInfo> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // createdAt 已在数据层转换为本地时间，直接格式化即可
    final intelCreateAt = formatDate(widget.intel.createdAt ?? DateTime.now(),
        format: "HH:mm MM-dd");

    final newText = _getAnalyzedText();
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
              if (newText.isNotEmpty)
                IntelMarkdownContent(
                    text: newText,
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
                    onTap: (medias, index) => _openImagePreview(medias, index),
                    uniquePrefix: 'intel_${widget.intel.id}'),

              if (widget.intel.analyzedTime != null &&
                  widget.intel.monitorTime != null)
                IntelMessageInfo(
                    analyzedTime: widget.intel.analyzedTime,
                    monitorTime: widget.intel.monitorTime)
            ],
          ),
        ),
      ),
    );
  }

  String _getAnalyzedText() {
    final analyzed = widget.intel.analyzed?.en?.isEmpty == true
        ? widget.intel.analyzed?.zh
        : widget.intel.analyzed?.en;
    if (widget.intel.isAlpha ?? false) {
      return analyzed ?? "";
    }

    final newText = (widget.intel.entities?.length ?? 0) > 0
        ? analyzed
        : "${analyzed ?? ""} ${S.of(context).tokenNotTrading(S.of(context).relatedToken)}";

    return newText ?? "";
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
                  final imageUrl =
                      ImageUtils.getImageProxyUrl(images[index].url);
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

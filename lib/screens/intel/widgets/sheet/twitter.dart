import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../../core/utils/twitter_image_utils.dart';
import '../../../../data/models/index.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../shared/presentation/widgets/external_link.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/image_utils.dart';
import '../../../../widgets/feature_image.dart';
import '../intel_item/intel_resources_grid.dart';

enum ContentLanguage { zh, en, original }

class TwitterSheet extends StatefulWidget {
  const TwitterSheet({
    super.key,
    required this.sourceUrl,
    required this.avatar,
    required this.slug,
    required this.platformLogo,
    required this.time,
    required this.content,
    this.medias,
  });

  final String sourceUrl;
  final String avatar;
  final String slug;
  final String? platformLogo;
  final String time;
  final Multilingual content;
  final List<IntelMedia>? medias;

  @override
  State<TwitterSheet> createState() => _TwitterSheetState();
}

class _TwitterSheetState extends State<TwitterSheet> {
  ContentLanguage _selectedLanguage = ContentLanguage.original;

  @override
  void initState() {
    super.initState();
  }

  /// 根据选中的语言获取内容
  String _getContentByLanguage() {
    switch (_selectedLanguage) {
      case ContentLanguage.zh:
        return widget.content.zh ?? widget.content.original ?? '';
      case ContentLanguage.en:
        return widget.content.en ?? widget.content.original ?? '';
      case ContentLanguage.original:
        return widget.content.original ?? '';
    }
  }

  /// 是否显示语言切换器（至少有2种语言有内容才显示）
  bool _shouldShowLanguageSwitcher() {
    int count = 0;
    if (widget.content.zh?.isNotEmpty == true) count++;
    if (widget.content.en?.isNotEmpty == true) count++;
    if (widget.content.original?.isNotEmpty == true) count++;
    return count >= 2;
  }

  /// 打开图片预览对话框
  void _openImagePreview(List<IntelMedia> images, int initialIndex) {
    int currentIndex = initialIndex;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog.fullscreen(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                itemCount: images.length,
                builder: (context, index) {
                  final imageUrl = ImageUtils.getImageProxyUrl(
                    images[index].url,
                  );
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
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
    final maxSheetHeight = MediaQuery.of(context).size.height * 0.7;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxSheetHeight),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 22.0.w,
            right: 22.0.w,
            top: 18.w,
            bottom: 12.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: FeatureImage(
                      url: TwitterImageUtils.getTwitterImageWithSize(
                        widget.avatar,
                        size: 'original',
                      ),
                      width: 40.w,
                      height: 40.w,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                widget.slug,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.textPrimary(context),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            if (widget.platformLogo != null)
                              ClipOval(
                                child: FeatureImage(
                                  url: ImageUtils.getImageProxyUrl(
                                    widget.platformLogo,
                                  ),
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textTertiary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              Text(
                _getContentByLanguage(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary(context),
                ),
              ),

              if (widget.medias != null && widget.medias!.isNotEmpty)
                IntelResourcesGrid(
                  medias: widget.medias,
                  onTap: (mediaList, index) =>
                      _openImagePreview(mediaList, index),
                ),

              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ExternalLink(url: widget.sourceUrl),
                  if (_shouldShowLanguageSwitcher()) ...[
                    _buildLanguageSwitcher(context),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSwitcher(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLanguageButton(
          context,
          label: '中文',
          language: ContentLanguage.zh,
          enabled: widget.content.zh?.isNotEmpty == true,
        ),
        SizedBox(width: 8.w),
        _buildLanguageButton(
          context,
          label: 'EN',
          language: ContentLanguage.en,
          enabled: widget.content.en?.isNotEmpty == true,
        ),
        SizedBox(width: 8.w),
        _buildLanguageButton(
          context,
          label: '原文',
          language: ContentLanguage.original,
          enabled: widget.content.original?.isNotEmpty == true,
        ),
      ],
    );
  }

  Widget _buildLanguageButton(
    BuildContext context, {
    required String label,
    required ContentLanguage language,
    required bool enabled,
  }) {
    final isSelected = _selectedLanguage == language;

    return GestureDetector(
      onTap: enabled
          ? () {
              setState(() {
                _selectedLanguage = language;
              });
            }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: enabled
                ? (isSelected
                      ? AppColors.primary
                      : AppColors.textTertiary(context))
                : AppColors.textTertiary(context).withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: enabled
                ? (isSelected ? Colors.white : AppColors.textPrimary(context))
                : AppColors.textTertiary(context).withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}

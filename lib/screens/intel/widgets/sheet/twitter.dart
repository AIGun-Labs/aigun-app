import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/twitter_image_utils.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../shared/data/models/multilingual_model.dart';
import '../../../../shared/mixins/image_preview.dart';
import '../../../../shared/presentation/widgets/external_link.dart';
import '../../../../shared/presentation/widgets/grid_image_preview.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/image_utils.dart';
import '../../../../widgets/feature_image.dart';

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
    this.repostContent,
    required this.uniquePrefix,
  });

  final String sourceUrl;
  final String avatar;
  final String slug;
  final String? platformLogo;
  final String time;
  final MultilingualModel content;
  final List<IntelMedia>? medias;
  final String? repostContent;
  final String uniquePrefix;
  @override
  State<TwitterSheet> createState() => _TwitterSheetState();
}

class _TwitterSheetState extends State<TwitterSheet> with ImagePreviewMixin {
  final ContentLanguage _selectedLanguage = ContentLanguage.original;

  @override
  void initState() {
    super.initState();
  }

  /// 根据选中的语言获取内容
  /// 如果有转发内容(repostContent)，原文显示转发内容
  String _getContentByLanguage() {
    switch (_selectedLanguage) {
      case ContentLanguage.zh:
        return widget.content.zh ?? widget.content.original ?? '';
      case ContentLanguage.en:
        return widget.content.en ?? widget.content.original ?? '';
      case ContentLanguage.original:
        return widget.repostContent ?? widget.content.original ?? '';
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

  @override
  Widget build(BuildContext context) {
    final maxSheetHeight = MediaQuery.of(context).size.height * 0.7;
    final urls = widget.medias?.map((media) => media.url ?? '').toList() ?? [];

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
                // _getContentByLanguage(),
                // widget.content.getByLocale(context),
                _getContentByLanguage(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary(context),
                ),
              ),

              // if (widget.medias != null && widget.medias!.isNotEmpty)
              if (urls.isNotEmpty)
                GridImagePreviewWrapper(
                  urls: urls,
                  onTap: (index) =>
                      openImagePreview(urls, index, widget.uniquePrefix),
                  uniquePrefix: widget.uniquePrefix,
                ),

              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ExternalLink(url: widget.sourceUrl)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

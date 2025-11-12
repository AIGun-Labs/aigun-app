import "package:flutter/material.dart";
import "package:flutter_aigun/data/models/index.dart";
import "package:flutter_aigun/data/models/intel/intel.dart";
import "package:flutter_aigun/enums/intel_type.dart";
import "package:flutter_aigun/presentation/extensions/datetime_extension.dart";
import "package:flutter_aigun/screens/intel/widgets/sheet/news.dart";
import "package:flutter_aigun/themes/themes.dart";
import "package:flutter_aigun/utils/extensions/string.dart";
import "package:flutter_aigun/utils/format/date.dart";
import "package:flutter_aigun/utils/image_utils.dart";
import "package:flutter_aigun/utils/language_utils.dart";
import "package:flutter_aigun/utils/sheet/sheet.dart";
import "package:flutter_aigun/widgets/feature_image.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_aigun/widgets/sheet/common.dart';

class IntelAuthorInfo extends StatelessWidget {
  const IntelAuthorInfo({super.key, required this.intel});

  final Intel intel;

  @override
  Widget build(BuildContext context) {
    final author = intel.author;

    // final publishedAt = DateUtilsHelper.formatUtcToLocal(
    //     intel.publishedAt ?? DateTime.now(), "HH:mm");

    return GestureDetector(
      onTap: () {
        if (intel.type != IntelType.twitter.type) {
          ShowSheet.common(
              context,
              NewsSheet(
                  sourceUrl: intel.sourceUrl ?? "",
                  title: intel.title ?? Multilingual.empty(),
                  time: DateUtilsHelper.formatUtcToLocal(
                      intel.publishedAtLocal.toDateTime(),
                      format: "HH:mm yyyy-MM-dd"),
                  avatar: intel.author?.avatar ?? "",
                  headline: intel.title ?? Multilingual.empty(),
                  summary: intel.content ?? Multilingual.empty()));
        }
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
              child: FeatureImage(
                  url: ImageUtils.getImageProxyUrl(author?.avatar),
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
                        child: FeatureImage(
                            url: ImageUtils.getImageProxyUrl(
                                author?.platform?.logo),
                            width: 16.w,
                            height: 16.h),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        intel.publishedAtLocal,
                        style:
                            TextStyle(color: AppColors.textSecondary(context)),
                      ),
                      // 确保时间文本不会被截断
                      const SizedBox(width: 8),
                    ],
                  ),
                  Text(
                    LanguageUtils.getContentByLanguage(context, author?.prompt),
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

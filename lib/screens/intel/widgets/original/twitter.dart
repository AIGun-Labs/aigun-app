import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/twitter_image_utils.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../shared/data/models/multilingual_model.dart';
import '../../../../shared/extensions/multilingual_model_extension.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/image_utils.dart';
import '../../../../widgets/feature_image.dart';

class OriginalTwitter extends StatelessWidget {
  const OriginalTwitter({
    super.key,
    required this.intel,
    this.onTap,
    this.headline,
    this.time,
    this.avatar,
    this.summary,
    this.platformLogo,
  });

  final Intel intel;

  final Function()? onTap;

  final MultilingualModel? headline;
  final String? time;
  final String? avatar;
  final MultilingualModel? summary;
  final String? platformLogo;

  @override
  Widget build(BuildContext context) {
    final author = intel.author;
    final summaryText = summary.getByLocale(context);
    final headlineText = headline.getByLocale(context);

    return GestureDetector(
      onTap: onTap,
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
                url: TwitterImageUtils.getTwitterImageWithSize(
                  avatar,
                  size: 'original',
                ),
                width: 50.w,
                height: 50.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "@${author?.slug ?? ""}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ), // author name
                      SizedBox(width: 4.w),
                      ClipOval(
                        child: FeatureImage(
                          url: ImageUtils.getImageProxyUrl(
                            author?.platform?.logo,
                          ),
                          width: 16.w,
                          height: 16.w,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        intel.publishedAtLocal(context),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                  if (summaryText.isNotEmpty)
                    Text(
                      summaryText,
                      softWrap: true,
                      maxLines: 2, // 2
                      overflow: TextOverflow.ellipsis, // 2(...)
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary(context),
                        height: 1.3,
                      ),
                    ), // intel content
                ],
              ),
            ),
            SizedBox(
              width: 24.w, //
              child: Icon(Icons.arrow_forward_ios, size: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}

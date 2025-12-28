import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/intel/intel.dart';
import '../../../../shared/data/models/multilingual_model.dart';
import '../../../../shared/extensions/multilingual_model_extension.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/image_utils.dart';
import '../../../../widgets/feature_image.dart';

class OriginalNews extends StatelessWidget {
  const OriginalNews({
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
    final summaryText = summary.getByLocale(context);

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
            FeatureImage(
              url: ImageUtils.getImageProxyUrl(avatar),
              width: 48.w,
              height: 48.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  if (time != null)
                    Text(
                      time ?? '',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

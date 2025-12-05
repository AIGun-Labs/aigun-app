import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../../../data/models/intel/intel.dart";
import "../../../../data/models/language/language.dart";
import "../../../../themes/themes.dart";
import "../../../../utils/image_utils.dart";
import "../../../../utils/language_utils.dart";
import "../../../../widgets/feature_image.dart";

class OriginalNews extends StatelessWidget {
  const OriginalNews(
      {super.key,
      required this.intel,
      this.onTap,
      this.headline,
      this.time,
      this.avatar,
      this.summary,
      this.platformLogo});

  final Intel intel;

  final Function()? onTap;

  final Multilingual? headline;
  final String? time;
  final String? avatar;
  final Multilingual? summary;
  final String? platformLogo;

  @override
  Widget build(BuildContext context) {
    final summaryText = LanguageUtils.getContentByLanguage(context, summary);

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
                height: 48.w),
            SizedBox(width: 12.w),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (summaryText.isNotEmpty)
                    Text(
                      summaryText,
                      softWrap: true,
                      maxLines: 2, 
                      overflow: TextOverflow.ellipsis, 
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary(context),
                        height: 1.3,
                      ),
                    ), // intel content
                  if (time != null)
                    Text(
                      time ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary(context),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

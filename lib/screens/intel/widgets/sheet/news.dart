import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/index.dart';
import '../../../../shared/presentation/widgets/external_link.dart';
import '../../../../themes/themes.dart';
import '../../../../utils/image_utils.dart';
import '../../../../widgets/feature_image.dart';

class NewsSheet extends StatelessWidget {
  const NewsSheet({
    super.key,
    required this.sourceUrl,
    required this.title,
    required this.time,
    required this.avatar,
    required this.headline,
    required this.summary,
  });

  final String avatar;
  final String sourceUrl;
  final Multilingual title;
  final String time;
  final Multilingual headline;
  final Multilingual summary;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.r, vertical: 12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, 
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: FeatureImage(
                url: ImageUtils.getImageProxyUrl(avatar),
                width: 35.w,
                height: 35.w,
              ),
              title: Text(
                title.getByLocale(context),
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textPrimary(context)),
              ),
              subtitle: Text(
                time,
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textTertiary(context)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (headline.getByLocale(context).isNotEmpty)
                  Text(
                    headline.getByLocale(context),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                if (headline.getByLocale(context).isNotEmpty) 8.verticalSpace,
                Text(
                  summary.getByLocale(context),
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: headline.isEmpty
                          ? AppColors.textPrimary(context)
                          : AppColors.textSecondary(context)),
                ),
              ],
            ),
            
            16.verticalSpace,
            ExternalLink(
              url: sourceUrl,
            )
          ],
        ),
      ),
    );
  }
}

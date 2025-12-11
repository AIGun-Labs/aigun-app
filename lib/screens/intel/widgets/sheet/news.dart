import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/index.dart';
import '../../../../l10n/l10n.dart';
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
                  FeatureImage(
                    url: ImageUtils.getImageProxyUrl(avatar),
                    width: 40.w,
                    height: 40.w,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getTitle(context),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                        Text(
                          time,
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
                        : AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 16.h), // 底部间距
            16.verticalSpace,
            ExternalLink(url: sourceUrl),
          ],
          ),
        ),
      ),
    );
  }

  String _getTitle(BuildContext context) {
    if (title.isEmpty) {
      return S.of(context).globalIntelRadar;
    }
    return title.getByLocale(context);
  }
}

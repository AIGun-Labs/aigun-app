import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/url.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExternalLink extends StatelessWidget {
  const ExternalLink({super.key, required this.url, this.label});

  final String url;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(50.w, 30.h),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      onPressed: () async {
        await launchUrl(url);
      },
      label: label ??
          Text(
            S.of(context).sourceLink,
            style: TextStyle(color: AppColors.quaternary, fontSize: 14.sp),
          ),
      icon: Transform.rotate(
        angle: -45,
        child: Icon(
          Icons.link,
          size: 16.sp,
          color: AppColors.quaternary,
        ),
      ),
    );
  }
}

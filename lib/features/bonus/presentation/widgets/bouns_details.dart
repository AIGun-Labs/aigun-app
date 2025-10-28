import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

class BounsDetails extends StatelessWidget {
  const BounsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).bonusDetails,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textPrimary(context)),
                children: [
              TextSpan(text: 'happyrocket名字特别长的情况下进行了一笔交易, 我获得了\$10.12455 '),
              TextSpan(
                  text: '10.21 12:12',
                  style: TextStyle(color: AppColors.textTertiary(context))),
            ])),
        RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textPrimary(context)),
                children: [
              TextSpan(text: 'happyrocket领取了GOLD,  我获得了20.2  GOLD '),
              TextSpan(
                  text: '10.21 12:12',
                  style: TextStyle(color: AppColors.textTertiary(context))),
            ]))
      ],
    );
  }
}

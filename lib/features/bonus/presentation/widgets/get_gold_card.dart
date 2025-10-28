import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../utils/show_about_gold_sheet.dart';
import 'card_widget.dart';

class GetGoldCard extends StatelessWidget {
  const GetGoldCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      paddingValue: 14,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                S.of(context).unclaimedGold,
                style: TextStyle(fontSize: 12.sp),
              ),
              2.horizontalSpace,
              InkWell(
                onTap: () => showAboutGoldSheet(context),
                child: Icon(Icons.info_outline,
                    size: 14.w, color: AppColors.textSecondary(context)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/images/gold.png',
                width: 20.w,
              ),
              Expanded(
                  child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  NumberFormat('#,###').format(132221),
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              )),
              Container(
                height: 30.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppColors.quaternary,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  S.of(context).claim,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.background(context),
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

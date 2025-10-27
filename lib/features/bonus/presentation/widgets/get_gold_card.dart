import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import 'card_widget.dart';

class GetGoldCard extends StatelessWidget {
  const GetGoldCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      paddingValue: 14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                S.of(context).unclaimedGold,
                style: TextStyle(fontSize: 12.sp),
              ),
              2.horizontalSpace,
              Icon(Icons.info_outline,
                  size: 14.w, color: AppColors.textSecondary(context))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/gold.png',
                width: 20.w,
              ),
              Expanded(
                  child: Text(
                NumberFormat('#,###').format(13231),
                style: TextStyle(
                    fontSize: 18.sp,
                    height: 1.2.h,
                    fontWeight: FontWeight.w700),
              )),
              SizedBox(
                height: 30.h,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.quaternary,
                    foregroundColor: AppColors.background(context),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      height: 1.2.h,
                    ),
                  ),
                  child: Text(S.of(context).claim),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

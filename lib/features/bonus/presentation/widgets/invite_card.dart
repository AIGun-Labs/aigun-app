import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import 'card_widget.dart';

class InviteCard extends StatelessWidget {
  const InviteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: [
                  Text(
                    S.of(context).myInviteCode,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.2.h,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                  Text(
                    '12345',
                    style: TextStyle(
                      fontSize: 20.sp,
                      height: 1.2.h,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.foreground(context),
                    foregroundColor: AppColors.background(context),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
                    textStyle:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                  ),
                  child: Text(
                    S.of(context).copy,
                  ))
            ],
          ),
          16.verticalSpace,
          Divider(
            height: 1.h,
            color: AppColors.border(context),
          ),
          20.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                S.of(context).inviteLink,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.2.h,
                  color: AppColors.textSecondary(context),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                  child: Text(
                'https://www.gsfsfsfsffsfsfsfssoogle.com',
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.2.h,
                ),
                overflow: TextOverflow.ellipsis,
              )),
              6.horizontalSpace,
              Icon(
                Icons.copy,
                size: 14.sp,
                color: AppColors.textSecondary(context),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                S.of(context).inviteBonus,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.2.h,
                  color: AppColors.textSecondary(context),
                ),
              ),
              12.horizontalSpace,
              Text(
                '10%',
                style: TextStyle(
                  fontSize: 20.sp,
                  height: 1.2.h,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

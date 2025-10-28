import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import 'card_widget.dart';

class ClaimFundsCard extends StatelessWidget {
  const ClaimFundsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        paddingValue: 14,
        backgroundColor: AppColors.background(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/default-avatar.png',
                  width: 40.w,
                ),
                10.horizontalSpace,
                Column(
                  children: [
                    Text(
                      'Solana',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '\$433.22',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context)),
                    ),
                  ],
                )
              ],
            ),
            RichText(
                text: TextSpan(
                    spellOut: true,
                    style: TextStyle(
                      color: AppColors.textPrimary(context),
                    ),
                    children: [
                  TextSpan(
                      text: '3.123',
                      style: TextStyle(
                        fontSize: 20.sp,
                      )),
                  WidgetSpan(child: SizedBox(width: 4.w)),
                  TextSpan(
                      text: 'SOL',
                      style: TextStyle(
                        fontSize: 14.sp,
                      )),
                ])),
            Text(
              S.of(context).minimumClaim(0.05, 'SOL'),
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textTertiary(context),
              ),
            ),
            4.verticalSpace,
            SizedBox(
              width: double.infinity,
              height: 32.h,
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.foreground(context)),
                    foregroundColor:
                        WidgetStateProperty.all(AppColors.background(context)),
                    textStyle: WidgetStateProperty.all(TextStyle(
                      fontSize: 14.sp,
                      height: 1.2,
                    )),
                  ),
                  onPressed: () {},
                  child: Text(S.of(context).claim)),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeSlippage extends StatelessWidget {
  const TradeSlippage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        border: Border(
          top: BorderSide(
            color: AppColors.background(context),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).market_slippage(20),
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textTertiary(context),
            ),
          ),
          Icon(
            Icons.settings,
            size: 20.sp,
            color: AppColors.textTertiary(context),
          ),
        ],
      ),
    );
  }
}

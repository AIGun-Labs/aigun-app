import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isBuy;
  final String tokenSymbol;
  final String reserveSymbol;

  const TradeInput({
    super.key,
    required this.controller,
    required this.isBuy,
    required this.tokenSymbol,
    required this.reserveSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.pageBg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: S.of(context).form_inputAmount,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.grey3,
                ),
              ),
            ),
          ),
          Text(
            isBuy ? reserveSymbol : tokenSymbol,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

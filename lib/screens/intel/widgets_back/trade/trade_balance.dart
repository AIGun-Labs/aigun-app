import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeBalance extends StatelessWidget {
  final bool isBuy;
  final String balance;
  final String reserveBalance;
  final String tokenSymbol;
  final String reserveSymbol;

  const TradeBalance({
    super.key,
    required this.isBuy,
    required this.balance,
    required this.reserveBalance,
    required this.tokenSymbol,
    required this.reserveSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).form_balance,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textQuinary(context),
            ),
          ),
          Text(
            isBuy ? '$reserveBalance $reserveSymbol' : '$balance $tokenSymbol',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textPrimary(context),
            ),
          ),
        ],
      ),
    );
  }
}

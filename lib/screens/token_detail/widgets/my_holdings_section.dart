import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHoldingsSection extends StatelessWidget {
  const MyHoldingsSection({
    super.key,
    this.value = 0.0,
    this.profit = 0.0,
    this.holdings = 0,
    this.profitPercent = 0.0,
  });

  final double value;
  final double profit;
  final int holdings;
  final double profitPercent;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isPositive = profit >= 0;
    final profitColor =
        isPositive ? const Color(0xFF52C41A) : const Color(0xFFFE6256);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.myHoldings,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatItem(
                    context,
                    s.value,
                    '\$${value.toStringAsFixed(2)}',
                    true,
                  ),
                  SizedBox(height: 15.h),
                  _buildStatItem(
                    context,
                    s.totalProfit,
                    '${isPositive ? '+' : ''}\$${profit.abs().toStringAsFixed(2)}',
                    true,
                    valueColor: profitColor,
                  ),
                ],
              )),
              SizedBox(height: 20.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatItem(
                      context,
                      s.holdings,
                      // _formatNumber(holdings),
                      "1,234,123",
                      true,
                    ),
                    SizedBox(height: 15.w),
                    _buildStatItem(
                      context,
                      s.totalChange,
                      '${isPositive ? '+' : ''}${profitPercent.toStringAsFixed(0)}%',
                      true,
                      valueColor: profitColor,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(
                context,
                s.shareProfit,
                const Color(0xFF000000),
                Colors.white,
                'assets/images/icons/share-outline.svg',
                () {},
              ),
              _buildActionButton(
                context,
                s.crossChainTrade,
                const Color(0xFF1099FB),
                Colors.white,
                'assets/images/icons/wallet-trade-action.svg',
                () {},
              ),
              _buildIconButton(
                context,
                'assets/images/icons/arrow-down-circle.svg',
                () {},
              ),
              _buildIconButton(
                context,
                'assets/images/icons/arrow-up-circle.svg',
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    bool isLarge, {
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textTertiary(context),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: isLarge ? 20.sp : 16.sp,
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textPrimary(context),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    Color bgColor,
    Color textColor,
    String iconPath,
    VoidCallback onPressed,
  ) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(5.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5.r),
        child: Container(
          height: 45.h,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 17.w,
                height: 17.h,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              ),
              SizedBox(width: 5.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context,
    String iconPath,
    VoidCallback onPressed,
  ) {
    return Material(
      color: const Color(0xFFE2FDFE),
      borderRadius: BorderRadius.circular(5.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5.r),
        child: Container(
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(
              Color(0xFF000000),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return '$number';
  }
}

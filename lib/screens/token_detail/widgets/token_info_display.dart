import 'package:flutter/material.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TokenInfoDisplay extends StatelessWidget {
  const TokenInfoDisplay({
    super.key,
    this.price = 0.0,
    this.priceChangePercent = 0.0,
    this.marketCap = 0,
    this.liquidity = 0,
    this.volume24h = 0,
    this.holders = 0,
    this.multiplier = 0,
    this.lastUpdateTime = '',
  });

  final double price;
  final double priceChangePercent;
  final double marketCap;
  final double liquidity;
  final double volume24h;
  final int holders;
  final int multiplier;
  final String lastUpdateTime;

  @override
  Widget build(BuildContext context) {
    final isPositive = priceChangePercent >= 0;
    final changeColor =
        isPositive ? const Color(0xFF52C41A) : const Color(0xFFFE6256);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(6)}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                      Text(
                        '${isPositive ? '+' : ''}${priceChangePercent.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: changeColor,
                        ),
                      ),
                      Row(children: [
                        SvgPicture.asset("assets/tabbar/intel.svg",
                            width: 16.w,
                            height: 16.h,
                            colorFilter: ColorFilter.mode(
                                AppColors.textPrimary(context),
                                BlendMode.srcIn)),
                        SizedBox(width: 4.w),
                        Text(
                          "9.6 12:12",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textTertiary(context),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
                SizedBox(width: 40.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoItem(
                          context, "流通市值", _formatCurrency(marketCap)),
                      _buildInfoItem(
                          context, "流动性", _formatCurrency(liquidity)),
                      _buildInfoItem(
                          context, "24h成交额", _formatCurrency(volume24h)),
                      _buildInfoItem(context, "持币地址", '$holders'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textTertiary(context),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textPrimary(context),
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double value) {
    if (value >= 1000000) {
      return '\$${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '\$${(value / 1000).toStringAsFixed(1)}k';
    }
    return '\$$value';
  }
}

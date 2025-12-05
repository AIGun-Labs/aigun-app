import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/nav.dart';
import '../../../core/router/constants.dart';
import '../../../cubits/index.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/colors.dart';
import '../../../utils/colors.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/format/currency.dart';
import '../../../utils/format/numeric.dart';
import '../../../widgets/skeleton/widgets/text.dart';

class MyHoldingsSection extends StatelessWidget {
  const MyHoldingsSection({
    super.key,
    this.value = 0.0,
    this.profit = 0.0,
    this.holdings = 0.0,
    this.profitPercent = 0.0,
    this.isLoading = false,
  });

  final double value;
  final double profit;
  final double holdings;
  final double profitPercent;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    final newValue = CurrencyFormatter.abbreviateTokenPriceWithSymbol(value);
    final totalProfit = CurrencyFormatter.abbreviateTokenPriceWithSymbol(
      profit,
    ).addNegativeSign(profit);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 19.h),
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
                      newValue,
                      true,
                      isLoading: isLoading,
                      valueColor: AppColors.textPrimary(context),
                    ),
                    SizedBox(height: 15.h),
                    _buildStatItem(
                      context,
                      s.totalProfit,
                      totalProfit,
                      true,
                      valueColor: ColorsHelper.getColorByValueWithZeroColor(
                        profit,
                        zeroColor: AppColors.textTertiary(context),
                      ),
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatItem(
                      context,
                      s.holdings,
                      // _formatNumber(holdings),
                      CurrencyFormatter.abbreviateTokenPrice(holdings),
                      true,
                      isLoading: isLoading,
                      valueColor: AppColors.textPrimary(context),
                    ),
                    SizedBox(height: 15.w),
                    _buildStatItem(
                      context,
                      s.totalChange,
                      // NumericFormatter.formatWithSign(profitPercent,
                      //     suffix: "%"),
                      NumericFormatter.formatWithSign(
                        double.tryParse(
                              profitPercent.toDouble().toStringAsFixed(2),
                            ) ??
                            0.0,
                        suffix: "%",
                      ),
                      true,
                      valueColor: ColorsHelper.getColorByValueWithZeroColor(
                        profitPercent,
                        zeroColor: AppColors.textTertiary(context),
                      ),
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          BlocBuilder<TokenDetailCubit, TokenDetailState>(
            builder: (context, state) {
              return Row(
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
                    () {
                      context.goNamed(RouteNames.trade, extra: NavIndex.trade);
                    },
                  ),
                  _buildIconButton(
                    context,
                    'assets/images/icons/arrow-down-circle.svg',
                    () {
                      context.pushNamed(
                        RouteNames.receiveAddress,
                        extra: {
                          "avatar": state.token?.tokenAvatar,
                          "subAvatar": state.token?.chainLogo,
                          "title":
                              "${state.token?.tokenName} ${S.of(context).receive}",
                          "symbol": state.token?.chainName,
                          "address": state.token?.address,
                        },
                      );
                    },
                  ),
                  _buildIconButton(
                    context,
                    'assets/images/icons/arrow-up-circle.svg',
                    () {
                      context.pushNamed(RouteNames.sendTokenDetail);
                    },
                  ),
                ],
              );
            },
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
    bool isLoading = false,
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
        // SizedBox(height: 2.h),
        if (isLoading)
          TextSkeleton(width: 100.w, height: 24.h)
        else
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isLarge ? 20.sp : 16.sp,
                fontWeight: FontWeight.w700,
                color: valueColor ?? AppColors.textPrimary(context),
              ),
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
    return SizedBox(
      height: 45.h,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        icon: SvgPicture.asset(
          iconPath,
          width: 17.w,
          height: 17.h,
          colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
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
}

class MyHoldingsSectionSkeleton extends StatelessWidget {
  const MyHoldingsSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              TextSkeleton(width: 60.w, height: 14.h),
              SizedBox(height: 4.h),
              
              TextSkeleton(width: 100.w, height: 24.h),
              SizedBox(height: 15.h),
              
              TextSkeleton(width: 80.w, height: 14.h),
              SizedBox(height: 4.h),
              
              TextSkeleton(width: 120.w, height: 24.h),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              TextSkeleton(width: 70.w, height: 14.h),
              SizedBox(height: 4.h),
              
              TextSkeleton(width: 110.w, height: 24.h),
              SizedBox(height: 15.h),
              
              TextSkeleton(width: 90.w, height: 14.h),
              SizedBox(height: 4.h),
              
              TextSkeleton(width: 80.w, height: 24.h),
            ],
          ),
        ),
      ],
    );
  }
}

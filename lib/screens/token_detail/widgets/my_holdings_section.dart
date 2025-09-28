import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_aigun/widgets/skeleton/widgets/text.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyHoldingsSection extends StatelessWidget {
  const MyHoldingsSection({
    super.key,
    this.value = 0.0,
    this.profit = 0.0,
    this.holdings = 0,
    this.profitPercent = 0.0,
    this.isLoading = false,
  });

  final double value;
  final double profit;
  final int holdings;
  final double profitPercent;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isPositive = profit >= 0;
    final profitColor =
        isPositive ? const Color(0xFF52C41A) : const Color(0xFFFE6256);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
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
          // 如果正在加载中就显示骨架屏
          if (isLoading)
            const MyHoldingsSectionSkeleton()
          else
            //否则显示实际内容
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
                    if (state.token != null) {
                      context
                          .read<TradeCubit>()
                          .updateFromToken(TradeToken.fromToken(state.token!));
                      context.push(Routes.home, extra: NavIndex.trade);
                    }
                  },
                ),
                _buildIconButton(
                  context,
                  'assets/images/icons/arrow-down-circle.svg',
                  () {
                    context.push(Routes.receiveAddress, extra: {
                      "avatar": state.token?.tokenAvatar,
                      "subAvatar": state.token?.chainLogo,
                      "title":
                          "${state.token?.tokenName} ${S.of(context).receive}",
                      "symbol": state.token?.chainName,
                      "address": state.token?.address,
                    });
                  },
                ),
                _buildIconButton(
                  context,
                  'assets/images/icons/arrow-up-circle.svg',
                  () {
                    if (state.token != null) {
                      context.read<TransferCubit>().updateToken(state.token!);
                      context.push(Routes.sendTokenDetail);
                    }
                  },
                ),
              ],
            );
          }),
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
        // SizedBox(height: 2.h),
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
    return SizedBox(
      height: 45.h,
      child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: textColor,
            textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          label: Text(label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              )),
          icon: SvgPicture.asset(iconPath,
              width: 17.w,
              height: 17.h,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn))),
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
              // 标签骨架屏
              TextSkeleton(
                width: 60.w,
                height: 14.h,
              ),
              SizedBox(height: 4.h),
              // 数值骨架屏
              TextSkeleton(
                width: 100.w,
                height: 24.h,
              ),
              SizedBox(height: 15.h),
              // 标签骨架屏
              TextSkeleton(
                width: 80.w,
                height: 14.h,
              ),
              SizedBox(height: 4.h),
              // 数值骨架屏
              TextSkeleton(
                width: 120.w,
                height: 24.h,
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标签骨架屏
              TextSkeleton(
                width: 70.w,
                height: 14.h,
              ),
              SizedBox(height: 4.h),
              // 数值骨架屏
              TextSkeleton(
                width: 110.w,
                height: 24.h,
              ),
              SizedBox(height: 15.h),
              // 标签骨架屏
              TextSkeleton(
                width: 90.w,
                height: 14.h,
              ),
              SizedBox(height: 4.h),
              // 数值骨架屏
              TextSkeleton(
                width: 80.w,
                height: 24.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

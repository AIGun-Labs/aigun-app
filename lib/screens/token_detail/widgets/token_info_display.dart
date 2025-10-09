import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/colors.dart';
import 'package:flutter_aigun/utils/extensions/number.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/date.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/format/numeric.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_aigun/widgets/skeleton/widgets/text.dart';

class TokenInfoDisplay extends StatelessWidget {
  const TokenInfoDisplay({
    super.key,
    this.priceUsd = 0.0,
    this.marketCap = 0,
    this.liquidity = 0,
    this.volume24h = 0,
    this.holders = 0,
    this.highestPriceUsd = 0,
    this.priceChange24h = 0,
    this.lastestTime,
  });

  final double priceUsd;
  final double marketCap;
  final double liquidity;
  final double volume24h;
  final double holders;
  final double highestPriceUsd;
  final double priceChange24h;
  final DateTime? lastestTime;
  @override
  Widget build(BuildContext context) {
    // 判断是否大于零
    final changeColor =
        priceChange24h.isPositive() ? AppColors.septenary : AppColors.secondary;

    final lastestTimeFormatted = DateUtilsHelper.formatUtcToLocal(
        lastestTime ?? DateTime.now(), "M.d HH:mm");

    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
      final isLoading = state.tokenDetailInfoState.maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
      // 是否正在加载中
      if (isLoading) {
        return const TokenInfoDisplaySkeleton();
      }
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 85.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                              priceUsd),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                        Text(
                          "${NumericFormatter.formatWithSign(priceChange24h)}%",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorsHelper.getColorByValueWithZeroColor(
                                priceChange24h,
                                zeroColor: Colors.grey),
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
                          Text.rich(
                              textAlign: TextAlign.end,
                              TextSpan(children: [
                                TextSpan(
                                    text: lastestTimeFormatted,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.textPrimary(context))),
                                // SizedBox(width: 4.w),
                                WidgetSpan(child: SizedBox(width: 12.w)),
                                TextSpan(
                                    text: "$highestPriceUsd",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.septenary)),
                                TextSpan(
                                    text: "x",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.septenary)),
                              ])),
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
                        _buildInfoItem(context, S.of(context).marketCap,
                            formatPriceEnglish(marketCap)),
                        _buildInfoItem(context, S.of(context).liquidity,
                            formatPriceEnglish(liquidity)),
                        _buildInfoItem(context, S.of(context).volume24h,
                            formatPriceEnglish(volume24h)),
                        _buildInfoItem(
                            context, S.of(context).holders, '$holders'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
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
}

class TokenInfoDisplaySkeleton extends StatelessWidget {
  const TokenInfoDisplaySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 85.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 价格占位符
                      TextSkeleton(
                        width: 120.w,
                        height: 24.h,
                        borderRadius: 12,
                      ),
                      // 价格变化百分比占位符
                      TextSkeleton(
                        width: 80.w,
                        height: 24.h,
                        borderRadius: 12,
                      ),
                      // 图标和数字占位符
                      Row(
                        children: [
                          Container(
                            width: 16.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: AppColors.shimmerBaseColor(context),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          TextSkeleton(
                            width: 30.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          SizedBox(width: 4.w),
                          TextSkeleton(
                            width: 35.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          SizedBox(width: 12.w),
                          TextSkeleton(
                            width: 35.w,
                            height: 16.h,
                            borderRadius: 8,
                          ),
                          TextSkeleton(
                            width: 15.w,
                            height: 12.h,
                            borderRadius: 6,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 市值占位符
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSkeleton(
                            width: 60.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          TextSkeleton(
                            width: 50.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                        ],
                      ),
                      // 流动性占位符
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSkeleton(
                            width: 60.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          TextSkeleton(
                            width: 50.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                        ],
                      ),
                      // 24小时交易量占位符
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSkeleton(
                            width: 60.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          TextSkeleton(
                            width: 50.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                        ],
                      ),
                      // 持有人数量占位符
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextSkeleton(
                            width: 60.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                          TextSkeleton(
                            width: 50.w,
                            height: 14.h,
                            borderRadius: 7,
                          ),
                        ],
                      ),
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
}

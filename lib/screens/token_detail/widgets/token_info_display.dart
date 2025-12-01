import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/presentation/widgets/auto_scale.dart';
import '../../../themes/colors.dart';
import '../../../utils/colors.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/format/currency.dart';
import '../../../utils/format/number.dart';
import '../../../utils/format/numeric.dart';
import '../../../utils/format/profit.dart';
import '../../../widgets/skeleton/widgets/text.dart';

class TokenInfoDisplay extends StatefulWidget {
  const TokenInfoDisplay({super.key});

  @override
  State<TokenInfoDisplay> createState() => _TokenInfoDisplayState();
}

class _TokenInfoDisplayState extends State<TokenInfoDisplay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        final holdersText =
            state.tokenDetailInfo?.isMainStream == true &&
                state.tokenDetailInfo?.holders == 0
            ? '--'
            : state.tokenDetailInfo?.holders ?? 0;

        final latestTime = !state.tokenAssociatedIntelsIsEmpty
            ? state.tokenAssociatedIntels?.first.publishedAtLocal(context)
            : null;
        // 是否正在加载中
        if (state.tokenDetailInfo == null) {
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
                          AutoScale(
                            child: Text(
                              CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                                state.tokenDetailInfo?.priceUsd ?? 0.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary(context),
                              ),
                            ),
                          ),
                          AutoScale(
                            child: Text(
                              '${NumericFormatter.formatWithSign(state.tokenDetailInfo?.priceChange24h ?? 0.0).toDouble().toStringAsFixed(2)}%',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color:
                                    ColorsHelper.getColorByValueWithZeroColor(
                                      state.tokenDetailInfo?.priceChange24h ??
                                          0.0,
                                      zeroColor: AppColors.textSecondary(
                                        context,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (latestTime?.isNotEmpty == true) ...[
                                SvgPicture.asset(
                                  'assets/tabbar/intel.svg',
                                  width: 16.w,
                                  height: 16.h,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.textPrimary(context),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                              ],
                              AutoScale(
                                child: Text.rich(
                                  textAlign: TextAlign.end,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: latestTime ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.textPrimary(context),
                                        ),
                                      ),
                                      WidgetSpan(child: SizedBox(width: 12.w)),
                                      ...() {
                                        final parsed =
                                            double.tryParse(
                                              state
                                                      .tokenDetailInfo
                                                      ?.highestIncreaseRate ??
                                                  '0'
                                                      .replaceAll('%', '')
                                                      .trim(),
                                            ) ??
                                            0.0;
                                        final result = ProfitFormatter.format(
                                          parsed,
                                        );
                                        const color = AppColors.septenary;
                                        return [
                                          TextSpan(
                                            text: result,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                              color: color,
                                            ),
                                          ),
                                          // TextSpan(
                                          //     text: result.suffix,
                                          //     style: TextStyle(
                                          //         fontSize: 12.sp,
                                          //         fontWeight: FontWeight.w700,
                                          //         color: color)),
                                        ];
                                      }(),
                                    ],
                                  ),
                                ),
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
                          _buildInfoItem(
                            context,
                            S.of(context).marketCap,
                            formatPriceEnglish(
                              state.tokenDetailInfo?.marketCap ?? 0.0,
                            ),
                          ),
                          _buildInfoItem(
                            context,
                            S.of(context).liquidity,
                            formatPriceEnglish(
                              state.tokenDetailInfo?.liquidity ?? 0.0,
                            ),
                          ),
                          _buildInfoItem(
                            context,
                            S.of(context).volume24h,
                            formatPriceEnglish(
                              state.tokenDetailInfo?.volume24h ?? 0.0,
                            ),
                          ),
                          _buildInfoItem(
                            context,
                            S.of(context).holders,
                            holdersText.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
        SizedBox(width: 10.w),
        Expanded(
          child: AutoScale(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary(context),
              ),
            ),
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
                      TextSkeleton(width: 80.w, height: 24.h, borderRadius: 12),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class TokenInfoDisplay extends StatelessWidget {
  const TokenInfoDisplay({
    super.key,
    this.priceUsd = 0.0,
    this.marketCap = 0,
    this.liquidity = 0,
    this.volume24h = 0,
    this.holders = 0,
    this.highestPriceUsd = '0',
    this.priceChange24h = 0,
    this.latestTime,
    this.isMainStream = true,
  });

  final double priceUsd;
  final double marketCap;
  final double liquidity;
  final double volume24h;
  final int holders;
  final String highestPriceUsd;
  final double priceChange24h;
  final String? latestTime;
  final bool isMainStream;
  @override
  Widget build(BuildContext context) {
    final holdersText = isMainStream && holders == 0 ? '--' : holders;
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
      final isLoading = state.tokenDetailInfoState.maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
      
      if (isLoading && state.tokenDetailInfo == null) {
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
                            priceUsd,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary(context),
                          ),
                        )),
                        AutoScale(
                            child: Text(
                          '${NumericFormatter.formatWithSign(priceChange24h).toDouble().toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorsHelper.getColorByValueWithZeroColor(
                                priceChange24h,
                                zeroColor: AppColors.textSecondary(context)),
                          ),
                        )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (latestTime?.isNotEmpty == true) ...[
                                SvgPicture.asset('assets/tabbar/intel.svg',
                                    width: 16.w,
                                    height: 16.h,
                                    colorFilter: ColorFilter.mode(
                                        AppColors.textPrimary(context),
                                        BlendMode.srcIn)),
                                SizedBox(width: 4.w)
                              ],
                              AutoScale(
                                child: Text.rich(
                                    textAlign: TextAlign.end,
                                    TextSpan(children: [
                                      TextSpan(
                                          text: latestTime ?? '',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.textPrimary(
                                                  context))),
                                      WidgetSpan(child: SizedBox(width: 12.w)),
                                      ...() {
                                        final parsed = double.tryParse(
                                              highestPriceUsd
                                                  .replaceAll('%', '')
                                                  .trim(),
                                            ) ??
                                            0.0;
                                        final result =
                                            ProfitFormatter.format(parsed);
                                        const color = AppColors.septenary;
                                        return [
                                          TextSpan(
                                              text: result,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: color)),
                                          // TextSpan(
                                          //     text: result.suffix,
                                          //     style: TextStyle(
                                          //         fontSize: 12.sp,
                                          //         fontWeight: FontWeight.w700,
                                          //         color: color)),
                                        ];
                                      }(),
                                    ])),
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
                        _buildInfoItem(context, S.of(context).marketCap,
                            formatPriceEnglish(marketCap)),
                        _buildInfoItem(context, S.of(context).liquidity,
                            formatPriceEnglish(liquidity)),
                        _buildInfoItem(context, S.of(context).volume24h,
                            formatPriceEnglish(volume24h)),
                        _buildInfoItem(context, S.of(context).holders,
                            holdersText.toString()),
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
        )
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
                      
                      TextSkeleton(
                        width: 120.w,
                        height: 24.h,
                        borderRadius: 12,
                      ),
                      
                      TextSkeleton(
                        width: 80.w,
                        height: 24.h,
                        borderRadius: 12,
                      ),
                      
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

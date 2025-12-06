import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/extensions/datetime_extension.dart';
import '../../../../shared/presentation/widgets/auto_scale.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/format/currency.dart';
import '../../../../utils/format/numeric.dart';
import '../../domain/entities/token_info_entity.dart';
import '../cubits/intels/intels_cubit.dart';
import '../cubits/token_info/token_info_cubit.dart';
import 'token_info_skeleton.dart';

class TokenInfoWidget extends StatelessWidget {
  const TokenInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenInfoCubit, TokenInfoState>(
      builder: (context, state) {
        final token = state.tokenInfo;
        if (token == null) {
          return const SizedBox.shrink();
        }
        return switch (state.status) {
          TokenInfoStatus.initial => const TokenInfoSkeleton(),
          TokenInfoStatus.loading => const SizedBox.shrink(),
          TokenInfoStatus.error => const SizedBox.shrink(),
          TokenInfoStatus.success => Container(
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
                                  token.base.tokenPrice.toDouble(),
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
                                '${NumericFormatter.formatWithSign(token.base.priceChange24h.toDouble()).toDouble().toStringAsFixed(2)}%',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      ColorsHelper.getColorByValueWithZeroColor(
                                        token.base.priceChange24h.toDouble(),
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
                                SvgPicture.asset(
                                  'assets/tabbar/intel.svg',
                                  width: 16.w,
                                  height: 16.h,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.textPrimary(context),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                4.horizontalSpace,
                                BlocBuilder<IntelsCubit, IntelsState>(
                                  builder: (context, state) {
                                    return AutoScale(
                                      child: Text.rich(
                                        textAlign: TextAlign.end,
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              /// 最新的一条情报的时间
                                              text:
                                                  state.latestIntel?.publishedAt
                                                      .fmt(
                                                        context,
                                                        pattern: 'HH:mm MM-dd',
                                                      ) ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.textPrimary(
                                                  context,
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: 12.horizontalSpace,
                                            ),
                                            TextSpan(
                                              text: token.increaserate,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.septenary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      40.horizontalSpace,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoItem(
                              context,
                              S.of(context).marketCap,
                              token.base.formattedMarketCap,
                            ),
                            _buildInfoItem(
                              context,
                              S.of(context).liquidity,
                              token.base.formattedLiquidity,
                            ),
                            _buildInfoItem(
                              context,
                              S.of(context).volume24h,
                              token.base.formattedVolume24h,
                            ),
                            _buildInfoItem(
                              context,
                              S.of(context).holders,
                              token.hodlersValue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        };
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

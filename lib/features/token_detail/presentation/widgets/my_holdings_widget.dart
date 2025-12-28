import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/nav.dart';
import '../../../../core/router/constants.dart';
import '../../../../cubits/index.dart' hide SwapCubit;
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/domain/mappers/token_entity_mapper.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/extensions/string.dart';
import '../../../../utils/format/currency.dart';
import '../../../../utils/format/numeric.dart';
import '../../../../utils/logger.dart';
import '../../../../widgets/skeleton/widgets/text.dart';
import '../cubits/holdings/holdings_cubit.dart';
import '../cubits/token_info/token_info_cubit.dart';

class MyHoldingsWidget extends StatelessWidget {
  const MyHoldingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // final newValue = CurrencyFormatter.abbreviateTokenPriceWithSymbol(value);
    // final totalProfit = CurrencyFormatter.abbreviateTokenPriceWithSymbol(
    //   profit,
    // ).addNegativeSign(profit);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 19.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15.h,
        children: [
          Text(
            s.myHoldings,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary(context),
            ),
          ),
          BlocBuilder<HoldingsCubit, HoldingsState>(
            builder: (context, state) {
              final isLoading = state.status == HoldingsStatus.loading;
              final value = CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                state.tokenProfit?.value.toDouble() ?? 0,
              );
              final profitValue = state.tokenProfit?.profit.toDouble() ?? 0;
              final totalProfit =
                  CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                    profitValue,
                  ).addNegativeSign(profitValue);
              final holdingsValue = state.tokenProfit?.balance.toDouble() ?? 0;
              final holdings = CurrencyFormatter.abbreviateTokenPrice(
                holdingsValue,
              );

              final changePrecentValue =
                  state.tokenProfit?.riseFall.toDouble() ?? 0;

              final changePrecent = NumericFormatter.formatWithSign(
                double.tryParse(changePrecentValue.toStringAsFixed(2)) ?? 0.0,
                suffix: '%',
              );
              return Row(
                spacing: 20.w,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15.h,
                      children: [
                        _buildStatItem(
                          context,
                          s.value,
                          value,
                          true,
                          isLoading: isLoading,
                          valueColor: AppColors.textPrimary(context),
                        ),
                        _buildStatItem(
                          context,
                          s.totalProfit,
                          totalProfit,
                          true,
                          valueColor: ColorsHelper.getColorByValueWithZeroColor(
                            profitValue,
                            zeroColor: AppColors.textTertiary(context),
                          ),
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15.h,
                      children: [
                        _buildStatItem(
                          context,
                          s.holdings,
                          holdings,
                          true,
                          isLoading: isLoading,
                          valueColor: AppColors.textPrimary(context),
                        ),
                        _buildStatItem(
                          context,
                          s.totalChange,
                          changePrecent,
                          true,
                          valueColor: ColorsHelper.getColorByValueWithZeroColor(
                            changePrecentValue,
                            zeroColor: AppColors.textTertiary(context),
                          ),
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          BlocBuilder<TokenInfoCubit, TokenInfoState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                    context,
                    s.shareProfit,
                    const Color(0xFF000000),
                    Colors.white,
                    Assets.images.icons.shareOutline,
                    () {},
                  ),
                  _buildActionButton(
                    context,
                    s.crossChainTrade,
                    const Color(0xFF1099FB),
                    Colors.white,
                    Assets.images.icons.walletTradeAction,
                    () {
                      final token = state.tokenInfo?.base.toTradeToken();
                      if (token == null) return;
                      BlocProvider.of<TradeCubit>(
                        context,
                      ).updateFromToken(token);
                      context.goNamed(RouteNames.trade, extra: NavIndex.trade);
                    },
                  ),
                  _buildIconButton(
                    context,
                    Assets.images.icons.arrowDownCircle,
                    () {
                      final token = state.tokenInfo;
                      if (token == null) return;

                      Logger.info('chain avatar: ${token.base.chainLogo}');
                      Logger.info('token base: ${token.base}');

                      BlocProvider.of<WalletCubit>(context).toNativeReceivePage(
                        context,
                        network: token.base.network,
                        avatar: token.base.tokenLogo,
                        symbol: token.base.symbol,
                      );

                      // context.pushNamed(
                      //   RouteNames.receiveAddress,
                      //   extra: {
                      //     'avatar': token.base.tokenLogo,
                      //     'subAvatar': token.base.chainLogo,
                      //     'title':
                      //         '${token.base.tokenName} ${S.of(context).receive}',
                      //     'symbol': token.base.symbol,
                      //     'address': token.base.address,
                      //   },
                      // );
                    },
                  ),
                  _buildIconButton(
                    context,
                    Assets.images.icons.arrowUpCircle,
                    () {
                      final token = state.tokenInfo?.base.toToken();

                      if (token == null) return;
                      BlocProvider.of<TransferCubit>(
                        context,
                      ).updateToken(token);
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
      height: 45.w,
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
          height: 17.w,
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
          height: 45.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.w,
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

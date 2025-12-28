import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/constants.dart';
import '../../../core/router/routes/app_routes.dart';
import '../../../cubits/index.dart';
import '../../../cubits/trade/trade_state.dart';
import '../../../data/models/token/query_token/query_token.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/domain/mappers/query_token_mapper.dart';
import '../../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../../../themes/themes.dart';
import '../../../utils/clipboard.dart';
import '../../../utils/colors.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/format/currency.dart';
import '../../../utils/format/number.dart';
import '../../../utils/format/numeric.dart';
import '../../../utils/image_utils.dart';
import '../../../utils/sheet/sheet.dart';
import '../../../utils/toast.dart';
import '../../../utils/web3/address.dart';
import '../../../widgets/avatar/widget/token.dart';
import '../../../widgets/button/primary.dart';
import '../../../widgets/sheet/common.dart';
import '../../../widgets/swap/widgets/swap.dart';
import '../../../widgets/token/models/token.dart';

class QueryTokenCardItem extends StatelessWidget {
  const QueryTokenCardItem({super.key, required this.token});

  final QueryToken token;

  void _handleTokenTap(BuildContext context) {
    final isLoggedIn = BlocProvider.of<NewUserCubit>(
      context,
    ).state.isAuthenticated;

    if (!isLoggedIn) {
      context.pushNamed(RouteNames.login);
      return;
    }

    BlocProvider.of<QuickTradeCubit>(
      context,
    ).updateSelectedToken(Token.fromQueryToken(token));

    TokenDetailRoute(token.toTokenEntity()).push(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border(context)),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _handleTokenTap(context);
              },
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                height: 50.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AvatarToken(
                      width: 50.w,
                      height: 50.h,
                      chainLogoHeight: 20.h,
                      chainLogoWidth: 20.w,
                      avatar: ImageUtils.getImageProxyUrl(token.logo),
                      chainLogo: token.networkLogo,
                    ),
                    SizedBox(width: 13.w),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: token.isNative ?? false
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  '${token.symbol}(${token.name?.splitWithSymbol(9)})',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                token.isNative ?? false
                                    ? const SizedBox.shrink()
                                    : GestureDetector(
                                        onTap: () {
                                          ClipboardUtils.copy(
                                            token.address ?? '',
                                          ).then((_) {
                                            if (!context.mounted) return;
                                            ToastUtils.showCenterToast(
                                              context,
                                              S.of(context).copySuccess,
                                            );
                                          });
                                        },
                                        child: Text(
                                          Web3Address.desensitization(
                                            token.address?.splitStartAndEnd(
                                              4,
                                              4,
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.textPrimary(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          10.horizontalSpace,
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                                  double.tryParse(token.priceUsd ?? '0.0') ??
                                      0.0,
                                ),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                NumericFormatter.formatWithSign(
                                  double.tryParse(
                                        token.priceChange24h ?? '0.0',
                                      ) ??
                                      0.0,
                                ).withSymbol(symbol: '%', isPrefix: false),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color:
                                      ColorsHelper.getColorByValueWithZeroColor(
                                        token.priceChange24h ?? '0.0',
                                        zeroColor: AppColors.textSecondary(
                                          context,
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).marketCap,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      Text(
                        formatPriceEnglish(
                          double.tryParse(token.marketCap ?? '0.0') ?? 0.0,
                        ),
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        S.of(context).liquidity,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      Text(
                        formatPriceEnglish(
                          double.tryParse(token.liquidity ?? '0.0') ?? 0.0,
                        ),
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).volume24h,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                      Text(
                        formatPriceEnglish(
                          double.tryParse(token.volume24h ?? '0.0') ?? 0.0,
                        ),
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            QueryTokenCardButton(token: token),
          ],
        ),
      ),
    );
  }
}

class QueryTokenCardButton extends StatelessWidget {
  const QueryTokenCardButton({super.key, required this.token});
  final QueryToken token;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      // disabledBackgroundColor: AppColors.quaternary,
      onPressed: () {
        final isLoggedIn = BlocProvider.of<NewUserCubit>(
          context,
        ).state.isAuthenticated;

        if (!isLoggedIn) {
          context.pushNamed(RouteNames.login);
          return;
        }
        if (token.isNative ?? false) {
          if (token.symbol?.toLowerCase() == 'sol') {
            ShowSheet.common(
              context,
              CommonSheet(top: 16.w, child: const TradeSwap(buyToken: true)),
            );

            context.read<TradeCubit>().updateFromToken(defaultBNBTradeToken);

            context.read<TradeCubit>().updateToToken(defaultFormTradeToken);
          } else {
            ShowSheet.common(
              context,
              CommonSheet(top: 16.w, child: const TradeSwap(buyToken: true)),
            );

            context.read<TradeCubit>().updateFromToken(defaultFormTradeToken);

            context.read<TradeCubit>().updateToToken(
              TradeToken.fromQueryToken(token),
            );
          }
        } else {
          ShowSheet.trade(context);

          context.read<QuickTradeCubit>().updateSelectedToken(
            Token.fromQueryToken(token),
          );
        }
      },
      borderRadius: BorderRadius.zero,
      // isLoading: isLoading,
      width: double.infinity,
      height: 50.h,
      cutSize: 20.0,
      backgroundColor: AppColors.primary,
      textColor: Colors.black,
      fontSize: 16.sp,
      icon: SvgPicture.asset(
        width: 20.w,
        height: 20.h,
        'assets/images/icons/aim-outline.svg',
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
      label: Text(S.of(context).buyNow, style: TextStyle(fontSize: 18.sp)),
    );
  }
}

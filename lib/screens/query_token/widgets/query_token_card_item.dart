import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/data/models/token/query_token/query_token.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/colors.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/numeric.dart';
import 'package:flutter_aigun/utils/sheet/sheet.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/widgets/avatar/widget/token.dart';
import 'package:flutter_aigun/widgets/button/primary.dart';
import 'package:flutter_aigun/widgets/sheet/common.dart';
import 'package:flutter_aigun/widgets/swap/widgets/swap.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class QueryTokenCardItem extends StatelessWidget {
  const QueryTokenCardItem({super.key, required this.token});

  final QueryToken token;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.border(context)),
            borderRadius: BorderRadius.circular(5.r)),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarToken(
                    width: 50.w,
                    height: 50.h,
                    chainLogoHeight: 20.h,
                    chainLogoWidth: 20.w,
                    avatar: token.logo,
                    chainLogo: token.networkLogo,
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
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
                              "${token.symbol}(${token.name?.splitWithSymbol(9)})",
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w700),
                            ),
                            token.isNative ?? false
                                ? const SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () {
                                      ClipboardUtils.copy(token.address ?? "")
                                          .then((_) {
                                        if (!context.mounted) return;
                                        ToastUtils.showCenterToast(
                                            context, S.of(context).copySuccess);
                                      });
                                    },
                                    child: Text(
                                      Web3Address.desensitization(token.address
                                          ?.splitStartAndEnd(4, 4)),
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color:
                                              AppColors.textPrimary(context)),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            CurrencyFormatter.abbreviateTokenPriceWithSymbol(
                              double.tryParse(token.priceUsd ?? "0.0") ?? 0.0,
                            ),
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            NumericFormatter.formatWithSign(
                              double.tryParse(token.priceChange24h ?? "0.0") ??
                                  0.0,
                            ).withSymbol(symbol: "%", isPrefix: false),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color:
                                    ColorsHelper.getColorByValueWithZeroColor(
                                        token.priceChange24h ?? "0.0",
                                        zeroColor:
                                            AppColors.textSecondary(context))),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
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
                        "流通市值",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary(context)),
                      ),
                      Text(
                        CurrencyFormatter.formatPriceEnglish(
                            double.tryParse(token.marketCap ?? "0.0") ?? 0.0,
                            lowerCase: true),
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.textPrimary(context)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "流动性",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary(context)),
                      ),
                      Text(
                        CurrencyFormatter.formatPriceEnglish(
                            double.tryParse(token.liquidity ?? "0.0") ?? 0.0,
                            lowerCase: true),
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.textPrimary(context)),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "24h成交额",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary(context)),
                      ),
                      Text(
                        CurrencyFormatter.formatPriceEnglish(
                            double.tryParse(token.volume24h ?? "0.0") ?? 0.0,
                            lowerCase: true),
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.textPrimary(context)),
                      )
                    ],
                  )
                ],
              ),
            ),
            QueryTokenCardButton(token: token)
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
        final isLoggedIn = context.read<UserCubit>().state.isLoggedIn;

        if (!isLoggedIn) {
          context.push(Routes.login);
          return;
        }

// 如果标的是 SOL，上面用 BNB（BNB 链）
// 如果标的是 SOL 之外的主币，上方用 SOL （SOL链）
        if (token.isNative ?? false) {
          if (token.symbol?.toLowerCase() == "sol") {
            ShowSheet.common(
                context,
                CommonSheet(
                  padding: EdgeInsets.only(top: 16.h),
                  child: const TradeSwap(
                    buyToken: true,
                  ),
                ));

            context.read<TradeCubit>().updateFromToken(defaultBNBTradeToken);

            context.read<TradeCubit>().updateToToken(defaultFormTradeToken);
          } else {
            ShowSheet.common(
                context,
                CommonSheet(
                  padding: EdgeInsets.only(top: 16.h),
                  child: const TradeSwap(
                    buyToken: true,
                  ),
                ));

            context.read<TradeCubit>().updateFromToken(defaultFormTradeToken);

            context
                .read<TradeCubit>()
                .updateToToken(TradeToken.fromQueryToken(token));
          }
        } else {
          ShowSheet.trade(context);

          context
              .read<QuickTradeCubit>()
              .updateSelectedToken(Token.fromQueryToken(token));
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
        "assets/images/icons/aim-outline.svg",
        colorFilter: const ColorFilter.mode(
          Colors.black,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        "立即买入",
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }
}

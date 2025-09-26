import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/format/desensitization.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/utils/sheet/sheet.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/widgets/button/buy.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/sheet/common.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_aigun/widgets/swap/widgets/swap.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class IntelTokenItem extends StatelessWidget {
  const IntelTokenItem({super.key, required this.token});

  final Entity token;

  @override
  Widget build(BuildContext context) {
    return Container(
        key: ValueKey(token.id),
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
        // color: Colors.blue,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.gradientBlueStart,
                  AppColors.gradientBlueEnd
                ])),
        child: Column(
          children: [
            Row(
              children: [
                // 币种图标
                GestureDetector(
                  onTap: () {
                    context
                        .read<TokenDetailCubit>()
                        .updateToken(Token.fromEntity(token));
                    // 跳转到代币详情页面

                    context
                        .read<QuickTradeCubit>()
                        .updateSelectedToken(Token.fromEntity(token));

                    context.push(Routes.tokenDetail, extra: 'intel');
                  },
                  child: TokenIcon(token: token),
                ),
                const SizedBox(width: 16),
                // 币种名称和风险项
                GestureDetector(
                  onTap: () {
                    context
                        .read<TokenDetailCubit>()
                        .updateToken(Token.fromEntity(token));
                    // 跳转到代币详情页面
                    context.push(Routes.tokenDetail, extra: 'intel');
                  },
                  child: TokenInfo(token: token),
                ),
                const Spacer(),
                // 买入按钮
                TokenBuyButton(token: token)
              ],
            ),
            const SizedBox(height: 12),
            TokenStatsRow(token: token)
          ],
        ));
  }
}

// 币种图标组件
class TokenIcon extends StatelessWidget {
  const TokenIcon({super.key, required this.token});

  final Entity? token;

  @override
  Widget build(BuildContext context) {
    final tokenName = token?.name;
    final name = tokenName != null && tokenName.isNotEmpty ? tokenName[0] : '?';

    return RepaintBoundary(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: SmartNetworkImage(
              url: getImageUrl(token?.logo) ?? "",
              width: 40.w,
              height: 40.h,
              fit: BoxFit.cover,
              loadingWidget: Container(
                width: 40.w,
                height: 40.h,
                color: AppColors.tokenPlaceholderColor,
                alignment: Alignment.center,
                child: Text(name,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.backgroundWhite)),
              ),
              errorWidget: Container(
                width: 40.w,
                height: 40.h,
                color: AppColors.tokenPlaceholderColor,
                alignment: Alignment.center,
                child: Text(name,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.backgroundWhite)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -10,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: SmartNetworkImage(
                    url: getImageUrl(token?.chain?.logo) ?? "",
                    width: 17.w,
                    height: 17.h,
                    fit: BoxFit.cover,
                    errorWidget: CachedImage(
                        imageUrl: "assets/images/icons/ai-agent.png",
                        height: 17.h,
                        width: 17.w),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

// 币种信息组件
class TokenInfo extends StatelessWidget {
  const TokenInfo({super.key, required this.token});

  final Entity token;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              splitText(token.symbol ?? ""),
              style: const TextStyle(
                  textBaseline: TextBaseline.ideographic,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.backgroundWhite),
            ),
            const SizedBox(width: 8),
          ],
        ),
        // 币种地址 复制地址
        Text(Web3Address.desensitization(token.contractAddress),
            style: const TextStyle(
                textBaseline: TextBaseline.alphabetic,
                fontSize: 16,
                color: AppColors.backgroundWhite)),
      ],
    );
  }
}

// 买入按钮组件
class TokenBuyButton extends StatelessWidget {
  const TokenBuyButton({super.key, required this.token});

  final Entity token;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: BuyButton(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            onPressed: () {
              // final isLoggedIn = context.read<UserCubit>().state.isLoggedIn;

              // if (!isLoggedIn) {
              //   Toastification().show(
              //       type: ToastificationType.error,
              //       title: Text(
              //         S.of(context).authMessages_loginFirst,
              //         style: TextStyle(color: AppColors.textPrimary(context)),
              //       ),
              //       alignment: Alignment.topCenter,
              //       autoCloseDuration: const Duration(seconds: 3),
              //       closeButtonShowType: CloseButtonShowType.none,
              //       backgroundColor: AppColors.background(context),
              //       showProgressBar: false);
              //   return;
              // }

// 如果标的是 SOL，上面用 BNB（BNB 链）
// 如果标的是 SOL 之外的主币，上方用 SOL （SOL链）
              if (token.isNativeToken || token.isNative == true) {
                if (token.symbol?.toLowerCase() == "sol") {
                  ShowSheet.common(
                      context,
                      CommonSheet(
                        padding: EdgeInsets.only(top: 16.h),
                        child: const TradeSwap(
                          buyToken: true,
                        ),
                      ));

                  context
                      .read<TradeCubit>()
                      .updateFromToken(defaultBNBTradeToken);

                  context
                      .read<TradeCubit>()
                      .updateToToken(defaultFormTradeToken);
                } else {
                  ShowSheet.common(
                      context,
                      CommonSheet(
                        padding: EdgeInsets.only(top: 16.h),
                        child: const TradeSwap(
                          buyToken: true,
                        ),
                      ));

                  context
                      .read<TradeCubit>()
                      .updateFromToken(defaultFormTradeToken);

                  context
                      .read<TradeCubit>()
                      .updateToToken(TradeToken.fromEntity(token));
                }
              } else {
                ShowSheet.trade(context);

                context
                    .read<QuickTradeCubit>()
                    .updateSelectedToken(Token.fromEntity(token));
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/icons/lightning.svg",
                  width: 17,
                  height: 19,
                ),
                const SizedBox(width: 4),
                Text(S.of(context).buyIn,
                    style: TextStyle(color: Colors.black, fontSize: 16.sp))
              ],
            )));
  }
}

// 统计数据行组件
class TokenStatsRow extends StatelessWidget {
  const TokenStatsRow({super.key, required this.token});

  final Entity token;

  @override
  Widget build(BuildContext context) {
    final heighestIncreaseRate = token.stats?.heighestIncreaseRate ?? "0";
    final warningMarketCap = token.stats?.warningMarketCap ?? "0";
    final currentMarketCap = token.stats?.currentMarketCap ?? "0";

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: TokenStatsItem(
            title: S.of(context).warningHighestProfit,
            value: formatDecimal(
              Decimal.parse(heighestIncreaseRate).toDouble(),
            ).toString(),
            alignment: CrossAxisAlignment.start,
            alignmentGeometry: Alignment.centerLeft,
            valueWidget: Text(
              _formatIncreaseRateDisplay(heighestIncreaseRate),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.tertiary,
              ),
            ),
          )),
          Expanded(
              child: TokenStatsItem(
            title: S.of(context).warningMarketCap,
            value: formatPriceEnglish(
                double.tryParse(warningMarketCap.toString()) ?? 0),
            alignment: CrossAxisAlignment.center,
            alignmentGeometry: Alignment.center,
          )),
          Expanded(
              child: TokenStatsItem(
            title: S.of(context).currentMarketCap,
            value: formatPriceEnglish(
                double.tryParse(currentMarketCap.toString()) ?? 0),
            alignment: CrossAxisAlignment.end,
            alignmentGeometry: Alignment.centerRight,
          )),
        ],
      ),
    );
  }

  String _formatIncreaseRateDisplay(String increaseRate) {
    final rate = Decimal.tryParse(increaseRate)?.toDouble() ?? 0.0;

    if (rate <= 0) {
      // 如果是跌的（<=0），显示为 "<1x"
      return "<1x";
    } else if (rate < 1) {
      // 如果是大于 0，小于 100%，那么显示为对应的涨幅，不要保留小数，例如 56%，不显示 x
      final percentage = (rate * 100).round();
      return "$percentage%";
    } else {
      // 如果大于 1，那么就最多保留一位小数显示+x，例如：1.2x，12x，123x
      if (rate % 1 == 0) {
        // 如果是整数，直接显示为整倍数
        return "${rate.toInt()}x";
      } else {
        // 如果有小数，最多保留一位小数
        final formatted = rate.toStringAsFixed(1);
        // 移除末尾的 .0
        return "${formatted.replaceAll(RegExp(r'\.0$'), '')}x";
      }
    }
  }
}

// 统计数据项组件
class TokenStatsItem extends StatelessWidget {
  const TokenStatsItem({
    super.key,
    required this.title,
    required this.value,
    this.alignment,
    this.alignmentGeometry,
    this.valueWidget,
  });

  final String title;
  final String value;
  final CrossAxisAlignment? alignment;
  final AlignmentGeometry? alignmentGeometry;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.white)),
        Expanded(
          child: valueWidget ??
              Align(
                alignment: alignmentGeometry ?? Alignment.center,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
        )
      ],
    );
  }
}

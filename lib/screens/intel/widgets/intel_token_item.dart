import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/shared/utils/token_purchase.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/extensions/string.dart';
import 'package:flutter_aigun/utils/format/desensitization.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/format/profit.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/widgets/button/buy.dart';
import 'package:flutter_aigun/widgets/feature_image.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// import 'package:provider/provider.dart';

import '../../../core/router/constants.dart';
import '../../../core/service_locator.dart';

class IntelTokenItem extends StatelessWidget {
  const IntelTokenItem({super.key, required this.token, required this.score});

  final Entity token;
  final double score;
  void _handleTokenTap(BuildContext context) async {
    final isLoggedIn = getIt<UserCubit>().state.isLoggedIn;

    if (!isLoggedIn) {
      context.pushNamed(RouteNames.login);
      return;
    }

    try {
      final newToken = Token.fromEntity(token);

      context.pushNamed(RouteNames.tokenDetail, extra: 'intel');
      await getIt<TokenDetailCubit>().updateToken(newToken);

      getIt<QuickTradeCubit>().updateSelectedToken(newToken);
      // 跳转到代币详情页面
    } catch (e) {
      Logger.error("updateToken error: $e");
    }
  }

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
                  onTap: () => _handleTokenTap(context),
                  child: TokenIcon(token: token),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => _handleTokenTap(context),
                  child: TokenInfo(token: token, score: score),
                ),
                const Spacer(),
                TokenBuyButton(token: token, score: score)
              ],
            ),
            const SizedBox(height: 12),
            TokenStatsRow(token: token, score: score)
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
    final name = tokenName != null && tokenName.isNotEmpty
        ? tokenName[0].toUpperCase()
        : '?';

    return RepaintBoundary(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: FeatureImage(
                url: ImageUtils.getImageUrl(token?.logo),
                width: 40.w,
                height: 40.h,
                errorWidget: Container(
                  width: 40.w,
                  height: 40.h,
                  color: AppColors.tokenPlaceholderColor,
                  alignment: Alignment.center,
                  child: Text(name,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
                loadingWidget: const SizedBox.shrink(),
                fit: BoxFit.cover),
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
                  child: FeatureImage(
                    url: ImageUtils.getImageUrl(token?.chain?.logo),
                    width: 17.w,
                    height: 17.h,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      width: 17.w,
                      height: 17.h,
                      color: AppColors.senary,
                      alignment: Alignment.center,
                    ),
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
  const TokenInfo({super.key, required this.token, required this.score});

  final Entity token;
  final double score;
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
        if (token.isNative != true)
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
  const TokenBuyButton({super.key, required this.token, required this.score});

  final Entity token;
  final double score;
  @override
  Widget build(BuildContext context) {
    final mode = TokenPurchaseService.getTradeModeFromScore(score);
    return SizedBox(
        child: BuyButton(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            onPressed: () async {
              TokenPurchaseService.handlePurchase(
                  context: context, token: Token.fromEntity(token), mode: mode);
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/icons/lightning.svg",
                  width: 17,
                  height: 19,
                ),
                const SizedBox(width: 4),
                Text(TokenPurchaseService.getTradeTextFromMode(context, mode),
                    style: TextStyle(color: Colors.black, fontSize: 16.sp))
              ],
            )));
  }
}

// 统计数据行组件
class TokenStatsRow extends StatelessWidget {
  const TokenStatsRow({super.key, required this.token, required this.score});

  final Entity token;
  final double score;
  @override
  Widget build(BuildContext context) {
    final heighestIncreaseRate = token.stats?.heighestIncreaseRate ?? "0";
    final highestDecreaseRate = token.stats?.highestDecreaseRate ?? "0";
    final warningMarketCap = token.stats?.warningMarketCap ?? "0";
    final currentMarketCap = token.stats?.currentMarketCap ?? "0";
    final mode = TokenPurchaseService.getTradeModeFromScore(score);
    final highestValue =
        mode == QuickTradeMode.buy ? heighestIncreaseRate : highestDecreaseRate;
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: TokenStatsItem(
            title: S.of(context).warningHighestProfit,
            value: ProfitFormatter.format(highestValue.toDouble(),
                mode: mode),
            alignment: CrossAxisAlignment.start,
            alignmentGeometry: Alignment.centerLeft,
            valueWidget: Text(
              // ProfitFormatter.format(double.tryParse(highestValue) ?? 0,
              //     mode: mode),
              ProfitFormatter.format(highestValue.toDouble(),
                  mode:mode),
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

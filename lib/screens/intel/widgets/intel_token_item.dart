import 'package:aigun_app/enums/quick_trade_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// import 'package:provider/provider.dart';

import '../../../core/router/constants.dart';
import '../../../core/service_locator.dart';
import '../../../cubits/index.dart';
import '../../../data/models/intel/intel.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/presentation/extensions/string_number_extension.dart';
import '../../../shared/presentation/widgets/auto_scale.dart';
import '../../../shared/utils/token_purchase.dart';
import '../../../themes/themes.dart';
import '../../../utils/extensions/string.dart';
import '../../../utils/format/desensitization.dart';
import '../../../utils/format/profit.dart';
import '../../../utils/image_utils.dart';
import '../../../utils/web3/address.dart';
import '../../../widgets/button/buy.dart';
import '../../../widgets/feature_image.dart';
import '../../../widgets/token/models/token.dart';

class IntelTokenItem extends StatelessWidget {
  const IntelTokenItem({super.key, required this.token});

  final Entity token;
  void _handleTokenTap(BuildContext context) async {
    final newToken = Token.fromEntity(token);

    context.pushNamed(RouteNames.tokenDetail, extra: 'intel');
    await getIt<TokenDetailCubit>().updateToken(newToken);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(token.id),
      padding: EdgeInsets.symmetric(horizontal: 13.0.w, vertical: 10.0.h),
      // color: Colors.blue,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.gradientBlueStart, AppColors.gradientBlueEnd],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => _handleTokenTap(context),
                child: TokenIcon(token: token),
              ),
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: () => _handleTokenTap(context),
                child: TokenInfo(token: token),
              ),
              const Spacer(),
              TokenBuyButton(token: token),
            ],
          ),
          SizedBox(height: 12.h),
          TokenStatsRow(token: token),
        ],
      ),
    );
  }
}

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
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              loadingWidget: const SizedBox.shrink(),
              fit: BoxFit.cover,
            ),
          ),
          if (token?.shouldShowChainLogo ?? false)
            Positioned(
              bottom: 0,
              right: -10.w,
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}

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
              splitText(token.symbol ?? ''),
              style: TextStyle(
                textBaseline: TextBaseline.ideographic,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.backgroundWhite,
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),

        if (token.shouldShowAddress)
          Text(
            Web3Address.desensitization(token.contractAddress),
            style: const TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: 16,
              color: AppColors.backgroundWhite,
            ),
          ),
      ],
    );
  }
}

class TokenBuyButton extends StatelessWidget {
  const TokenBuyButton({super.key, required this.token});

  final Entity token;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BuyButton(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.w),
        onPressed: () async {},
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/icons/lightning.svg',
              width: 17.w,
              height: 19.w,
            ),
            const SizedBox(width: 4),
            Text(
              "Buy",
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class TokenStatsRow extends StatelessWidget {
  const TokenStatsRow({super.key, required this.token});

  final Entity token;
  @override
  Widget build(BuildContext context) {
    final heighestIncreaseRate = token.stats?.heighestIncreaseRate ?? '0';
    final highestDecreaseRate = token.stats?.highestDecreaseRate ?? '0';
    final warningMarketCap = token.stats?.warningMarketCap ?? '0';
    final currentMarketCap = token.stats?.currentMarketCap ?? '0';
    final mode = TokenPurchaseService.getTradeModeFromScore(token.score ?? 0);
    final highestValue = mode == QuickTradeMode.buy
        ? heighestIncreaseRate
        : highestDecreaseRate;
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TokenStatsItem(
              title: S.of(context).warningHighestProfit,
              value: ProfitFormatter.format(
                highestValue.toDouble(),
                mode: mode,
              ),
              alignment: CrossAxisAlignment.start,
              alignmentGeometry: Alignment.centerLeft,
              valueWidget: AutoScale(
                alignment: Alignment.centerLeft,
                child: Text(
                  // ProfitFormatter.format(double.tryParse(highestValue) ?? 0,
                  //     mode: mode),
                  ProfitFormatter.format(highestValue.toDouble(), mode: mode),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TokenStatsItem(
              title: S.of(context).warningMarketCap,
              value: warningMarketCap.marketCap(),
              alignment: CrossAxisAlignment.center,
              alignmentGeometry: Alignment.center,
            ),
          ),
          Expanded(
            child: TokenStatsItem(
              title: S.of(context).currentMarketCap,
              value: currentMarketCap.marketCap(),
              alignment: CrossAxisAlignment.end,
              alignmentGeometry: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }
}

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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
        SizedBox(height: 5.h),
        Container(
          height: 28.h,
          alignment: alignmentGeometry ?? Alignment.centerLeft,
          child:
              valueWidget ??
              AutoScale(
                alignment: alignmentGeometry ?? Alignment.center,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
        ),
      ],
    );
  }
}

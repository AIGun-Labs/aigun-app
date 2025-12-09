import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// import 'package:provider/provider.dart';

import '../../../core/router/constants.dart';
import '../../../core/router/routes/app_routes.dart';
import '../../../core/service_locator.dart';
import '../../../cubits/index.dart';
import '../../../data/models/intel/intel.dart';
import '../../../features/token_detail/presentation/cubits/token_info/token_info_cubit.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/domain/mappers/entity_mapper.dart';
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
    final isLoggedIn = getIt<UserCubit>().state.isLoggedIn;

    if (!isLoggedIn) {
      context.pushNamed(RouteNames.login);
      return;
    }

    final newToken = Token.fromEntity(token);
    getIt<QuickTradeCubit>().updateSelectedToken(newToken);

    try {
      final tokenInfoCubit = BlocProvider.of<TokenInfoCubit>(context);
      final network = tokenInfoCubit.state.network;
      final address = tokenInfoCubit.state.address;
      if (network != newToken.network || address != newToken.address) {
        TokenDetailRoute(
          token.toTokenEntity(),
          type: 'intel',
        ).pushReplacement(context);
      }
    } catch (e) {
      TokenDetailRoute(token.toTokenEntity(), type: 'intel').push(context);
    }
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
              // 币种图标
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
              height: 40.w,
              errorWidget: Container(
                width: 40.w,
                height: 40.w,
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
                    height: 17.w,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      width: 17.w,
                      height: 17.w,
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
        // 币种地址 复制地址
        if (token.shouldShowAddress)
          Text(
            Web3Address.desensitization(token.contractAddress),
            style: TextStyle(
              textBaseline: TextBaseline.alphabetic,
              fontSize: 16.sp,
              color: AppColors.backgroundWhite,
            ),
          ),
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
    final mode = TokenPurchaseService.getTradeModeFromScore(token.score ?? 0);
    return SizedBox(
      child: BuyButton(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.w),
        onPressed: () async {
          TokenPurchaseService.handlePurchase(
            context: context,
            token: Token.fromEntity(token),
            mode: mode,
          );
        },
        child: Row(
          children: [
            SvgPicture.asset(
              // 'assets/images/icons/lightning.svg',
              Assets.images.icons.lightning,
              width: 17.w,
              height: 19.w,
            ),
            const SizedBox(width: 4),
            Text(
              TokenPurchaseService.getTradeTextFromMode(context, mode),
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}

// 统计数据行组件
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

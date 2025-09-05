import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/cubits/trade/trade_cubit.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/format/desensitization.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/widgets/button/buy.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class IntelTokenItem extends StatelessWidget {
  const IntelTokenItem({super.key, required this.token});

  final Entity token;

  @override
  Widget build(BuildContext context) {
    return Container(
        key: ValueKey(token.id),
        padding: const EdgeInsets.all(12.0),
        // color: Colors.blue,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
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
                _buildTokenIcon(
                  token,
                ),
                const SizedBox(width: 12),
                // 币种名称和风险项
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          splitText(token.name ?? ""),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.backgroundWhite),
                        ),
                        const SizedBox(width: 8),
                        // Text(
                        //   "3 风险项",
                        //   style: TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w700,
                        //       color: Colors.red),
                        // )
                      ],
                    ),
                    // 币种地址
                    GestureDetector(
                      onTap: () async {
                        ClipboardUtils.copy(token.contractAddress ?? "")
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.background(context),
                              content: Text(
                                S.of(context).ui_copied,
                                style: TextStyle(
                                    color: AppColors.textPrimary(context)),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });
                      },
                      child: Text(
                          Web3Address.Desensitization(token.contractAddress),
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.backgroundWhite)),
                    ),
                  ],
                ),
                const Spacer(),
                // 买入按钮
                SizedBox(
                    child: BuyButton(
                        onPressed: () {
                          // 更新目标 token
                          // context.read<SwapCubit>().updateTargetToken(
                          //     TargetToken(
                          //         chainId: token.chain?.id,
                          //         tokenName: token.name,
                          //         tokenAddress: token.contractAddress,
                          //         tokenAvatar: token.logo));

                          context.read<TradeCubit>().updateToToken(TradeToken(
                                chainId: int.tryParse(
                                        token.chain?.networkId ?? "") ??
                                    0,
                                chainLogo: token.chain?.logo ?? "",
                                tokenAvatar: token.logo ?? "",
                                tokenName: token.name ?? "",
                                decimals: token.decimals ?? 18,
                                address: token.contractAddress ?? "",
                                symbol: token.symbol ?? "",
                              ));

                          // 使用 pushReplacement 导航到首页并设置 tab
                          context.push(Routes.home, extra: NavIndex.trade);
                        },
                        child: Row(
                          children: [
                            // Icon(Icons.lightt)
                            SvgPicture.asset(
                              "assets/images/icons/lightning.svg",
                              width: 18,
                              height: 20,
                            ),
                            const SizedBox(width: 4),
                            const Text("Buy",
                                style: TextStyle(color: Colors.black))
                          ],
                        )))
              ],
            ),
            const SizedBox(height: 12),
            _buildStatsRow(token)
          ],
        ));
  }

  Widget _buildStatsRow(Entity token) {
    final heighestIncreaseRate = token.stats?.heighestIncreaseRate ?? "0";
    final warningMarketCap = token.stats?.warningMarketCap ?? "0";
    final currentMarketCap = token.stats?.currentMarketCap ?? "0";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTokenStatsItem(
          "Max Increase",
          formatDecimal(
            Decimal.parse(heighestIncreaseRate).toDouble(),
          ).toString(),
          CrossAxisAlignment.start,
          Text(
            "${formatPrice(Decimal.parse(heighestIncreaseRate).toDouble())}x",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.tertiary,
            ),
          ),
        ),
        _buildTokenStatsItem(
          "Warn Market Cap",
          formatPriceEnglish(double.tryParse(warningMarketCap.toString()) ?? 0),
          CrossAxisAlignment.center,
          null,
        ),
        _buildTokenStatsItem(
          "Current Market Cap",
          formatPriceEnglish(double.tryParse(currentMarketCap.toString()) ?? 0),
          CrossAxisAlignment.end,
          null,
        ),
      ],
    );
  }

  Widget _buildTokenStatsItem(
    String title,
    String value,
    CrossAxisAlignment? alignment,
    Widget? valueWidget,
  ) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 12, color: AppColors.backgroundWhite)),
        valueWidget ??
            Text(value,
                style: const TextStyle(
                    fontSize: 16, color: AppColors.backgroundWhite)),
      ],
    );
  }

// 构建币种图标
  Widget _buildTokenIcon(Entity? token) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: SmartNetworkImage(
            url: getImageUrl(token?.logo) ?? "",
            width: 48.w,
            height: 48.h,
            fit: BoxFit.cover,
            // errorWidget: CachedImage(
            //     imageUrl: "assets/images/icons/ai-agent.png",
            //     height: 48.h,
            //     width: 48.w),
            errorWidget: Container(
              width: 48.w,
              height: 48.h,
              // color:
              //     Random().nextBool() ? Color(0xFF7DD3FC) : Color(0xFFA5B4FC),
              // color: AppColors.quinary,
              color: Color(0xFF38BDF8),
              alignment: Alignment.center,
              child: Text(token?.symbol?.split('').first ?? "",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.backgroundWhite)),
            ),
          ),
        ),
        Positioned(
          bottom: -4,
          right: -4,
          child: ClipOval(
            child: SmartNetworkImage(
              url: getImageUrl(token?.chain?.logo) ?? "",
              width: 24.w,
              height: 24.h,
              fit: BoxFit.cover,
              errorWidget: CachedImage(
                  imageUrl: "assets/images/icons/ai-agent.png",
                  height: 24.h,
                  width: 24.w),
            ),
          ),
        )
      ],
    );
  }
}

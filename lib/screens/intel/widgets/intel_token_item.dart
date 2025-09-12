import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/models/intel/intel.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/format/desensitization.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/utils/sheet/sheet.dart';
import 'package:flutter_aigun/utils/web3/address.dart';
import 'package:flutter_aigun/widgets/button/buy.dart';
import 'package:flutter_aigun/widgets/image.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                _buildTokenIcon(
                  token,
                ),
                const SizedBox(width: 16),
                // 币种名称和风险项
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          splitText(token.name ?? ""),
                          style: const TextStyle(
                              textBaseline: TextBaseline.ideographic,
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
                    // 币种地址 复制地址
                    GestureDetector(
                      onTap: () async {
                        ClipboardUtils.copy(token.contractAddress ?? "")
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.card(context),
                              content: Text(
                                S.of(context).ui_copied,
                                style: TextStyle(
                                    color: AppColors.textPrimary(context)),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                      },
                      child: Text(
                          Web3Address.Desensitization(token.contractAddress),
                          style: const TextStyle(
                              textBaseline: TextBaseline.alphabetic,
                              fontSize: 16,
                              color: AppColors.backgroundWhite)),
                    ),
                  ],
                ),
                const Spacer(),
                // 买入按钮
                SizedBox(
                    child: BuyButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 3),
                        onPressed: () {
                          final isLoggedIn =
                              context.read<UserCubit>().state.isLoggedIn;

                          if (!isLoggedIn) {
                            Toastification().show(
                                type: ToastificationType.error,
                                title: Text(
                                  S.of(context).authMessages_loginFirst,
                                  style: TextStyle(
                                      color: AppColors.textPrimary(context)),
                                ),
                                alignment: Alignment.topCenter,
                                autoCloseDuration: const Duration(seconds: 3),
                                closeButtonShowType: CloseButtonShowType.none,
                                backgroundColor: AppColors.background(context),
                                showProgressBar: false);
                            return;
                          }

                          ShowSheet.trade(context);
                          context
                              .read<QuickTradeCubit>()
                              .updateSelectedToken(Token.fromEntity(token));
                        },
                        child: Row(
                          children: [
                            // Icon(Icons.lightt)
                            SvgPicture.asset(
                              "assets/images/icons/lightning.svg",
                              width: 17,
                              height: 19,
                            ),
                            const SizedBox(width: 4),
                            Text(S.of(context).buyIn,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.sp))
                          ],
                        )))
              ],
            ),
            const SizedBox(height: 12),
            _buildStatsRow(token, context)
          ],
        ));
  }

  Widget _buildStatsRow(Entity token, BuildContext context) {
    final heighestIncreaseRate = token.stats?.heighestIncreaseRate ?? "0";
    final warningMarketCap = token.stats?.warningMarketCap ?? "0";
    final currentMarketCap = token.stats?.currentMarketCap ?? "0";
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: _buildTokenStatsItem(
            S.of(context).warningHighestIncreaseRate,
            formatDecimal(
              Decimal.parse(heighestIncreaseRate).toDouble(),
            ).toString(),
            CrossAxisAlignment.start,
            Alignment.centerLeft,
            Text(
              _formatIncreaseRateDisplay(heighestIncreaseRate),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.tertiary,
              ),
            ),
          )),
          Expanded(
              child: _buildTokenStatsItem(
            S.of(context).warningMarketCap,
            formatPriceEnglish(
                double.tryParse(warningMarketCap.toString()) ?? 0),
            CrossAxisAlignment.center,
            Alignment.center,
            null,
          )),
          Expanded(
              child: _buildTokenStatsItem(
            S.of(context).currentMarketCap,
            formatPriceEnglish(
                double.tryParse(currentMarketCap.toString()) ?? 0),
            CrossAxisAlignment.end,
            Alignment.centerRight,
            null,
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

  Widget _buildTokenStatsItem(
    String title,
    String value,
    CrossAxisAlignment? alignment,
    AlignmentGeometry? alignmentGeometry,
    Widget? valueWidget,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 12.sp, color: AppColors.white)),
        Expanded(
          child: valueWidget ??
              Align(
                alignment: alignmentGeometry ?? Alignment.center,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
        )
      ],
    );
  }

// 构建币种图标
  Widget _buildTokenIcon(Entity? token) {
    final tokenName = token?.name;
    final name = tokenName != null && tokenName.isNotEmpty ? tokenName[0] : '?';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: SmartNetworkImage(
            url: getImageUrl(token?.logo) ?? "",
            width: 40.w,
            height: 40.h,
            fit: BoxFit.cover,
            // errorWidget: CachedImage(
            //     imageUrl: "assets/images/icons/ai-agent.png",
            //     height: 48.h,
            //     width: 48.w),
            loadingWidget: Container(
              width: 40.w,
              height: 40.h,
              // color:
              //     Random().nextBool() ? Color(0xFF7DD3FC) : Color(0xFFA5B4FC),
              // color: AppColors.quinary,
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
              // color:
              //     Random().nextBool() ? Color(0xFF7DD3FC) : Color(0xFFA5B4FC),
              // color: AppColors.quinary,
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
          // child: ClipOval(
          //   child: SmartNetworkImage(
          //     url: getImageUrl(token?.chain?.logo) ?? "",
          //     width: 18.w,
          //     height: 18.h,
          //     fit: BoxFit.cover,
          //     errorWidget: CachedImage(
          //         imageUrl: "assets/images/icons/ai-agent.png",
          //         height: 18.h,
          //         width: 18.w),
          //   ),
          // ),
          // child: ClipOval(
          //     child: Container(
          //   width: 17.w,
          //   height: 17.h,
          //   decoration: BoxDecoration(
          //       border: Border.all(color: AppColors.white, width: 1),
          //       shape: BoxShape.circle),
          //   child: SmartNetworkImage(
          //     url: getImageUrl(token?.chain?.logo) ?? "",
          //     width: 17.w,
          //     height: 17.h,
          //     fit: BoxFit.cover,
          //     errorWidget: CachedImage(
          //         imageUrl: "assets/images/icons/ai-agent.png",
          //         height: 17.h,
          //         width: 17.w),
          //   ),
          // )),

          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white, width: 1),
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
    );
  }
}

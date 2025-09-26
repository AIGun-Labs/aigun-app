import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/format/currency.dart';
import 'package:flutter_aigun/utils/format/number.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingTradeRow extends StatelessWidget {
  const SettingTradeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
      final gasFee = CurrencyFormatter.abbreviateTokenPriceWithSymbol(
          double.parse(state.quote?.gasFee ?? "0"));

      final setting =
          context.read<TradeSettingCubit>().getCurrentTradeCustomSetting();

      return BlocBuilder<TradeSettingCubit, TradeSettingState>(
          builder: (context, tradeSetting) {
        final slippage = tradeSetting.mode == TradeMode.custom
            ? "${setting.slippage ?? 0}%"
            : S.of(context).auto;

        return GestureDetector(
          onTap: () {
            context.push(Routes.tradeSetting);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SettingModeIcon(),
                  const SizedBox(
                    width: 4,
                  ),
                  const SettingModeText(),
                  // Icon(
                  //   Icons.keyboard_arrow_right,
                  //   size: 16.w,
                  //   color: AppColors.textSecondary(context),
                  // ),
                  SvgPicture.asset(
                    "assets/images/icons/arrow-right-circle-outline.svg",
                    width: 18.w,
                    height: 18.h,
                    colorFilter: ColorFilter.mode(
                        AppColors.textTertiary(context), BlendMode.srcIn),
                  )
                ],
              ),
              Row(
                spacing: 10.w,
                children: [
                  Row(
                    spacing: 4.w,
                    children: [
                      SvgPicture.asset(
                        "assets/images/icons/slippage.svg",
                        width: 14.w,
                        height: 14.w,
                        colorFilter: ColorFilter.mode(
                            AppColors.textTertiary(context), BlendMode.srcIn),
                      ),
                      Text(slippage,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textPrimary(context))),
                    ],
                  ),
                  Row(
                    spacing: 4.w,
                    children: [
                      SvgPicture.asset(
                        "assets/images/icons/gas-fee.svg",
                        width: 12.w,
                        height: 12.w,
                        colorFilter: const ColorFilter.mode(
                            Color(0xFF909090), BlendMode.srcIn),
                      ),
                      Text(gasFee,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textPrimary(context))),
                    ],
                  ),
                  Row(
                    spacing: 4.w,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/icons/shield.svg",
                        width: 10.w,
                        height: 12.w,
                        colorFilter: const ColorFilter.mode(
                            Color(0xFF909090), BlendMode.srcIn),
                      ),
                      Text(
                          setting.mevProtect
                              ? S.of(context).open
                              : S.of(context).close,
                          style: TextStyle(
                              fontSize: 14.sp, color: const Color(0xFF909090))),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      });
    });
  }
}

class SettingModeIcon extends StatelessWidget {
  const SettingModeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
        buildWhen: (previous, current) => previous.mode != current.mode,
        builder: (context, state) {
          final path = state.mode == TradeMode.fast
              ? "assets/images/icons/lightning-outline.svg"
              : state.mode == TradeMode.normal
                  ? "assets/images/icons/coffee-outline.svg"
                  : "assets/images/icons/tool-outline.svg";

          return SvgPicture.asset(
            width: 13.w,
            height: 13.w,
            colorFilter: ColorFilter.mode(
                AppColors.textTertiary(context), BlendMode.srcIn),
            path,
          );
        });
  }
}

class SettingModeText extends StatelessWidget {
  const SettingModeText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
        builder: (context, state) {
      final mode = state.mode == TradeMode.fast
          ? S.of(context).fastMode
          : TradeMode.normal == state.mode
              ? S.of(context).normalMode
              : S.of(context).customMode;
      return Text(mode,
          style: TextStyle(
              fontSize: 14.sp, color: AppColors.textTertiary(context)));
    });
  }
}

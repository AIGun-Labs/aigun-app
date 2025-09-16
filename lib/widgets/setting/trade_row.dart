import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/themes/themes.dart';
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
      final gasFee = formatPrice(state.quote?.gasFee ?? 0);
      // final tradeSetting = context.read<TradeSettingCubit>().state;

      return BlocBuilder<TradeSettingCubit, TradeSettingState>(
          builder: (context, tradeSetting) {
        final setting = tradeSetting.customSettings[state.fromChainId];
        final mode = tradeSetting.mode == TradeMode.fast
            ? S.of(context).fastMode
            : tradeSetting.mode == TradeMode.normal
                ? S.of(context).normalMode
                : S.of(context).customTrade(state.fromToken?.chainName ?? "");
        return GestureDetector(
          onTap: () {
            context.push(Routes.tradeSetting);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                width: 13.w,
                height: 13.w,
                colorFilter: ColorFilter.mode(
                    AppColors.textSecondary(context), BlendMode.srcIn),
                "assets/images/icons/lightning-outline.svg",
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                mode,
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.textSecondary(context)),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 16.w,
                color: AppColors.textSecondary(context),
              ),
              const Spacer(),
              Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons/slippage.svg",
                    width: 13.w,
                    height: 13.w,
                  ),
                  Text("${setting?.slippage ?? 0}%",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary(context))),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons/gas-fee.svg",
                    width: 12.w,
                    height: 12.w,
                  ),
                  Text("\$$gasFee",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary(context))),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/icons/shield.svg",
                    width: 10.w,
                    height: 12.w,
                  ),
                  Text(
                      setting?.mevProtect ?? false
                          ? S.of(context).open
                          : S.of(context).close,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary(context))),
                ],
              )
            ],
          ),
        );
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../cubits/trade_setting/trade_setting_cubit.dart';
import '../../../../cubits/trade_setting/trade_setting_state.dart';
import '../../../../enums/trade_mode.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/themes.dart';

/// 交易模式图标
///
/// 根据当前交易模式显示对应图标
class SettingModeIcon extends StatelessWidget {
  const SettingModeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) {
        final path = _getIconPath(state.mode);
        return SvgPicture.asset(
          path,
          width: 13.w,
          height: 13.w,
          colorFilter: ColorFilter.mode(
            AppColors.textSecondary(context),
            BlendMode.srcIn,
          ),
        );
      },
    );
  }

  String _getIconPath(TradeMode mode) {
    switch (mode) {
      case TradeMode.fast:
        return 'assets/images/icons/lightning-outline.svg';
      case TradeMode.normal:
        return 'assets/images/icons/coffee-outline.svg';
      case TradeMode.custom:
        return 'assets/images/icons/tool-outline.svg';
    }
  }
}

/// 交易模式文本
///
/// 根据当前交易模式显示对应文本
class SettingModeText extends StatelessWidget {
  const SettingModeText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
      buildWhen: (previous, current) => previous.mode != current.mode,
      builder: (context, state) {
        final modeText = _getModeText(context, state.mode);
        return Text(
          modeText,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary(context),
          ),
        );
      },
    );
  }

  String _getModeText(BuildContext context, TradeMode mode) {
    switch (mode) {
      case TradeMode.fast:
        return S.of(context).fastMode;
      case TradeMode.normal:
        return S.of(context).normalMode;
      case TradeMode.custom:
        return S.of(context).customMode;
    }
  }
}

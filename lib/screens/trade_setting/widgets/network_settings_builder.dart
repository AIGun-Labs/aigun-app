import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/index.dart';
import '../../../cubits/trade_setting/trade_setting_state.dart';
import '../../../data/models/trade/setting/trade_custom_setting.dart';
import '../../../enums/trade_mode.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/colors.dart';
import '../../../utils/format/currency.dart';
import '../../../widgets/skeleton/widgets/text.dart';
import '../models/network_config.dart';
import 'custom_setting_card.dart';

/// 通用网络设置构建器
class NetworkSettingsBuilder extends StatelessWidget {
  const NetworkSettingsBuilder({
    super.key,
    required this.config,
    required this.controllers,
    required this.focusNodes,
  });

  final NetworkConfig config;
  final Map<NetworkFieldType, TextEditingController> controllers;
  final Map<NetworkFieldType, FocusNode> focusNodes;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
      builder: (context, state) {
        final liveData = state.liveData;
        final isCustomMode = state.mode == TradeMode.custom;

        debugPrint(
            '🎨 NetworkSettingsBuilder build - network: ${state.network}, liveData: $liveData');
        debugPrint(
            '🎨 priorityFee: ${liveData.priorityFee}, tipFee: ${liveData.tipFee}, gasPrice: ${liveData.gasPrice}');

        return CustomSettingCard(
          onTap: () {
            context.read<TradeSettingCubit>().updateTradeMode(TradeMode.custom);
          },
          isSelected: isCustomMode,
          title: s.customTrade(config.displayName),
          subtitle: s.customTradeDesc,
          children: config.fields.map((field) {
            return _buildFieldItem(context, field, liveData, s);
          }).toList(),
        );
      },
    );
  }

  Widget _buildFieldItem(
    BuildContext context,
    NetworkField field,
    dynamic liveData,
    dynamic s,
  ) {
    switch (field.type) {
      case NetworkFieldType.slippage:
        return _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: field.suffix,
            controller: controllers[field.type],
            focusNode: focusNodes[field.type],
            formatters: field.formatters,
          ),
          title: _buildTitle(context: context, title: field.titleBuilder(s)),
        );

      case NetworkFieldType.mevProtect:
        return _buildGridItem(
          context: context,
          control: BlocBuilder<TradeSettingCubit, TradeSettingState>(
            builder: (context, state) {
              final setting = state.customSettings[config.key];
              return Container(
                height: 35.h,
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: setting?.mevProtect ?? false,
                  onChanged: (value) {
                    // 使用当前网络的设置
                    final currentSetting =
                        setting ?? const TradeCustomSetting();
                    final updatedSetting =
                        currentSetting.copyWith(mevProtect: value);

                    context
                        .read<TradeSettingCubit>()
                        .updateCustomSettingForNetwork(
                          config.key,
                          updatedSetting,
                        );
                    // 切换到自定义模式
                    context
                        .read<TradeSettingCubit>()
                        .updateTradeMode(TradeMode.custom);
                  },
                ),
              );
            },
          ),
          title: _buildTitle(context: context, title: field.titleBuilder(s)),
        );

      case NetworkFieldType.priorityFee:
        return _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: field.suffix,
            controller: controllers[field.type],
            focusNode: focusNodes[field.type],
            formatters: field.formatters,
          ),
          bottom: field.showLiveData
              ? _buildRealTime(context, value: liveData.priorityFee)
              : null,
          title: _buildTitle(context: context, title: field.titleBuilder(s)),
        );

      case NetworkFieldType.tipFee:
        return _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: field.suffix,
            controller: controllers[field.type],
            focusNode: focusNodes[field.type],
            formatters: field.formatters,
          ),
          bottom: field.showLiveData
              ? _buildRealTime(context, value: liveData.tipFee)
              : null,
          title: _buildTitle(context: context, title: field.titleBuilder(s)),
        );

      case NetworkFieldType.gasPrice:
        return _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: field.suffix,
            controller: controllers[field.type],
            focusNode: focusNodes[field.type],
            formatters: field.formatters,
          ),
          bottom: field.showLiveData
              ? _buildRealTime(context, value: liveData.gasPrice)
              : null,
          title: _buildTitle(
            context: context,
            title: field.titleBuilder(s),
            // title  的
            // subtitle: field.showLiveData ? s.liveAverage : null,
          ),
        );
    }
  }

  Widget _buildRealTime(BuildContext context, {String? value}) {
    final s = S.of(context);

    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
      buildWhen: (previous, current) =>
          previous.liveDataStatus != current.liveDataStatus,
      builder: (context, state) {
        return Row(
          children: [
            Text(
              s.liveAverage,
              style: TextStyle(
                  fontSize: 12.sp, color: AppColors.textSecondary(context)),
            ),
            state.liveDataStatus.maybeWhen(
              orElse: () => TextSkeleton(width: 20.w, height: 12.h),
              success: (data) => Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    CurrencyFormatter.abbreviateTokenPrice(
                        double.tryParse(value ?? "0") ?? 0),
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.quaternary),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGridItem({
    required BuildContext context,
    required Widget control,
    Widget? title,
    Widget? bottom,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 6.h,
      children: [
        if (title != null) title,
        control,
        if (bottom != null) bottom,
      ],
    );
  }

  Widget _buildTitle({
    required BuildContext context,
    required String title,
    String? subtitle,
  }) {
    return SizedBox(
      height: 20.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14.sp, color: AppColors.textPrimary(context)),
          ),
          if (subtitle != null && subtitle.isNotEmpty) ...[
            SizedBox(width: 4.w),
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 12.sp, color: AppColors.textSecondary(context)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInput(
    BuildContext context, {
    String? suffixText,
    String? hintText = "",
    TextEditingController? controller,
    FocusNode? focusNode,
    List<TextInputFormatter>? formatters,
  }) {
    final suffixWidth = suffixText != "%" ? 40.w : 10.w;

    return SizedBox(
      height: 35.h,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        enableInteractiveSelection: true,
        inputFormatters: formatters,
        style: TextStyle(
          fontSize: 16.sp,
          height: 1.h,
          color: AppColors.textPrimary(context),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          hintText: hintText,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Container(
              width: suffixWidth,
              alignment: Alignment.centerRight,
              child: Text(
                suffixText ?? '',
                softWrap: false,
                overflow: TextOverflow.visible,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 16, color: AppColors.textPrimary(context)),
              ),
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 10.w,
            maxWidth: 40.w,
          ),
          hintStyle: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textQuaternary(context),
            fontWeight: FontWeight.w700,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
                color: AppColors.textQuaternary(context), width: 1.0),
          ),
        ),
      ),
    );
  }
}

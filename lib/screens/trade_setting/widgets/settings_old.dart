import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/network.dart';
import '../../../cubits/index.dart';
import '../../../cubits/trade/trade_state.dart';
import '../../../cubits/trade_setting/trade_setting_state.dart';
import '../../../enums/trade_mode.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/colors.dart';
import '../../../utils/format/input_formatters.dart';
import '../../../widgets/skeleton/widgets/text.dart';
import 'custom_setting_card.dart';
import 'mode_card.dart';

class SettingsColumn extends StatefulWidget {
  const SettingsColumn({super.key});

  @override
  State<SettingsColumn> createState() => _SettingsColumnState();
}

class _SettingsColumnState extends State<SettingsColumn> {
  late final TextEditingController _solanaSlippageController;
  late final TextEditingController _solanaPriorityFeeController;
  late final TextEditingController _solanaTipFeeController;
  late final TextEditingController _solanaMevProtectController;
  late final TextEditingController _ethereumSlippageController;
  late final TextEditingController _ethereumGasPriceController;
  late final TextEditingController _bnbSlippageController;
  late final TextEditingController _bnbGasPriceController;
  late final TextEditingController _baseSlippageController;
  late final TextEditingController _baseGasPriceController;

  @override
  void initState() {
    super.initState();
    _solanaSlippageController = TextEditingController();
    _solanaPriorityFeeController = TextEditingController();
    _solanaTipFeeController = TextEditingController();
    _solanaMevProtectController = TextEditingController();
    _ethereumSlippageController = TextEditingController();
    _ethereumGasPriceController = TextEditingController();
    _bnbSlippageController = TextEditingController();
    _bnbGasPriceController = TextEditingController();
    _baseSlippageController = TextEditingController();
    _baseGasPriceController = TextEditingController();
    final state = context.read<TradeSettingCubit>().state;
    _updateControllersFromState(state);
    _setupListeners();
  }

  void _updateControllersFromState(TradeSettingState state) {
    final solanaSetting = state.customSettings["solana"];
    final ethereumSetting = state.customSettings["eth"];
    final bnbSetting = state.customSettings["bsc"];
    final baseSetting = state.customSettings["base"];

    if (solanaSetting != null) {
      _solanaSlippageController.text = solanaSetting.slippage.toString();
      _solanaPriorityFeeController.text = solanaSetting.priorityFee ?? '';
      _solanaTipFeeController.text = solanaSetting.tipFee ?? '';
    }

    if (ethereumSetting != null) {
      _ethereumSlippageController.text = ethereumSetting.slippage.toString();
      _ethereumGasPriceController.text = ethereumSetting.gasPrice ?? '';
    }

    if (bnbSetting != null) {
      _bnbSlippageController.text = bnbSetting.slippage.toString();
      _bnbGasPriceController.text = bnbSetting.gasPrice ?? '';
    }

    if (baseSetting != null) {
      _baseSlippageController.text = baseSetting.slippage.toString();
      _baseGasPriceController.text = baseSetting.gasPrice ?? '';
    }
  }

  void _setupListeners() {
    _solanaSlippageController.addListener(() {
      if (_solanaSlippageController.text.trim().isNotEmpty) {
        context.read<TradeSettingCubit>().updateSlippage(
          int.parse(_solanaSlippageController.text),
        );
      }
    });

    _solanaPriorityFeeController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .getCurrentTradeCustomSetting();
      final updated = current.copyWith(
        priorityFee: _solanaPriorityFeeController.text,
      );
      context.read<TradeSettingCubit>().updateCustomSetting(updated);
    });

    _solanaTipFeeController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .getCurrentTradeCustomSetting();
      final updated = current.copyWith(tipFee: _solanaTipFeeController.text);
      context.read<TradeSettingCubit>().updateCustomSetting(updated);
    });

    _ethereumSlippageController.addListener(() {
      context.read<TradeSettingCubit>().updateSlippage(
        int.parse(_ethereumSlippageController.text),
      );
    });

    _ethereumGasPriceController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .getCurrentTradeCustomSetting();
      final updated = current.copyWith(
        gasPrice: _ethereumGasPriceController.text,
      );
      context.read<TradeSettingCubit>().updateCustomSetting(updated);
    });

    _bnbSlippageController.addListener(() {
      context.read<TradeSettingCubit>().updateSlippage(
        int.parse(_bnbSlippageController.text),
      );
    });

    _bnbGasPriceController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .getCurrentTradeCustomSetting();
      final updated = current.copyWith(gasPrice: _bnbGasPriceController.text);
      context.read<TradeSettingCubit>().updateCustomSetting(updated);
    });

    _baseSlippageController.addListener(() {
      context.read<TradeSettingCubit>().updateSlippage(
        int.parse(_baseSlippageController.text),
      );
    });

    _baseGasPriceController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .getCurrentTradeCustomSetting();
      final updated = current.copyWith(gasPrice: _baseGasPriceController.text);
      context.read<TradeSettingCubit>().updateCustomSetting(updated);
    });
  }

  final decimalFormatter = FilteringTextInputFormatter.allow(RegExp("[0-9.]"));
  final integerFormatter = InputFormatters.numberInputFormatters();

  @override
  void dispose() {
    _solanaSlippageController.dispose();
    _solanaPriorityFeeController.dispose();
    _solanaTipFeeController.dispose();
    _solanaMevProtectController.dispose();
    _ethereumSlippageController.dispose();
    _ethereumGasPriceController.dispose();
    _bnbSlippageController.dispose();
    _bnbGasPriceController.dispose();
    _baseSlippageController.dispose();
    _baseGasPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeSettingCubit, TradeSettingState>(
      builder: (context, state) {
        _updateControllersFromState(state);
        return Column(
          spacing: 10.h,
          children: [
            TradeModeCard(
              isSelected: state.mode == TradeMode.fast,
              onTap: () {
                context.read<TradeSettingCubit>().updateTradeMode(
                  TradeMode.fast,
                );
              },
              modeIcon: "assets/lottie/cowboy-gun.lottie",
              modeTitle: S.of(context).fastMode,
              modeDescription: S.of(context).fastModeDesc,
            ),
            TradeModeCard(
              isSelected: state.mode == TradeMode.normal,
              onTap: () {
                context.read<TradeSettingCubit>().updateTradeMode(
                  TradeMode.normal,
                );
              },
              modeIcon: "assets/lottie/cowboy-cycling.lottie",
              modeTitle: S.of(context).normalMode,
              modeDescription: S.of(context).normalModeDesc,
            ),
            _buildCustomSettings(context),
          ],
        );
      },
    );
  }

  Widget _buildCustomSettings(BuildContext context) {
    return BlocSelector<TradeCubit, TradeState, String>(
      selector: (state) => state.fromToken?.network.toString() ?? '',
      builder: (context, state) {
        return Column(
          children: [
            if (state.toLowerCase() == Network.solana.value)
              _buildCustomSolanaSetting(context),
            if (state.toLowerCase() == Network.eth.value)
              _buildCustomEthereumSetting(context),
            if (state.toLowerCase() == Network.bsc.value)
              _buildCustomBnbSetting(context),
            if (state.toLowerCase() == Network.base.value)
              _buildBaseSetting(context),
          ],
        );
      },
    );
  }

  Widget _buildCustomSolanaSetting(BuildContext context) {
    final liveData = context.read<TradeSettingCubit>().state.liveData;
    return CustomSettingCard(
      onTap: () {
        context.read<TradeSettingCubit>().updateTradeMode(TradeMode.custom);
      },
      isSelected:
          context.read<TradeSettingCubit>().state.mode == TradeMode.custom,
      title: S.of(context).customTrade('Solana'),
      subtitle: S.of(context).customTradeDesc,
      children: [
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: "%",
            controller: _solanaSlippageController,
            formatters: integerFormatter,
          ),
          title: _buildTitle(context: context, title: S.of(context).slippage),
        ),
        _buildGridItem(
          context: context,
          control: BlocBuilder<TradeSettingCubit, TradeSettingState>(
            builder: (context, state) {
              final solanaSetting = state.customSettings["solana"];
              return Container(
                height: 35.h,
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: solanaSetting?.mevProtect ?? false,
                  onChanged: (value) {
                    context.read<TradeSettingCubit>().updateMevProtect(value);
                  },
                ),
              );
            },
          ),
          title: _buildTitle(context: context, title: S.of(context).mevProtect),
        ),
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: "SOL",
            controller: _solanaPriorityFeeController,
            formatters: [decimalFormatter],
          ),
          bottom: _buildRealTime(context, value: liveData.priorityFee),
          title: _buildTitle(
            context: context,
            title: S.of(context).priorityFee,
          ),
        ),
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: "SOL",
            controller: _solanaTipFeeController,
            formatters: [decimalFormatter],
          ),
          bottom: _buildRealTime(context, value: liveData.tipFee),
          title: _buildTitle(context: context, title: S.of(context).bribeFee),
        ),
      ],
    );
  }

  Widget _buildRealTime(BuildContext context, {String? value}) {
    final liveDataStatus = context
        .read<TradeSettingCubit>()
        .state
        .liveDataStatus;

    return Row(
      children: [
        Text(
          S.of(context).liveAverage,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textSecondary(context),
          ),
        ),
        liveDataStatus.maybeWhen(
          orElse: () => TextSkeleton(width: 20.w, height: 12.h),
          success: (data) => Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                value ?? '',
                maxLines: 1,
                style: TextStyle(fontSize: 12.sp, color: AppColors.quaternary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomEthereumSetting(BuildContext context) {
    final liveData = context.read<TradeSettingCubit>().state.liveData;
    return CustomSettingCard(
      onTap: () {
        context.read<TradeSettingCubit>().updateTradeMode(TradeMode.custom);
      },
      isSelected:
          context.read<TradeSettingCubit>().state.mode == TradeMode.custom,
      title: S.of(context).customTrade('Ethereum'),
      subtitle: S.of(context).customTradeDesc,
      children: [
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: "%",
            controller: _ethereumSlippageController,
            formatters: integerFormatter,
          ),
          title: _buildTitle(context: context, title: S.of(context).slippage),
        ),
        _buildGridItem(
          context: context,
          control: BlocBuilder<TradeSettingCubit, TradeSettingState>(
            builder: (context, state) {
              final ethereumSetting = state.customSettings["eth"];
              return Container(
                height: 35.h,
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: ethereumSetting?.mevProtect ?? false,
                  onChanged: (value) {
                    context.read<TradeSettingCubit>().updateMevProtect(value);
                  },
                ),
              );
            },
          ),
          title: _buildTitle(context: context, title: S.of(context).mevProtect),
        ),
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: " ",
            controller: _ethereumGasPriceController,
            formatters: [decimalFormatter],
          ),
          bottom: _buildRealTime(context, value: liveData.gasPrice),
          title: _buildTitle(
            context: context,
            title: "Gas",
            subtitle: S.of(context).liveAverage,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomBnbSetting(BuildContext context) {
    final liveData = context.read<TradeSettingCubit>().state.liveData;

    return CustomSettingCard(
      onTap: () {
        context.read<TradeSettingCubit>().updateTradeMode(TradeMode.custom);
      },
      isSelected:
          context.read<TradeSettingCubit>().state.mode == TradeMode.custom,
      title: S.of(context).customTrade('BNB Chain'),
      subtitle: S.of(context).customTradeDesc,
      children: [
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: "%",
            controller: _bnbSlippageController,
            formatters: integerFormatter,
          ),
          title: _buildTitle(context: context, title: S.of(context).slippage),
        ),
        _buildGridItem(
          context: context,
          control: BlocBuilder<TradeSettingCubit, TradeSettingState>(
            builder: (context, state) {
              final bnbSetting = state.customSettings["bsc"];
              return Container(
                height: 35.h,
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: bnbSetting?.mevProtect ?? false,
                  onChanged: (value) {
                    context.read<TradeSettingCubit>().updateMevProtect(value);
                  },
                ),
              );
            },
          ),
          title: _buildTitle(context: context, title: S.of(context).mevProtect),
        ),
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: " ",
            controller: _bnbGasPriceController,
            formatters: [decimalFormatter],
          ),
          bottom: _buildRealTime(context, value: liveData.gasPrice),
          title: _buildTitle(
            context: context,
            title: "Gas",
            subtitle: S.of(context).liveAverage,
          ),
        ),
      ],
    );
  }

  Widget _buildBaseSetting(BuildContext context) {
    final liveData = context.read<TradeSettingCubit>().state.liveData;
    return CustomSettingCard(
      title: S.of(context).customTrade('Base'),
      subtitle: S.of(context).customTradeDesc,
      onTap: () {
        context.read<TradeSettingCubit>().updateTradeMode(TradeMode.custom);
      },
      isSelected:
          context.read<TradeSettingCubit>().state.mode == TradeMode.custom,
      children: [
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: "%",
            controller: _baseSlippageController,
            formatters: integerFormatter,
          ),
          title: _buildTitle(context: context, title: S.of(context).slippage),
        ),
        _buildGridItem(
          context: context,
          control: const SizedBox.shrink(),
          title: _buildTitle(context: context, title: ""),
        ),
        _buildGridItem(
          context: context,
          control: _buildInput(
            context,
            suffixText: " ",
            controller: _baseGasPriceController,
            formatters: [decimalFormatter],
          ),
          bottom: _buildRealTime(context, value: liveData.gasPrice),
          title: _buildTitle(
            context: context,
            title: "Gas",
            subtitle: S.of(context).liveAverage,
          ),
        ),
      ],
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
      mainAxisSize: MainAxisSize.min, // ：Column
      spacing: 6.h,
      children: [
        // title != null ? title : Text(title, style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary(context)),) : SizedBox.shrink(),
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
              fontSize: 14.sp,
              color: AppColors.textPrimary(context),
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            subtitle ?? '',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(
    BuildContext context, {
    String? suffixText,
    String? hintText = "",
    TextEditingController? controller,
    List<TextInputFormatter>? formatters,
  }) {
    final suffixWidth = suffixText != "%" ? 40.w : 10.w;

    return SizedBox(
      height: 35.h,
      child: TextField(
        controller: controller,
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
                  fontSize: 16,
                  color: AppColors.textPrimary(context),
                ),
              ),
            ),
          ),
          suffixIconConstraints: BoxConstraints(minWidth: 10.w, maxWidth: 40.w),
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
              color: AppColors.textQuaternary(context),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

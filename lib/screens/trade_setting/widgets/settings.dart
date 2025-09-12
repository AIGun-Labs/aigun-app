import 'package:decimal/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/config/chain.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_cubit.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/custom_setting_card.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/mode_card.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsColumn extends StatefulWidget {
  SettingsColumn({Key? key}) : super(key: key);

  @override
  _SettingsColumnState createState() => _SettingsColumnState();
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

    // 初始化 TextEditingController
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

    // 从 cubit 获取初始值并设置到 controller
    final state = context.read<TradeSettingCubit>().state;
    _updateControllersFromState(state);

    // 添加监听器来更新 cubit
    _setupListeners();
  }

  // 从状态更新所有 controllers 的值
  void _updateControllersFromState(TradeSettingState state) {
    final solanaSetting =
        state.customSettings[ChainConfig.chainIdMap['solana']];
    final ethereumSetting = state.customSettings[ChainConfig.chainIdMap['eth']];
    final bnbSetting = state.customSettings[ChainConfig.chainIdMap['bsc']];
    final baseSetting = state.customSettings[ChainConfig.chainIdMap['base']];

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

  // 设置所有 TextField 的监听器
  void _setupListeners() {
    _solanaSlippageController.addListener(() {
      context.read<TradeSettingCubit>().updateSlippage(
          ChainConfig.chainIdMap['solana'],
          int.parse(_solanaSlippageController.text));
    });

    _solanaPriorityFeeController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .state
          .customSettings[ChainConfig.chainIdMap['solana']];
      if (current != null) {
        final updated =
            current.copyWith(priorityFee: _solanaPriorityFeeController.text);
        context
            .read<TradeSettingCubit>()
            .updateCustomSetting(ChainConfig.chainIdMap['solana'], updated);
      }
    });

    _solanaTipFeeController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .state
          .customSettings[ChainConfig.chainIdMap['solana']];
      if (current != null) {
        final updated = current.copyWith(tipFee: _solanaTipFeeController.text);
        context
            .read<TradeSettingCubit>()
            .updateCustomSetting(ChainConfig.chainIdMap['solana'], updated);
      }
    });

    _ethereumSlippageController.addListener(() {
      context.read<TradeSettingCubit>().updateSlippage(
          ChainConfig.chainIdMap['eth'],
          int.parse(_ethereumSlippageController.text));
    });

    _ethereumGasPriceController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .state
          .customSettings[ChainConfig.chainIdMap['eth']];
      if (current != null) {
        final updated =
            current.copyWith(gasPrice: _ethereumGasPriceController.text);
        context
            .read<TradeSettingCubit>()
            .updateCustomSetting(ChainConfig.chainIdMap['eth'], updated);
      }
    });

    _bnbSlippageController.addListener(() {
      context.read<TradeSettingCubit>().updateSlippage(
          ChainConfig.chainIdMap['bsc'],
          int.parse(_bnbSlippageController.text));
    });

    _bnbGasPriceController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .state
          .customSettings[ChainConfig.chainIdMap['bsc']];
      if (current != null) {
        final updated = current.copyWith(gasPrice: _bnbGasPriceController.text);
        context
            .read<TradeSettingCubit>()
            .updateCustomSetting(ChainConfig.chainIdMap['bsc'], updated);
      }
    });

    _baseSlippageController.addListener(() {
      context.read<TradeSettingCubit>().updateSlippage(
          ChainConfig.chainIdMap['base'],
          int.parse(_baseSlippageController.text));
    });

    _baseGasPriceController.addListener(() {
      final current = context
          .read<TradeSettingCubit>()
          .state
          .customSettings[ChainConfig.chainIdMap['base']];
      if (current != null) {
        final updated =
            current.copyWith(gasPrice: _baseGasPriceController.text);
        context
            .read<TradeSettingCubit>()
            .updateCustomSetting(ChainConfig.chainIdMap['base'], updated);
      }
    });
  }

  final decimalFormatter = FilteringTextInputFormatter.allow(RegExp("[0-9.]"));
  final integerFormatter = FilteringTextInputFormatter.allow(RegExp("[0-9]"));

  @override
  void dispose() {
    // 清理所有 TextEditingController
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
      // 当状态改变时更新 controllers
      _updateControllersFromState(state);
      return Column(
        spacing: 10.h,
        children: [
          TradeModeCard(
              isSelected: state.mode == TradeMode.fast,
              onTap: () {
                context
                    .read<TradeSettingCubit>()
                    .updateTradeMode(TradeMode.fast);
              },
              modeIcon: "assets/images/icons/lightning.png",
              modeTitle: S.of(context).fastMode,
              modeDescription: S.of(context).fastModeDesc),
          TradeModeCard(
              isSelected: state.mode == TradeMode.normal,
              onTap: () {
                context
                    .read<TradeSettingCubit>()
                    .updateTradeMode(TradeMode.normal);
              },
              modeIcon: "assets/images/icons/gentle-mode.png",
              modeTitle: S.of(context).normalMode,
              modeDescription: S.of(context).normalModeDesc),
          // CustomSettingCard(children: []),
          // CustomSettingCard(children: []),
          // CustomSettingCard(children: [])
          _buildCustomSolanaSetting(context),
          _buildCustomEthereumSetting(context),
          _buildCustomBnbSetting(context),
          _buildBaseSetting(context),
        ],
      );
    });
  }

  Widget _buildCustomSolanaSetting(BuildContext context) {
    return CustomSettingCard(
      title: S.of(context).customTrade('solana'),
      subtitle: S.of(context).customTradeDesc,
      children: [
        _buildGridItem(
          context: context,
          control: _buildInput(context,
              suffixText: "%",
              controller: _solanaSlippageController,
              formatters: [integerFormatter]),
          title: _buildTitle(context: context, title: S.of(context).slippage),
        ),
        _buildGridItem(
            context: context,
            control: BlocBuilder<TradeSettingCubit, TradeSettingState>(
              builder: (context, state) {
                final solanaSetting =
                    state.customSettings[ChainConfig.chainIdMap['solana']];
                return Switch(
                  value: solanaSetting?.mevProtect ?? false,
                  onChanged: (value) {
                    context.read<TradeSettingCubit>().updateMevProtect(
                        ChainConfig.chainIdMap['solana'], value);
                  },
                );
              },
            ),
            title:
                _buildTitle(context: context, title: S.of(context).mevProtect)),
        _buildGridItem(
            context: context,
            control: _buildInput(context,
                suffixText: "SOL",
                controller: _solanaPriorityFeeController,
                formatters: [decimalFormatter]),
            title: _buildTitle(
                context: context, title: S.of(context).priorityFee)),
        _buildGridItem(
            context: context,
            control: _buildInput(context,
                suffixText: "SOL",
                controller: _solanaTipFeeController,
                formatters: [decimalFormatter]),
            title:
                _buildTitle(context: context, title: S.of(context).bribeFee)),
      ],
    );
  }

  Widget _buildCustomEthereumSetting(BuildContext context) {
    return CustomSettingCard(
        title: S.of(context).customTrade('Ethereum'),
        subtitle: S.of(context).customTradeDesc,
        children: [
          _buildGridItem(
            context: context,
            control: _buildInput(context,
                suffixText: "%",
                controller: _ethereumSlippageController,
                formatters: [integerFormatter]),
            title: _buildTitle(context: context, title: S.of(context).slippage),
          ),
          _buildGridItem(
              context: context,
              control: BlocBuilder<TradeSettingCubit, TradeSettingState>(
                builder: (context, state) {
                  final ethereumSetting =
                      state.customSettings[ChainConfig.chainIdMap['eth']];
                  return Switch(
                    value: ethereumSetting?.mevProtect ?? false,
                    onChanged: (value) {
                      context.read<TradeSettingCubit>().updateMevProtect(
                          ChainConfig.chainIdMap['eth'], value);
                    },
                  );
                },
              ),
              title: _buildTitle(
                  context: context, title: S.of(context).mevProtect)),
          _buildGridItem(
              context: context,
              control: _buildInput(context,
                  suffixText: " ",
                  controller: _ethereumGasPriceController,
                  formatters: [decimalFormatter]),
              title: _buildTitle(
                  context: context,
                  title: "Gas",
                  subtitle: S.of(context).liveAverage)),
        ]);
  }

  Widget _buildCustomBnbSetting(BuildContext context) {
    return CustomSettingCard(
        title: S.of(context).customTrade('BNB Chain'),
        subtitle: S.of(context).customTradeDesc,
        children: [
          _buildGridItem(
              context: context,
              control: _buildInput(context,
                  suffixText: "%",
                  controller: _bnbSlippageController,
                  formatters: [integerFormatter]),
              title:
                  _buildTitle(context: context, title: S.of(context).slippage)),
          _buildGridItem(
              context: context,
              control: BlocBuilder<TradeSettingCubit, TradeSettingState>(
                builder: (context, state) {
                  final bnbSetting =
                      state.customSettings[ChainConfig.chainIdMap['bsc']];
                  return Switch(
                    value: bnbSetting?.mevProtect ?? false,
                    onChanged: (value) {
                      context.read<TradeSettingCubit>().updateMevProtect(
                          ChainConfig.chainIdMap['bsc'], value);
                    },
                  );
                },
              ),
              title: _buildTitle(
                  context: context, title: S.of(context).mevProtect)),
          _buildGridItem(
              context: context,
              control: _buildInput(context,
                  suffixText: " ",
                  controller: _bnbGasPriceController,
                  formatters: [decimalFormatter]),
              title: _buildTitle(
                  context: context,
                  title: "Gas",
                  subtitle: S.of(context).liveAverage)),
        ]);
  }

  Widget _buildBaseSetting(BuildContext context) {
    return CustomSettingCard(
        title: S.of(context).customTrade('Base'),
        subtitle: S.of(context).customTradeDesc,
        children: [
          _buildGridItem(
              context: context,
              control: _buildInput(context,
                  suffixText: "%",
                  controller: _baseSlippageController,
                  formatters: [integerFormatter]),
              title:
                  _buildTitle(context: context, title: S.of(context).slippage)),
          _buildGridItem(
              context: context,
              control: const SizedBox.shrink(),
              title: _buildTitle(context: context, title: "")),
          _buildGridItem(
              context: context,
              control: _buildInput(context,
                  suffixText: " ",
                  controller: _baseGasPriceController,
                  formatters: [decimalFormatter]),
              title: _buildTitle(
                  context: context,
                  title: "Gas",
                  subtitle: S.of(context).liveAverage)),
        ]);
  }

  Widget _buildGridItem({
    required BuildContext context,
    required Widget control,
    Widget? title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // 关键：让Column根据内容自适应高度
      spacing: 6.h,
      children: [
        // title != null ? title : Text(title, style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary(context)),) : SizedBox.shrink(),
        title ?? const SizedBox.shrink(), control,
      ],
    );
  }

  Widget _buildTitle(
      {required BuildContext context,
      required String title,
      String? subtitle}) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: title,
        style:
            TextStyle(fontSize: 16.sp, color: AppColors.textPrimary(context)),
      ),
      const TextSpan(text: " "),
      TextSpan(
          text: subtitle,
          style: TextStyle(
              fontSize: 12.sp, color: AppColors.textSecondary(context)))
    ]));
  }

  Widget _buildInput(BuildContext context,
      {String? suffixText,
      String? hintText = "",
      TextEditingController? controller,
      List<TextInputFormatter>? formatters}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: formatters,
      decoration:
          _buildInputDecoration(context, suffixText, hintText: hintText),
    );
  }

  InputDecoration _buildInputDecoration(
      BuildContext context, String? suffixText,
      {String? hintText = ""}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle:
          TextStyle(fontSize: 16.sp, color: AppColors.textTertiary(context)),
      // 后缀文本和样式 - 使用 suffix 确保一直显示
      suffix: suffixText != null
          ? Text(
              suffixText,
              style: TextStyle(
                  fontSize: 16, color: AppColors.textPrimary(context)),
            )
          : null,

      // 内容内边距，让输入框看起来更紧凑
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      // 边框样式
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),

      // 启用状态下的边框
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      // 聚焦时（用户正在输入时）的边框
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/mode_card.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/custom_setting_card.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TradeSettingScreen extends StatelessWidget {
  const TradeSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonCustomAppBar(
        title: '交易设置',
        leading: IconButton(
            onPressed: () {
              context.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10.h,
            children: [
              TradeModeCard(
                  modeIcon: "assets/images/icons/lightning.png",
                  modeTitle: "Lightning Mode",
                  modeDescription:
                      "适用于追求快速交易的用户，特别是价格波动大、竞争激烈的Meme币交易，通过AI智能设置滑点和费率，加速交易抢占先机。闪电模式上链手续费稍高。"),
              TradeModeCard(
                  modeIcon: "assets/images/icons/gentle-mode.png",
                  modeTitle: "Lightning Mode",
                  modeDescription:
                      "适用于追求快速交易的用户，特别是价格波动大、竞争激烈的Meme币交易，通过AI智能设置滑点和费率，加速交易抢占先机。闪电模式上链手续费稍高。"),
              // CustomSettingCard(children: []),
              // CustomSettingCard(children: []),
              // CustomSettingCard(children: [])
              _buildCustomSolanaSetting(context),
              _buildCustomEthereumSetting(context),
              _buildCustomBnbSetting(context),
              _buildCustomSetting(context),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildCustomSolanaSetting(BuildContext context) {
    return CustomSettingCard(
      title: "自定义Solana交易",
      subtitle: "适合经验丰富的老手",
      children: [
        _buildGridItem(
          context: context,
          control: _buildInput(context, "%"),
          title: _buildTitle(context: context, title: "滑点"),
        ),
        _buildGridItem(
            context: context,
            control: Switch(value: true, onChanged: (value) {}),
            title: _buildTitle(context: context, title: "防夹功能")),
        _buildGridItem(
            context: context,
            control: _buildInput(context, "SOL"),
            title: _buildTitle(context: context, title: "优先费")),
        _buildGridItem(
            context: context,
            control: _buildInput(context, "SOL"),
            title: _buildTitle(context: context, title: "贿赂费")),
      ],
    );
  }

  Widget _buildCustomEthereumSetting(BuildContext context) {
    return CustomSettingCard(
        title: "自定义Ethereum交易",
        subtitle: "适合经验丰富的老手",
        children: [
          _buildGridItem(
            context: context,
            control: _buildInput(context, "%"),
            title: _buildTitle(context: context, title: "滑点"),
          ),
          _buildGridItem(
              context: context,
              control: Switch(value: true, onChanged: (value) {}),
              title: _buildTitle(context: context, title: "防夹功能")),
          _buildGridItem(
              context: context,
              control: _buildInput(context, "%"),
              title: _buildTitle(
                  context: context, title: "Gas", subtitle: "实时平均为 5")),
        ]);
  }

  Widget _buildCustomBnbSetting(BuildContext context) {
    return CustomSettingCard(
        title: "自定义BNB Chain交易",
        subtitle: "适合经验丰富的老手",
        children: [
          _buildGridItem(
              context: context,
              control: _buildInput(context, "%"),
              title: _buildTitle(context: context, title: "滑点")),
          _buildGridItem(
              context: context,
              control: Switch(value: true, onChanged: (value) {}),
              title: _buildTitle(context: context, title: "防夹功能")),
          _buildGridItem(
              context: context,
              control: _buildInput(context, "%"),
              title: _buildTitle(
                  context: context, title: "Gas", subtitle: "实时平均为 5")),
        ]);
  }

  Widget _buildCustomSetting(BuildContext context) {
    return CustomSettingCard(
        title: "自定义Base交易",
        subtitle: "适合经验丰富的老手",
        children: [
          _buildGridItem(
              context: context,
              control: _buildInput(context, "%"),
              title: _buildTitle(context: context, title: "滑点")),
          _buildGridItem(
              context: context,
              control: const SizedBox.shrink(),
              title: _buildTitle(context: context, title: "")),
          _buildGridItem(
              context: context,
              control: _buildInput(context, ""),
              title: _buildTitle(
                  context: context, title: "Gas", subtitle: "实时平均为 5")),
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

  Widget _buildInput(BuildContext context, String? suffixText) {
    return TextField(
      decoration: _buildInputDecoration(context, suffixText),
    );
  }

  InputDecoration _buildInputDecoration(
      BuildContext context, String? suffixText) {
    return InputDecoration(
      hintText: "1.0",
      hintStyle:
          TextStyle(fontSize: 16.sp, color: AppColors.textQuinary(context)),
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

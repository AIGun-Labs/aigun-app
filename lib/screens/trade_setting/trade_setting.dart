import 'package:flutter/material.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/mode_card.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/custom_setting_card.dart';
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
              CustomSettingCard(),
              CustomSettingCard(),
              CustomSettingCard()
            ],
          ),
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/settings.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        actions: [
          // IconButton(
          //     onPressed: () {
          //       context.read<TradeSettingCubit>().resetAll();
          //     },
          //     icon: const Icon(Icons.refresh)
          // )
          // TODO：测试使用后续删除
          TextButton(
              onPressed: () {
                context.read<TradeSettingCubit>().resetAll();
              },
              child: Text('重置(测试)',
                  style: TextStyle(
                      color: AppColors.textPrimary(context), fontSize: 16.sp)))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingsColumn(),
        ),
      )),
    );
  }
}

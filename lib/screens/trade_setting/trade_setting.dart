import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/settings.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TradeSettingScreen extends StatelessWidget {
  const TradeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            context.read<TradeSettingCubit>().updateTradeConfig();
          }
        },
        child: Scaffold(
          appBar: CommonCustomAppBar(
            title: S.of(context).tradeSetting,
            leading: IconButton(
                onPressed: () {
                  context.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: const SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SettingsColumn(),
            ),
          )),
        ));
  }
}

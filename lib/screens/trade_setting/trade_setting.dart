import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/index.dart';
import '../../l10n/l10n.dart';
import '../../widgets/appbar.dart';
import 'widgets/settings.dart';

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
                  context.pop();
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

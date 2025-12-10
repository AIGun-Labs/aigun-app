import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/index.dart';
import '../../l10n/l10n.dart';
import '../../shared/presentation/widgets/appbar_widget.dart';
import 'widgets/settings.dart';

class TradeSettingScreen extends StatefulWidget {
  const TradeSettingScreen({super.key});

  @override
  State<TradeSettingScreen> createState() => _TradeSettingScreenState();
}

class _TradeSettingScreenState extends State<TradeSettingScreen> {
  late final TradeSettingCubit _tradeSettingCubit;

  @override
  void initState() {
    super.initState();

    _tradeSettingCubit = BlocProvider.of<TradeSettingCubit>(context)
      ..startPollingLiveData();
  }

  @override
  void dispose() {
    _tradeSettingCubit
      ..stopPollingLiveData()
      ..updateTradeConfig();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: S.of(context).tradeSetting),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(8.0), child: SettingsColumn()),
        ),
      ),
    );
  }
}

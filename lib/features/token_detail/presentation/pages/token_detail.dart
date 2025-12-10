import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../cubits/index.dart';
import '../../../../shared/domain/entities/base_token_entity.dart';
import '../widgets/ai_intel_view.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/market_view.dart';
import '../widgets/risk_tab_content.dart';
import '../widgets/trade_buttons.dart';

class TokenDetailScreen extends StatefulWidget {
  const TokenDetailScreen({
    super.key,
    required this.token,
    required this.type,
    this.tokenType,
  });
  final BaseTokenEntity token;
  final String type;
  final String? tokenType;

  @override
  State<TokenDetailScreen> createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends State<TokenDetailScreen> {
  late TradeCubit _tradeCubit;
  late BalanceCubit _balanceCubit;

  @override
  void initState() {
    super.initState();
    _tradeCubit = BlocProvider.of<TradeCubit>(context);
    _balanceCubit = BlocProvider.of<BalanceCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _tradeCubit.resumeTimers();
      _balanceCubit.startPollingBalance();
    });
  }

  @override
  void dispose() {
    _tradeCubit.pauseTimers();
    _balanceCubit.stopPollingBalance();
    super.dispose();
  }

  @override
  void didUpdateWidget(TokenDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.token.address != widget.token.address ||
        oldWidget.token.network != widget.token.network) {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 40.w),
          child: AppBarWidget(token: widget.token),
        ),
        body: TabBarView(
          children: [
            MarketView(type: widget.type),
            const AIIntelView(),
            const RiskTabContent(),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 8.w, left: 16.w, right: 16.w),
            child: const TradeButtons(),
          ),
        ),
      ),
    );
  }
}

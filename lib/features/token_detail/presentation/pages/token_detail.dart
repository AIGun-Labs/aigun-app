import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/candle/candle_cubit.dart';
import '../../../../cubits/index.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../cubits/holdings/holdings_cubit.dart';
import '../cubits/intels/intels_cubit.dart';
import '../cubits/token_info/token_info_cubit.dart';
import '../cubits/token_security/token_security_cubit.dart';
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
  final TokenEntity token;
  final String type;
  final String? tokenType;

  @override
  State<TokenDetailScreen> createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends State<TokenDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<TradeCubit>(context).resumeTimers();
      BlocProvider.of<BalanceCubit>(context).startPollingBalance();
    });
  }

  @override
  void dispose() {
    BlocProvider.of<TradeCubit>(context).pauseTimers();
    BlocProvider.of<BalanceCubit>(context).stopPollingBalance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<TokenInfoCubit>()
                  ..init(token: widget.token, type: widget.tokenType),
          ),
          BlocProvider(
            create: (context) => getIt<IntelsCubit>()
              ..init(
                address: widget.token.address,
                network: widget.token.network,
              ),
          ),
          BlocProvider(
            create: (context) => getIt<TokenSecurityCubit>()
              ..getTokenSecurity(
                address: widget.token.address,
                network: widget.token.network,
              ),
          ),
        ],
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + 40.h),
            child: AppBarWidget(token: widget.token),
          ),
          body: TabBarView(
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<HoldingsCubit>()
                      ..startPolling(
                        address: widget.token.address,
                        network: widget.token.network,
                      ),
                  ),
                  BlocProvider(
                    create: (context) =>
                        getIt<CandleCubit>(
                          param1: BlocProvider.of<TokenInfoCubit>(context),
                        )..loadData(
                          network: widget.token.network,
                          address: widget.token.address,
                        ),
                  ),
                ],
                child: MarketView(type: widget.type),
              ),
              const AIIntelView(),
              const RiskTabContent(),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
              child: const TradeButtons(),
            ),
          ),
        ),
      ),
    );
  }
}

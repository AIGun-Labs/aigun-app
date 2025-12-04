import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/index.dart';
import '../../../../cubits/token_detail/token_detail_state.dart';
import '../../../../screens/token_detail/widgets/ai_tab_content.dart';
import '../../../../screens/token_detail/widgets/risk_tab_content.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../../../../utils/toast/trade_status_toast.dart';
import '../cubits/holdings/holdings_cubit.dart';
import '../cubits/intels/intels_cubit.dart';
import '../cubits/latest_intel/latest_intel_cubit.dart';
import '../cubits/token_info/token_info_cubit.dart';
import '../cubits/token_security/token_security_cubit.dart';
import '../cubits/urls/urls_cubit.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/market_view.dart';
import '../widgets/trade_buttons.dart';

class TokenDetailScreen extends StatefulWidget {
  const TokenDetailScreen({super.key, required this.token, required this.type});
  final TokenEntity token;
  final String type;

  @override
  State<TokenDetailScreen> createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends State<TokenDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = widget.token;
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
          return VisibilityDetector(
            key: const Key('token_detail_screen'),
            onVisibilityChanged: (visibilityInfo) {
              if (_isDisposed) return;

              // 只在完全可见或完全不可见时处理，忽略动画中间状态
              if (visibilityInfo.visibleFraction == 1.0) {
                context.read<TradeCubit>().resumeTimers();
                context.read<BalanceCubit>().startPollingBalance();
              } else if (visibilityInfo.visibleFraction == 0.0) {
                Future.delayed(const Duration(seconds: 1), () {
                  TradeStatusToastUtils.dismissToast();
                });
                context.read<TradeCubit>().pauseTimers();
                context.read<BalanceCubit>().stopPollingBalance();
              }
            },
            child: BlocProvider(
              create: (context) => getIt<TokenInfoCubit>()
                ..setToken(token)
                ..startPolling(address: token.address, network: token.network),
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight + 40.h),
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => getIt<IntelsCubit>()
                          ..getIntelCount(
                            address: token.address,
                            network: token.network,
                          ),
                      ),
                      BlocProvider(
                        create: (context) => getIt<TokenSecurityCubit>()
                          ..getTokenSecurity(
                            address: token.address,
                            network: token.network,
                          ),
                      ),
                    ],
                    child: AppBarWidget(token: token),
                  ),
                ),
                body: TabBarView(
                  children: [
                    MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => getIt<LatestIntelCubit>()
                            ..startPolling(
                              address: token.address,
                              network: token.network,
                            ),
                        ),
                        BlocProvider(
                          create: (context) => getIt<UrlsCubit>()
                            ..fetchUrls(
                              address: token.address,
                              network: token.network,
                            ),
                        ),
                        BlocProvider(
                          create: (context) => getIt<HoldingsCubit>()
                            ..startPolling(
                              address: token.address,
                              network: token.network,
                            ),
                        ),
                      ],
                      child: MarketView(type: widget.type),
                    ),
                    const AITabContent(),
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
        },
      ),
    );
  }
}

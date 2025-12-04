import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/candle/candle_cubit.dart';
import '../../../../cubits/index.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../../../../utils/toast/trade_status_toast.dart';
import '../cubits/holdings/holdings_cubit.dart';
import '../cubits/intels/intels_cubit.dart';
import '../cubits/latest_intel/latest_intel_cubit.dart';
import '../cubits/token_info/token_info_cubit.dart';
import '../cubits/token_security/token_security_cubit.dart';
import '../cubits/urls/urls_cubit.dart';
import '../widgets/ai_intel_view.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/market_view.dart';
import '../widgets/risk_tab_content.dart';
import '../widgets/trade_buttons.dart';

class TokenDetailScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: VisibilityDetector(
        key: const Key('token_detail_screen'),
        onVisibilityChanged: (visibilityInfo) {
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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<TokenInfoCubit>()
                ..setToken(token)
                ..startPolling(
                  address: token.address,
                  network: token.network,
                  type: tokenType,
                ),
            ),
            BlocProvider(
              create: (context) => getIt<IntelsCubit>()
                ..getIntelCount(address: token.address, network: token.network)
                ..getIntels(),
            ),
            BlocProvider(
              create: (context) => getIt<TokenSecurityCubit>()
                ..getTokenSecurity(
                  address: token.address,
                  network: token.network,
                ),
            ),
          ],
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight + 40.h),
              child: AppBarWidget(token: token),
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
                    BlocProvider(
                      create: (context) =>
                          getIt<CandleCubit>(
                            param1: BlocProvider.of<TokenInfoCubit>(context),
                          )..loadData(
                            network: token.network,
                            address: token.address,
                          ),
                    ),
                  ],
                  child: MarketView(type: type),
                ),
                const AIIntelView(),
                BlocProvider(
                  create: (context) => getIt<TokenSecurityCubit>()
                    ..getTokenSecurity(
                      address: token.address,
                      network: token.network,
                    ),
                  child: const RiskTabContent(),
                ),
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
      ),
    );
  }
}

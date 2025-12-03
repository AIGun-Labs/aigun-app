import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/index.dart';
import '../../../../cubits/token_detail/token_detail_state.dart';
import '../../../../screens/token_detail/widgets/ai_tab_content.dart';
import '../../../../screens/token_detail/widgets/risk_tab_content.dart';
import '../../../../screens/token_detail/widgets/trade_buttons.dart';
import '../../../../shared/domain/entities/token_entity.dart';
import '../../../../utils/toast/trade_status_toast.dart';
import '../cubits/token_info/token_info_cubit.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/market_view.dart';

class TokenDetailScreen extends StatefulWidget {
  const TokenDetailScreen({super.key});

  @override
  State<TokenDetailScreen> createState() => _TokenDetailScreenState();
}

class _TokenDetailScreenState extends State<TokenDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();

    _refreshTokenData();
  }

  void _refreshTokenData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TokenDetailCubit>().loadData();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  final token = TokenEntity.example();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<TokenDetailCubit, TokenDetailState>(
        builder: (context, state) {
          return VisibilityDetector(
            key: const Key('token_detail_screen'),
            onVisibilityChanged: (visibilityInfo) {
              if (_isDisposed) return;
              final cubit = context.read<TokenDetailCubit>();
              final isPushed = cubit.state.isPushedToSubPage;

              // 只在完全可见或完全不可见时处理，忽略动画中间状态
              if (visibilityInfo.visibleFraction == 1.0) {
                context.read<TradeCubit>().resumeTimers();
                context.read<BalanceCubit>().startPollingBalance();
                // 从子页面返回时，不重新加载数据
                if (isPushed) {
                  cubit.clearPushToSubPageFlag();
                } else {
                  cubit.loadData();
                }
              } else if (visibilityInfo.visibleFraction == 0.0) {
                Future.delayed(const Duration(seconds: 1), () {
                  TradeStatusToastUtils.dismissToast();
                });

                // push 到子页面时不 reset，真正离开时才 reset
                if (!isPushed) {
                  cubit.resetAll();
                }
                context.read<TradeCubit>().pauseTimers();
                context.read<BalanceCubit>().stopPollingBalance();
              }
            },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight + 40.h),
                child: AppBarWidget(
                  token: token,
                  tokenIntelCount: state.tokenIntelCount,
                  tokenRiskCount: state.tokenRiskCount,
                ),
              ),
              body: TabBarView(
                children: [
                  BlocProvider(
                    create: (context) => getIt<TokenInfoCubit>()
                      ..fetchTokenDetailInfo(
                        address: token.address,
                        network: token.network,
                      ),
                    child: const MarketView(),
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
          );
        },
      ),
    );
  }
}

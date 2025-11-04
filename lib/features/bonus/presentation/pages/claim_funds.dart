import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/error/error_widget.dart';
import 'package:flutter_aigun/widgets/refresh_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/service_locator.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../themes/colors.dart';
import '../cubits/claim_token_cubit.dart';
import '../cubits/claim_token_state.dart';
import '../widgets/claim_funds_header.dart';
import '../widgets/claim_funds_view.dart';
import '../widgets/claim_funds_view_skeleton.dart';

class ClaimFundsScreen extends StatefulWidget {
  const ClaimFundsScreen({super.key});

  @override
  State<ClaimFundsScreen> createState() => _ClaimFundsScreenState();
}

class _ClaimFundsScreenState extends State<ClaimFundsScreen> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    // 初始加载数据
    getIt<ClaimTokenCubit>().getUnclaimedTokens();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  /// 下拉刷新处理
  Future<void> _handleRefresh() async {
    try {
      context.read<ClaimTokenCubit>().getUnclaimedTokens();
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.surface(context),
        appBar: SimpleAppBar(title: S.of(context).claimFunds),
        body: RefreshConfiguration(
          headerTriggerDistance: 84.h,
          springDescription: const SpringDescription(
            mass: 1.2,
            stiffness: 180,
            damping: 32,
          ),
          maxOverScrollExtent: 50.h,
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            header: CustomHeader(
              height: 84.h,
              builder: (BuildContext context, RefreshStatus? mode) {
                return Column(
                  children: [
                    const RefreshLoading(),
                    RefreshText(text: S.of(context).app_title),
                  ],
                );
              },
            ),
            onRefresh: _handleRefresh,
            child: CustomScrollView(
              slivers: <Widget>[
                const ClaimFundsHeader(),
                SliverPadding(
                  padding: EdgeInsets.all(20.w),
                  sliver: BlocBuilder<ClaimTokenCubit, ClaimTokenState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const ClaimFundsViewSkeleton(),
                        loading: () => const ClaimFundsViewSkeleton(),
                        success: (tokens) {
                          return ClaimFundsView(
                            tokens: tokens,
                            onClaim: context.read<ClaimTokenCubit>().claimToken,
                          );
                        },
                        error: (String message) => SliverFillRemaining(
                          child: GlobalErrorWidget(
                            title: S.of(context).error,
                            message: message,
                            onRetry: _handleRefresh,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

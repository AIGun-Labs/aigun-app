import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../l10n/l10n.dart';
import '../../../../shared/presentation/widgets/custom_app_bar.dart';
import '../../../../themes/colors.dart';
import '../../../../widgets/error/error_widget.dart';
import '../../../../widgets/refresh_header.dart';
import '../cubits/claim_token_cubit.dart';
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
  late final ClaimTokenCubit _claimTokenCubit;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _claimTokenCubit = BlocProvider.of<ClaimTokenCubit>(context);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    try {
      await _claimTokenCubit.getUnclaimedTokens();
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
                          onClaim: _claimTokenCubit.claimToken,
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
      ),
    );
  }
}

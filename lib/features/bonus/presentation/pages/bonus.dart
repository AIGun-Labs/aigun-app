import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/router/constants.dart';
import '../../../../l10n/l10n.dart';
import '../../../../widgets/error/error_widget.dart';
import '../../../../widgets/refresh_header.dart';
import '../../../bonus/presentation/cubits/invite_cubit.dart';
import '../cubits/invite_state.dart';
import '../widgets/bonus_view.dart';
import '../widgets/bonus_view_skeleton.dart';
import '../widgets/invite_header.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  late final RefreshController _refreshController;
  late final InviteCubit _inviteCubit;
  @override
  void initState() {
    super.initState();
    _inviteCubit = context.read<InviteCubit>()..refresh();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _inviteCubit.close();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    try {
      await _inviteCubit.refreshInviteInfo();
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
      body: VisibilityDetector(
        key: const Key(RouteNames.bonus),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0) {
            _inviteCubit.refreshInviteInfo();
          }
        },
        child: RefreshConfiguration(
          springDescription: const SpringDescription(
            mass: 1.2,
            stiffness: 180,
            damping: 32,
          ),
          maxOverScrollExtent: 50.h,
          headerTriggerDistance: 84.h,
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
              child: SafeArea(
                child: Column(
                  children: [
                    const InviteHeader(),
                    26.verticalSpace,
                    BlocBuilder<InviteCubit, InviteState>(
                      builder: (context, state) {
                        return state.when(
                            initial: () => const BonusViewSkeleton(),
                            loading: () => const BonusViewSkeleton(),
                            success: (inviteInfo) =>
                                BonusView(inviteInfo: inviteInfo),
                            error: (error) => GlobalErrorWidget(
                                  title: 'Error',
                                  message: error,
                                  onRetry: () {
                                    _inviteCubit.refresh();
                                  },
                                ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

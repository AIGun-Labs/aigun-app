import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/intel/intel_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_item.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/logger.dart';
import 'package:flutter_aigun/widgets/refresh_header.dart';
import 'package:flutter_aigun/widgets/token_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AITabContent extends StatefulWidget {
  const AITabContent({super.key});

  @override
  State<AITabContent> createState() => _AITabContentState();
}

class _AITabContentState extends State<AITabContent> {
  late RefreshController _refreshController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onLoading() async {
    if (!mounted) return;

    try {
      await context.read<TokenDetailCubit>().getTokenAssociatedIntels();

      if (mounted) {
        final state = context.read<TokenDetailCubit>().state;
        if (state.isNotMore) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      }
    } catch (e) {
      Logger.error("reloadAssociatedIntels error: $e");
      if (mounted) {
        _refreshController.loadFailed();
      }
    }
  }

  Future<void> _onRefresh() async {
    if (!mounted) return;

    try {
      await context.read<TokenDetailCubit>().refreshAssociatedIntels();

      if (mounted) {
        _refreshController.refreshCompleted();
      }
    } catch (e) {
      Logger.error("refreshAssociatedIntels error: $e");
      if (mounted) {
        _refreshController.refreshFailed();
      }
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        final isLoading = state.tokenAssociatedIntelsState
            .maybeWhen(orElse: () => false, loading: () => true);

        if (isLoading && state.tokenAssociatedIntels?.isEmpty == true) {
          return ListView(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                color: Colors.white,
                child: const IntelSkeleton(itemCount: 3),
              )
            ],
          );
        }

        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: const ClassicFooter(),
          header: const CustomRefreshHeader(),
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          physics: const AlwaysScrollableScrollPhysics(),
          child: state.tokenAssociatedIntels?.isEmpty == true
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 400.h,
                      child: const Center(child: Text('暂无数据')),
                    ),
                  ],
                )
              : ListView.separated(
                  itemCount: state.tokenAssociatedIntels?.length ?? 0,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: AppColors.card(context),
                      thickness: 10,
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    final intel = state.tokenAssociatedIntels?[index];

                    if (intel == null) {
                      return const SizedBox.shrink();
                    }

                    return IntelMessageItem(intel: intel, index: index);
                  },
                ),
        );
      },
    );
  }
}

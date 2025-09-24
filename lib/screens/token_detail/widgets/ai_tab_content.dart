import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_cubit.dart';
import 'package:flutter_aigun/cubits/token_detail/token_detail_state.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_item.dart';
import 'package:flutter_aigun/screens/intel/widgets/refresh_header.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AITabContent extends StatefulWidget {
  const AITabContent({super.key});

  @override
  State<AITabContent> createState() => _AITabContentState();
}

class _AITabContentState extends State<AITabContent> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future<void> _onLoading() async {
    if(!mounted)return;

    try {
await context.read<TokenDetailCubit>().reloadAssociatedIntels();



    } catch (e) {

    }
  }

  Future<void> _onRefresh() async {
    // 这里可以根据需要实现刷新逻辑
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: const ClassicFooter(),
          header: const CustomRefreshHeader(),
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          physics: const AlwaysScrollableScrollPhysics(),
          child: state.tokenAssociatedIntels.isEmpty == true
              ? ListView(
                  controller: ScrollController(),
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
                  controller: ScrollController(),
                  itemCount: state.tokenAssociatedIntels.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: AppColors.card(context),
                      thickness: 10,
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    final message = state.tokenAssociatedIntels[index];
                    return IntelMessageItem(intel: message, index: index);
                  },
                ),
        );
      },
    );
  }
}

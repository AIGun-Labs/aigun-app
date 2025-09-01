import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/monitor/index.dart';
import '../../../widgets/intel_tab_bar.dart';
import 'add_monitor_button.dart';
import 'intel_x_header.dart';
import 'monitor_list.dart';
import 'set_trade_button.dart';

class IntelXBody extends StatefulWidget {
  const IntelXBody(
      {super.key, required this.monitorGroupList, required this.tabController});
  final List<MonitorGroup> monitorGroupList;
  final TabController tabController;

  @override
  State<IntelXBody> createState() => _IntelXBodyState();
}

class _IntelXBodyState extends State<IntelXBody> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isTabChanging = false;

  @override
  void initState() {
    super.initState();
    widget.tabController.animation?.addListener(_handleTabAnimation);

    // 初始加载第一个标签页的数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.monitorGroupList.isNotEmpty) {
        final groupId = widget.monitorGroupList[widget.tabController.index].id!;
        context.read<MonitorCubit>().setCurrentGroupId(groupId);
      }
    });
  }

  @override
  void dispose() {
    widget.tabController.animation?.removeListener(_handleTabAnimation);
    super.dispose();
  }

  void _handleTabAnimation() {
    final double value = widget.tabController.animation!.value;

    final double distanceFromInteger = (value - value.round()).abs();

    // 当动画值不接近整数时，表示标签页正在切换中
    // 当距离大于0.01且小于0.99时，认为正在切换
    final bool isChanging =
        distanceFromInteger > 0.01 && distanceFromInteger < 0.99;

    if (isChanging != _isTabChanging) {
      setState(() {
        _isTabChanging = isChanging;
      });
    }

    if (!isChanging && value.round() != _currentIndex) {
      _currentIndex = value.round();

      final groupId = widget.monitorGroupList[_currentIndex].id!;
      context.read<MonitorCubit>().setCurrentGroupId(groupId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).intel_xTitle,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.h),
          child: IntelTabBar(
            tabs: widget.monitorGroupList
                .map((e) => e.name ?? S.of(context).wallet_defaultGroup)
                .toList(),
            controller: widget.tabController,
            showMore: true,
            moreIcon: SvgPicture.asset(
              'assets/images/icons/riLine-settings-4-line.svg',
              width: 24.w,
              height: 24.h,
            ),
            onMoreTap: () {
              context.push(Routes.intelXGroup);
            },
          ),
        ),
      ),
      body: TabBarView(
        controller: widget.tabController,
        physics: const ClampingScrollPhysics(),
        children: List.generate(
          widget.monitorGroupList.length,
          (index) => SingleChildScrollView(
            key: PageStorageKey('tab_$index'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const IntelXHeader(),
                MonitorList(
                  key: ValueKey(
                      'monitor_list_${widget.monitorGroupList[index].id}'),
                  groupId: widget.monitorGroupList[index].id!,
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          child: Row(
            children: [
              Expanded(child: SetTradeButton()),
              SizedBox(width: 10.w),
              Expanded(
                child: AddMonitorButton(
                  disabled: _isTabChanging,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

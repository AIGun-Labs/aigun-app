import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../cubits/index.dart';
import '../../features/home/presentation/pages/home.dart';
import '../../l10n/l10n.dart';
import '../../themes/themes.dart';
import 'widgets/event_handler_intel_list.dart';
import 'widgets/intel_search_bar.dart';
import 'widgets/signal_intel_list.dart.dart';
import 'widgets/tabbar.dart';

class IntelScreen extends StatefulWidget {
  const IntelScreen({super.key});

  @override
  State<IntelScreen> createState() => _IntelScreenState();
}

class _IntelScreenState extends State<IntelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 在 widget 构建完成后执行

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: VisibilityDetector(
        key: const Key('intel_screen'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0) {
            context.read<IntelCubit>().startPollingTokensByIntelIds();
          } else {
            context.read<IntelCubit>().stopPollingTokensByIntelIds();
          }
        },
        child: ExtendedNestedScrollView(
            onlyOneScrollInBody: false,
            pinnedHeaderSliverHeightBuilder: () => 36.h, // 上拉之后pinned 的高度
            floatHeaderSlivers: true,
            key: const ValueKey('intel'),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: IntelSearchBar(
                      openDrawer: () => HomeScreenState.scaffoldKey.currentState
                          ?.openDrawer()),
                  toolbarHeight: 56.h,
                  backgroundColor: AppColors.background(context),
                  automaticallyImplyLeading: false,
                ),
                SliverPinnedToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    height: 36.h,
                    child: IntelTabbar(
                      tabController: _tabController,
                      tabs: _buildTabs(context)
                          .map((e) => Tab(child: e))
                          .toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: const [
                EventHandlerList(),
                SignalIntelList(),
              ],
            )),
      )),
    );
  }

  List<Widget> _buildTabs(BuildContext context) {
    return [
      IntelTabbarItem(text: S.of(context).recommend),
      IntelTabbarItem(text: S.of(context).chainSingle),
    ];
  }
}

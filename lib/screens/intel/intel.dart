import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../cubits/index.dart';
import '../../l10n/l10n.dart';
import '../../shared/presentation/widgets/sliver_tabbar_delegate.dart';
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
      // appBar: IntelAppBar(
      //   title:
      //       IntelSearchBar(openDrawer: () => Scaffold.of(context).openDrawer()),
      //   tabbar: IntelTabbar(
      //     tabController: _tabController,
      //     tabs: _buildTabs(context).map((e) => Tab(child: e)).toList(),
      //   ),
      // ),
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
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: IntelSearchBar(
                      openDrawer: () => Scaffold.of(context).openDrawer()),
                  floating: true,
                  snap: true,
                  pinned: false,
                  expandedHeight: 56.h,
                  toolbarHeight: 56.h,
                  backgroundColor: AppColors.background(context),
                  automaticallyImplyLeading: false,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                      IntelTabbar(
                        tabController: _tabController,
                        tabs: _buildTabs(context)
                            .map((e) => Tab(child: e))
                            .toList(),
                      ),
                      backgroundColor: AppColors.background(context)),
                ),
                // const SliverToBoxAdapter(
                //   child: IntelUnreadBar(),
                // )
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

// class IntelUnreadBar extends StatelessWidget {
//   const IntelUnreadBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
//       if (state.unreadIds.isNotEmpty) {
//         return GestureDetector(
//           onTap: () {
//             PrimaryScrollController.of(context).animateTo(
//               0.0, // 滚动到顶部
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//             // clear unread ids
//             context.read<IntelCubit>().clearUnreadIds();
//           },
//           child: Padding(
//               padding: EdgeInsets.only(top: 4.h),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.quaternary,
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.arrow_upward,
//                       size: 18.sp,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 2.w),
//                     Text(
//                       S.of(context).newIntel(state.unreadIds.length),
//                       style: TextStyle(fontSize: 14.sp, color: Colors.white),
//                     )
//                   ],
//                 ),
//               )),
//         );
//       }
//       return const SizedBox.shrink();
//     });
//   }
// }

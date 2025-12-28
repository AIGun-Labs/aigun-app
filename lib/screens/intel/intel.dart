import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/intel/intel_cubit.dart';
import '../../l10n/l10n.dart';
import '../../themes/colors.dart';
import 'widgets/choices.dart';
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
  late TabController primaryTC;
  int index = 0;
  double top = 0;
  late final IntelCubit intelCubit = BlocProvider.of<IntelCubit>(context);

  @override
  void initState() {
    super.initState();

    primaryTC = TabController(length: 2, vsync: this);
    // primaryTC.addListener(tabControllerListenner);
  }

  @override
  void dispose() {
    // primaryTC.removeListener(tabControllerListenner);
    super.dispose();
  }

  // void tabControllerListenner() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: _onNotification,
        child: Stack(
          children: [
            Positioned(
              top: top,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 56.w,
                    color: AppColors.background(context),
                    child: IntelSearchBar(
                      openDrawer: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                  SizedBox(
                    height: 36.w,
                    child: IntelTabbar(
                      tabController: primaryTC,
                      tabs: [
                        IntelTabbarItem(text: S.of(context).recommend),
                        IntelTabbarItem(text: S.of(context).chainSingle),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: primaryTC,
                      children: [
                        EventHandlerList(
                          pageStorageKey: PageStorageKey('event_handler_list'),
                        ),
                        Column(
                          children: [
                            SingleTypeChoices(),
                            Expanded(
                              child: SignalIntelList(
                                pageStorageKey: PageStorageKey(
                                  'signal_intel_list',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification.depth == 1) {
      if (notification is ScrollUpdateNotification) {
        if (notification.metrics.pixels < 0 &&
            (notification.scrollDelta ?? 0) > 0) {
          return false;
        }

        final double temp = (top - notification.scrollDelta!).clamp(-56.w, 0.0);
        if (temp != top) {
          setState(() {
            top = temp;
          });
        }

        _updateUnreadBarVisibility(notification.metrics.pixels);
      } else if (notification is OverscrollNotification) {
        final double temp = (top - notification.overscroll).clamp(-56.w, 0.0);
        if (temp != top) {
          setState(() {
            top = temp;
          });
        }
      } else if (notification is ScrollEndNotification) {
        _updateUnreadBarVisibility(notification.metrics.pixels);
      }
    }
    return false;
  }

  void _updateUnreadBarVisibility(double scrollPosition) {
    final showUnreadBar = intelCubit.state.showUnreadBar;

    if (scrollPosition > 300 && !showUnreadBar) {
      intelCubit.updateShowUnreadBar(true);
    } else if (scrollPosition <= 300 && showUnreadBar) {
      intelCubit.updateShowUnreadBar(false);
    }
  }
}

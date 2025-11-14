import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/services/permissions_service.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/intel/widgets/appbar.dart';
import 'package:flutter_aigun/screens/intel/widgets/event_handler_intel_list.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_list.dart';
import 'package:flutter_aigun/screens/intel/widgets/signal_intel_list.dart.dart';
import 'package:flutter_aigun/screens/intel/widgets/tabbar.dart';
import 'package:flutter_aigun/screens/intel/widgets/top_header.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visibility_detector/visibility_detector.dart';

class IntelScreen extends StatefulWidget {
  const IntelScreen({super.key});

  @override
  State<IntelScreen> createState() => _IntelScreenState();
}

class _IntelScreenState extends State<IntelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _showUnreadBar = false;

  @override
  void initState() {
    super.initState();
    // 在 widget 构建完成后执行

    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

// 当前滚动位置
    final currentScroll = _scrollController.position.pixels;

    // 如果当前滚动位置大于500，则显示未读条
    if (currentScroll >= 500) {
      setState(() {
        _showUnreadBar = true;
      });
    } else {
      // 如果当前滚动位置小于500，则隐藏未读条
      setState(() {
        _showUnreadBar = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IntelAppBar(
        tabbar: IntelTabbar(
          tabController: _tabController,
          tabs: _buildTabs(context).map((e) => Tab(child: e)).toList(),
        ),
      ),
      body: SafeArea(
          child: VisibilityDetector(
        key: const Key("intel_screen"),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0) {
            context.read<IntelCubit>().startPollingTokensByIntelIds();
          } else {
            context.read<IntelCubit>().stopPollingTokensByIntelIds();
          }
        },
        child: TabBarView(
          controller: _tabController,
          children: const [
            EventHandlerList(),
            SignalIntelList(),
          ],
        ),
      )),
    );
  }

  List<Widget> _buildTabs(BuildContext context) {
    return [
      IntelTabbarItem(text: S.of(context).recommend),
      IntelTabbarItem(text: S.of(context).chain_single),
    ];
  }
}

class IntelUnreadBar extends StatelessWidget {
  const IntelUnreadBar({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      if (state.unreadIds.isNotEmpty) {
        return GestureDetector(
          onTap: () {
            scrollController.animateTo(
              0.0, // 滚动到顶部
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // clear unread ids
            context.read<IntelCubit>().clearUnreadIds();
          },
          child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.quaternary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      S.of(context).newIntel(state.unreadIds.length),
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    )
                  ],
                ),
              )),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/ai_agent/ai_agent_cubit.dart';
import 'package:flutter_aigun/screens/trending/widgets/ai_agent.dart';
import 'package:flutter_aigun/screens/trending/widgets/hot_spot.dart';
import 'package:flutter_aigun/screens/trending/widgets/tab_bar.dart';
import 'package:flutter_aigun/screens/trending/widgets/trend.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/widgets/navbar/user_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with TickerProviderStateMixin {
  TrendingTabBarController? _tabBarController;
  late final ValueNotifier<double> _shrinkRatioNotifier;

  @override
  void initState() {
    super.initState();
    _shrinkRatioNotifier = ValueNotifier<double>(0.0);
  }

  @override
  void dispose() {
    _shrinkRatioNotifier.dispose();
    super.dispose();
  }

  void _onTabBarCreated(TrendingTabBarController controller) {
    _tabBarController = controller;
    _shrinkRatioNotifier.addListener(() {
      _tabBarController?.updateShrinkRatio(_shrinkRatioNotifier.value);
    });
  }

  void _updateTabBarShrink(double shrinkRatio) {
    if (_shrinkRatioNotifier.value != shrinkRatio) {
      _shrinkRatioNotifier.value = shrinkRatio;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.shimmerBaseColor(context),
        appBar: AppBar(
          titleSpacing: 20.w,
          automaticallyImplyLeading: false,
          title: NavbarUserSearch(openDrawer: () {}),
          backgroundColor: AppColors.background(context),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(62.h),
              child: TrendingTabBarDelegate(
                minHeight: 40.h,
                maxHeight: 62.h,
                onTabBarCreated: _onTabBarCreated,
              )),
          shadowColor: AppColors.foreground(context).withValues(alpha: 0.3),
          elevation: 8,
        ),
        body: BlocProvider(
          create: (context) => AiAgentCubit(),
          child: ExtendedTabBarView(
              shouldIgnorePointerWhenScrolling: false,
              children: [
                HotSpotPage(onScrollUpdate: _updateTabBarShrink),
                AiAgentPage(onScrollUpdate: _updateTabBarShrink),
                const TrendPage(),
              ]),
        ),
      ),
    );
  }
}

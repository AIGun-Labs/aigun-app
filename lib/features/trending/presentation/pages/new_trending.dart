import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../shared/presentation/widgets/sliver_tabbar_delegate.dart';
import '../../../../themes/colors.dart';
import '../../../collect/presentation/widgets/collect_tokens_view.dart';
import '../../../home/presentation/pages/home.dart';
import '../cubits/hot_token_cubit.dart';
import '../cubits/top_token_cubit.dart';
import '../widgets/hot_tokens_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/tabbar_header.dart';
import '../widgets/top_tokens_view.dart';

///TODO: 待优化
class NewTrendingScreen extends StatefulWidget {
  const NewTrendingScreen({super.key});

  @override
  State<NewTrendingScreen> createState() => _NewTrendingScreenState();
}

class _NewTrendingScreenState extends State<NewTrendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // 1. 搜索栏
              SliverAppBar(
                title: TrendingSearchBar(
                    openDrawer: () =>
                        HomeScreenState.scaffoldKey.currentState?.openDrawer()),
                floating: true,
                snap: true,
                pinned: false,
                expandedHeight: 56.h,
                toolbarHeight: 56.h,
                backgroundColor: AppColors.background(context),
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  PreferredSize(
                    preferredSize: Size.fromHeight(30.h),
                    child: SizedBox(
                      height: 46.h, //防止溢出
                      child: const TabbarHeader(),
                    ),
                  ),
                  backgroundColor: AppColors.background(context),
                ),
              ),
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            ];
          },
          body: TabBarView(
            children: [
              const CollectTokensView(),
              BlocProvider(
                create: (context) => getIt<TopTokenCubit>(),
                child: const TopTokensView(),
              ),
              BlocProvider(
                create: (context) => getIt<HotTokenCubit>(),
                child: const HotTokensView(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

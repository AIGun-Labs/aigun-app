import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../widgets/collection_view.dart';
import '../widgets/hot_token_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/top_pick_list.dart';

///TODO: 待优化
class NewTrendingScreen extends StatefulWidget {
  const NewTrendingScreen({super.key});

  @override
  State<NewTrendingScreen> createState() => _NewTrendingScreenState();
}

class _NewTrendingScreenState extends State<NewTrendingScreen> {
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 20.w,
      automaticallyImplyLeading: false,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.h),
        child: TrendingSearchBar(
            openDrawer: () => Scaffold.of(context).openDrawer()),
      ),
      backgroundColor: AppColors.background(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorWeight: 0,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  dividerColor: AppColors.border(context),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.h,
                      color: AppColors.textPrimary(context),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textPrimary(context),
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary(context),
                    fontWeight: FontWeight.w400,
                  ),
                  tabs: [
                    Tab(text: S.of(context).tracking),
                    Tab(text: S.of(context).topPick),
                    Tab(text: S.of(context).hot)
                  ]),
              const Expanded(
                child: TabBarView(
                  children: [
                    CollectionView(),
                    TopPickList(),
                    HotTokenView(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../themes/colors.dart';
import '../../../collect/presentation/widgets/collect_tokens_view.dart';
import '../widgets/hot_tokens_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/tabbar_header.dart';
import '../widgets/top_tokens_view.dart';

class NewTrendingScreen extends StatelessWidget {
  const NewTrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: ExtendedNestedScrollView(
          floatHeaderSlivers: true,
          onlyOneScrollInBody: true,
          pinnedHeaderSliverHeightBuilder: () => 36.w,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // 1. 搜索栏
              SliverAppBar(
                title: TrendingSearchBar(
                  openDrawer: () => Scaffold.maybeOf(context)?.openDrawer(),
                ),
                toolbarHeight: 56.w,
                backgroundColor: AppColors.background(context),
                automaticallyImplyLeading: false,
              ),
              SliverPinnedToBoxAdapter(
                child: SizedBox(
                  height: 36.w, //防止溢出
                  child: const TabbarHeader(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              const CollectTokensView(
                pageStorageKey: PageStorageKey('collect_tokens_view'),
              ),
              const TopTokensView(
                pageStorageKey: PageStorageKey('top_tokens_view'),
              ),
              const HotTokensView(
                pageStorageKey: PageStorageKey('hot_tokens_view'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

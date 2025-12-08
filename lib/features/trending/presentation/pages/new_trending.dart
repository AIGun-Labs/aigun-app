import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/locale_util.dart';
import '../../../../themes/colors.dart';
import '../../../collect/presentation/widgets/collect_tokens_view.dart';
import '../../../dynamic_tabs/presentation/cubits/dynamic_tabs/dynamic_tabs_cubit.dart';
import '../../../dynamic_tabs/presentation/widgets/top_level_tab_widget.dart';
import '../widgets/hot_tokens_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/top_tokens_view.dart';

class NewTrendingScreen extends StatelessWidget {
  const NewTrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DynamicTabsCubit, DynamicTabsState>(
      builder: (context, state) {
        print('trending tabs: ${state.tabs?.trendingTab}');
        final tabs = state.tabs?.trendingTab;

        if (tabs == null) {
          return const SizedBox.shrink();
        }

        final tabWidgets = tabs
            .map(
              (tab) =>
                  Tab(text: LocaleUtil.getTextByLanguage(context, tab.name)),
            )
            .toList();

        return SafeArea(
          child: DefaultTabController(
            length: tabs.length,
            child: ExtendedNestedScrollView(
              floatHeaderSlivers: true,
              onlyOneScrollInBody: true,
              pinnedHeaderSliverHeightBuilder: () => 36.h,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        titleSpacing: 15.w,
                        title: TrendingSearchBar(
                          openDrawer: () =>
                              Scaffold.maybeOf(context)?.openDrawer(),
                        ),
                        toolbarHeight: 56.w,
                        backgroundColor: AppColors.background(context),
                        automaticallyImplyLeading: false,
                      ),
                      SliverPinnedToBoxAdapter(
                        child: TopLevelTabWidget(tabs: tabWidgets),
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
      },
    );
  }
}

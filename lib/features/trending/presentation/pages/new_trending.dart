import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/utils/locale_util.dart';
import '../../../../themes/colors.dart';
import '../../../collect/presentation/widgets/collect_tokens_view.dart';
import '../../../dynamic_tabs/presentation/cubits/dynamic_tabs/dynamic_tabs_cubit.dart';
import '../../../dynamic_tabs/presentation/widgets/top_level_tab_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/token_list_view.dart';

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

        return DefaultTabController(
          length: tabs.length,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            // onlyOneScrollInBody: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
                  final tabBar = TopLevelTabWidget(tabs: tabWidgets);
                  return <Widget>[
                    SliverAppBar(
                      titleSpacing: 15.w,
                      title: TrendingSearchBar(
                        openDrawer: () =>
                            Scaffold.maybeOf(context)?.openDrawer(),
                      ),
                      toolbarHeight: 56.h,
                      backgroundColor: AppColors.background(context),
                      automaticallyImplyLeading: false,
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(tabBar),
                    ),
                  ];
                },
            body: TabBarView(
              children: tabs.map((tab) {
                if (tab.value == 'tracking') {
                  return CollectTokensView(
                    key: Key('${tab.label}:${tab.value}'),
                  );
                } else {
                  if (tab.type == 'list') {
                    final quertParamters = {tab.label: tab.value};

                    late String? paginationField;

                    if (tab.extra != null &&
                        tab.extra!.paginationConfig != null &&
                        tab.extra!.paginationConfig!.type == 'cursor') {
                      paginationField = tab.extra!.paginationConfig!.field;
                    }

                    return TokenListView(
                      key: Key('${tab.label}:${tab.value}'),
                      queryParameters: quertParamters,
                      paginationField: paginationField,
                      tabs: tab.children,
                    );
                  } else {
                    return Container();
                  }
                }
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const _SliverAppBarDelegate(this.tabBar);

  final PreferredSizeWidget tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.background(context), child: tabBar);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

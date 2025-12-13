import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/service_locator.dart';
import '../../../../shared/utils/locale_util.dart';
import '../../../../themes/colors.dart';
import '../../../collect/presentation/widgets/collect_tokens_view.dart';
import '../../../dynamic_tabs/presentation/cubits/dynamic_tabs/dynamic_tabs_cubit.dart';
import '../../../dynamic_tabs/presentation/widgets/top_level_tab_widget.dart';
import '../cubits/tokens/tokens_cubit.dart';
import '../widgets/search_bar.dart';
import '../widgets/token_grid_view.dart';
import '../widgets/token_list_view.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DynamicTabsCubit, DynamicTabsState>(
      builder: (context, state) {
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

        final topTabBar = TopLevelTabWidget(tabs: tabWidgets);

        return DefaultTabController(
          length: tabs.length,
          child: ExtendedNestedScrollView(
            floatHeaderSlivers: true,
            onlyOneScrollInBody: true,
            pinnedHeaderSliverHeightBuilder: () =>
                topTabBar.preferredSize.height,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                    SliverPinnedToBoxAdapter(child: topTabBar),
                  ];
                },
            body: TabBarView(
              children: tabs.map((tab) {
                final index = tabs.indexOf(tab);

                final key = Key('${tab.label}:${tab.value}');

                if (tab.value == 'tracking') {
                  return CollectTokensView(key: key, index: index);
                } else {
                  final quertParamters = {tab.label: tab.value};

                  if (tab.children != null && tab.children!.isNotEmpty) {
                    quertParamters.addAll({
                      tab.children!.first.label: tab.children!.first.value,
                    });
                  }

                  String? paginationField;

                  if (tab.extra != null &&
                      tab.extra!.paginationConfig != null &&
                      tab.extra!.paginationConfig!.type == 'cursor') {
                    paginationField = tab.extra!.paginationConfig!.field;
                  }

                  return BlocProvider(
                    key: key,
                    create: (context) => getIt<TokensCubit>()
                      ..setParams(
                        queryParameters: quertParamters,
                        paginationField: paginationField,
                      ),
                    child: tab.type == 'list'
                        ? TokenListView(
                            key: key,
                            index: index,
                            tabs: tab.children,
                          )
                        : tab.type == 'grid'
                        ? TokenGridView(
                            key: key,
                            index: index,
                            tabs: tab.children,
                          )
                        : Container(),
                  );
                }
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

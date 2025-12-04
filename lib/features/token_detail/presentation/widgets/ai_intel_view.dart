import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../l10n/l10n.dart';
import '../../../../screens/intel/widgets/intelligence_type/intelligence_classifier.dart';
import '../../../../shared/presentation/widgets/no_data_widget.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/logger.dart';
import '../../../../widgets/refresh_header.dart';
import '../../../../widgets/token_skeleton.dart';
import '../cubits/intels/intels_cubit.dart';

class AIIntelView extends StatefulWidget {
  const AIIntelView({super.key});

  @override
  State<AIIntelView> createState() => _AIIntelViewState();
}

class _AIIntelViewState extends State<AIIntelView>
    with AutomaticKeepAliveClientMixin {
  late RefreshController _refreshController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onLoading() async {
    if (!mounted) return;

    try {
      await context.read<IntelsCubit>().getIntels();

      if (mounted) {
        final state = context.read<IntelsCubit>().state;
        if (state.isNotMore) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
      }
    } catch (e) {
      Logger.error('reloadAssociatedIntels error: $e');
      if (mounted) {
        _refreshController.loadFailed();
      }
    }
  }

  Future<void> _onRefresh() async {
    if (!mounted) return;

    try {
      await context.read<IntelsCubit>().refreshIntels();

      if (mounted) {
        _refreshController.refreshCompleted();
      }
    } catch (e) {
      Logger.error('refreshAssociatedIntels error: $e');
      if (mounted) {
        _refreshController.refreshFailed();
      }
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelsCubit, IntelsState>(
      builder: (context, state) {
        final isLoading =
            state.tokenAssociatedIntelsStatus ==
            TokenAssociatedIntelsStatus.loading;

        if (isLoading && state.intels.isEmpty) {
          return ListView(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                color: Colors.white,
                child: const IntelSkeleton(itemCount: 3),
              ),
            ],
          );
        }

        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: ClassicFooter(
            noDataText: S.of(context).noData,
            loadingText: S.of(context).loading,
          ),
          header: const CustomRefreshHeader(),
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          physics: const AlwaysScrollableScrollPhysics(),
          child: state.intels.isEmpty
              ? const NoIntelDataWidget()
              : ListView.separated(
                  itemCount: state.intels.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: AppColors.card(context),
                      thickness: 10,
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    final intel = state.intels[index];

                    return IntelligenceClassifier(intel: intel, index: index);
                  },
                ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class NoIntelDataWidget extends StatelessWidget {
  const NoIntelDataWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return context.watch<IntelsCubit>().state.tokenAssociatedIntelsStatus ==
            TokenAssociatedIntelsStatus.error
        ? NoDataWidget(
            onRetry: () {
              context.read<IntelsCubit>().refreshIntels();
            },
            errorTextDesc: S.of(context).noReceivedFromServer,
          )
        : NoDataWidget(
            buttonText: S.of(context).refresh,
            onRetry: () {
              context.read<IntelsCubit>().refreshIntels();
            },
            errorTextDesc: S.of(context).noIntelData,
          );
  }
}

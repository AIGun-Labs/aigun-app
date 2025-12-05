import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../cubits/token_detail/token_detail_cubit.dart';
import '../../../cubits/token_detail/token_detail_state.dart';
import '../../../l10n/l10n.dart';
import '../../../themes/colors.dart';
import '../../../utils/logger.dart';
import '../../../widgets/refresh_header.dart';
import '../../../widgets/token_skeleton.dart';
import '../../intel/widgets/intelligence_type/intelligence_classifier.dart';

class AITabContent extends StatefulWidget {
  const AITabContent({super.key});

  @override
  State<AITabContent> createState() => _AITabContentState();
}

class _AITabContentState extends State<AITabContent> {
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
      await context.read<TokenDetailCubit>().getTokenAssociatedIntels();

      if (mounted) {
        final state = context.read<TokenDetailCubit>().state;
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
      await context.read<TokenDetailCubit>().refreshAssociatedIntels();

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
    return BlocBuilder<TokenDetailCubit, TokenDetailState>(
      builder: (context, state) {
        final isLoading = state.tokenAssociatedIntelsState.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );

        if (isLoading && state.tokenAssociatedIntels?.isEmpty == true) {
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
          child: ListView.separated(
            itemCount: state.tokenAssociatedIntels?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: AppColors.card(context),
                thickness: 10,
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              final intel = state.tokenAssociatedIntels?[index];

              if (intel == null) {
                return const SizedBox.shrink();
              }

              return IntelligenceClassifier(intel: intel, index: index);
            },
          ),
        );
      },
    );
  }
}

// class NoIntelDataWidget extends StatelessWidget {
//   const NoIntelDataWidget({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return context.watch<TokenDetailCubit>().state.tokenAssociatedIntelsIsError
//         ? NoDataWidget(
//             onRetry: () {
//               context.read<TokenDetailCubit>().refreshAssociatedIntels();
//             },
//             errorTextDesc: S.of(context).noReceivedFromServer,
//           )
//         : NoDataWidget(
//             buttonText: S.of(context).refresh,
//             onRetry: () {
//               context.read<TokenDetailCubit>().refreshAssociatedIntels();
//             },
//             errorTextDesc: S.of(context).noIntelData,
//           );
//   }
// }

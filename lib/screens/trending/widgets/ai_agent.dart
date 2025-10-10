import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/ai_agent/ai_agent_cubit.dart';
import 'package:flutter_aigun/cubits/ai_agent/ai_agent_state.dart';
import 'package:flutter_aigun/cubits/language/language_cubit.dart';
import 'package:flutter_aigun/cubits/language/language_state.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/widgets/card/agent_desc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import 'push_to_refresh_header.dart';

class AiAgentPage extends StatefulWidget {
  final Function(double)? onScrollUpdate;

  const AiAgentPage({super.key, this.onScrollUpdate});

  @override
  State<AiAgentPage> createState() => _AiAgentPageState();
}

class _AiAgentPageState extends State<AiAgentPage>
    with AutomaticKeepAliveClientMixin {
  double _lastShrinkRatio = -1.0;

  @override
  void initState() {
    super.initState();
    // 初始化时加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AiAgentCubit>().getAiAgents();
    });
  }

  void _onScroll(ScrollNotification notification) {
    if (!mounted || widget.onScrollUpdate == null) return;

    if (notification is ScrollUpdateNotification) {
      final scrollOffset = notification.metrics.pixels;
      final shrinkRatio = (scrollOffset / 100).clamp(0.0, 1.0);

      if ((shrinkRatio - _lastShrinkRatio).abs() > 0.02) {
        _lastShrinkRatio = shrinkRatio;
        widget.onScrollUpdate!(shrinkRatio);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _onScroll(notification);
        return false;
      },
      child: PullToRefreshNotification(
          onRefresh: () async {
            await context.read<AiAgentCubit>().refreshAgents();
            return true;
          },
          maxDragOffset: 110.h,
          child: ExtendedNestedScrollView(
              onlyOneScrollInBody: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    PullToRefreshContainer(
                        (PullToRefreshScrollNotificationInfo? info) {
                      return SliverToBoxAdapter(
                        child: PullToRefreshHeader(info),
                      );
                    }),
                  ],
              body: ExtendedVisibilityDetector(
                  uniqueKey: const Key('ai_agent'),
                  child: BlocBuilder<AiAgentCubit, AiAgentState>(
                      builder: (context, agentState) {
                    return BlocBuilder<LanguageCubit, LanguageState>(
                        builder: (context, languageState) {
                      final currentLanguageCode =
                          languageState.locale.languageCode;

                      return agentState.status.when(
                        initial: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        success: (agents) {
                          if (agents.isEmpty) {
                            return const Center(
                              child: Text('暂无数据'),
                            );
                          }
                          return GridView.builder(
                            padding: EdgeInsets.all(20.w),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 13.w,
                              crossAxisSpacing: 13.w,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: agents.length,
                            itemBuilder: (context, index) {
                              final item = agents[index];
                              return CardAgentDesc(
                                name: currentLanguageCode == 'zh'
                                    ? item.name.zh!
                                    : item.name.en!,
                                avatarPath: ImageUtils.getImageUrl(item.avatar) ?? '',
                                isFollowed: item.isFollowed,
                                desc: currentLanguageCode == 'zh'
                                    ? item.description.zh!
                                    : item.description.en!,
                                onFollowTap: () async {
                                  final wasFollowed = item.isFollowed;
                                  await context
                                      .read<AiAgentCubit>()
                                      .toggleFollowAgent(item);
                                  if (!wasFollowed && context.mounted) {
                                    ToastUtils.showCenterToast(
                                        context, S.of(context).followSuccess);
                                  }
                                },
                              );
                            },
                          );
                        },
                      );
                    });
                  })))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

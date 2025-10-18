import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import '../../../../core/service_locator.dart';
import '../../../../cubits/ai_agent/ai_agent_cubit.dart';
import '../../../../cubits/ai_agent/ai_agent_state.dart';
import '../../../../cubits/language/language_cubit.dart';
import '../../../../cubits/language/language_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../../../../utils/image_utils.dart';
import '../../../../utils/toast.dart';
import '../../../../widgets/card/agent_desc.dart';
import '../../../../widgets/push_to_refresh_header.dart';

class AiAgentScreen extends StatefulWidget {
  const AiAgentScreen({super.key});

  @override
  State<AiAgentScreen> createState() => _AiAgentScreenState();
}

class _AiAgentScreenState extends State<AiAgentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface(context),
      appBar: AppBar(
          centerTitle: true,
          title: Text(S.of(context).aiAgent),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios))),
      body: PullToRefreshNotification(
          onRefresh: () async {
            await getIt<AiAgentCubit>().refreshAgents();
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
                                avatarPath:
                                    ImageUtils.getImageUrl(item.avatar) ?? '',
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
}

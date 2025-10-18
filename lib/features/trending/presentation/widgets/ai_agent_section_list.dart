import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../cubits/ai_agent/ai_agent_cubit.dart';
import '../../../../cubits/ai_agent/ai_agent_state.dart';
import '../../../../cubits/language/language_cubit.dart';
import '../../../../cubits/language/language_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../utils/image_utils.dart';
import '../../../../utils/toast.dart';
import '../../../../widgets/card/agent.dart';

class AiAgentSectionList extends StatelessWidget {
  const AiAgentSectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiAgentCubit, AiAgentState>(
      builder: (context, agentState) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, languageState) {
            final currentLanguageCode = languageState.locale.languageCode;

            return agentState.status.maybeWhen(
              success: (agents) {
                if (agents.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SizedBox(
                  height: 160.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: agents.length,
                    separatorBuilder: (context, index) => SizedBox(width: 14.w),
                    itemBuilder: (context, index) {
                      final agent = agents[index];
                      return CardAgent(
                        name: currentLanguageCode == 'zh'
                            ? agent.name.zh ?? ''
                            : agent.name.en ?? '',
                        avatarPath: ImageUtils.getImageUrl(agent.avatar) ?? '',
                        isFollowed: agent.isFollowed,
                        onFollowTap: () async {
                          final wasFollowed = agent.isFollowed;
                          await context
                              .read<AiAgentCubit>()
                              .toggleFollowAgent(agent);
                          if (!wasFollowed && context.mounted) {
                            ToastUtils.showCenterToast(
                                context, S.of(context).followSuccess);
                          }
                        },
                      );
                    },
                  ),
                );
              },
              orElse: () => SizedBox(
                height: 160.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

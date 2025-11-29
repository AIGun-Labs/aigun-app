import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/intel/intel_state.dart';
import '../../../data/models/options/single_type/single_type.dart';
import '../../../enums/intel_type.dart';
import 'intel_list.dart';
import 'unread_bar.dart';

class SignalIntelList extends StatefulWidget {
  const SignalIntelList({super.key, this.pageStorageKey});

  final Key? pageStorageKey;

  @override
  State<SignalIntelList> createState() => _SignalIntelListState();
}

class _SignalIntelListState extends State<SignalIntelList> {
  final bool _showUnreadBar = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(
      buildWhen: (previous, current) {
        return previous.singleIntelligences != current.singleIntelligences ||
            previous.isFetchingSingleMore != current.isFetchingSingleMore ||
            previous.isNotSingleMore != current.isNotSingleMore ||
            previous.singleId != current.singleId ||
            previous.singleTypeOptions != current.singleTypeOptions;
        // previous.unreadIntels != current.unreadIntels;
      },
      builder: (context, state) {
        final currentSingleId = state.singleId;

        final currentOption = currentSingleId == 'all'
            ? null
            : state.singleTypeOptions.cast<SingleTypeOptions?>().firstWhere(
                  (opt) => opt?.slug == currentSingleId,
                  orElse: () => null,
                );

        return Column(
          children: [
            Expanded(
                child: IntelList(
              scrollKey: widget.pageStorageKey,
              intelligences: state.singleIntelligences,
              visibleIds: state.visibleIds,
              isLoading: state.isFetchingSingleMore,
              isNotMore: state.isNotSingleMore,
              onRefresh: () async {
                await context.read<IntelCubit>().refreshSingleIntelligence();
              },
              onLoad: () {
                context
                    .read<IntelCubit>()
                    .getSingleIntelligence(state.singleId);
              },
            )),
            if (_showUnreadBar)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: IntelUnreadBar(
                    scrollController: PrimaryScrollController.of(context),
                    filter: (intel) {
                      if (intel.type != IntelType.radarSignal.name) {
                        return false;
                      }

                      if (currentSingleId == 'all') return true;
                      if (currentOption == null ||
                          currentOption.pushFilter == null) {
                        return false;
                      }
                      return intel.aiAgent?.name?['en'] ==
                          currentOption.pushFilter;
                    },
                  ),
                ),
              )
          ],
        );

        // return Container(
        //   color: AppColors.card(context),
        //   child: Stack(
        //     children: [
        //       NotificationListener(
        //           onNotification: _handleScrollNotification,
        //           child: IntelList(
        //             scrollKey: widget.pageStorageKey,
        //             intelligences: state.singleIntelligences,
        //             visibleIds: state.visibleIds,
        //             isLoading: state.isFetchingSingleMore,
        //             isNotMore: state.isNotSingleMore,
        //             onRefresh: () async {
        //               await context
        //                   .read<IntelCubit>()
        //                   .refreshSingleIntelligence();
        //             },
        //             onLoad: () {
        //               context
        //                   .read<IntelCubit>()
        //                   .getSingleIntelligence(state.singleId);
        //             },
        //             header: const SliverPinnedToBoxAdapter(
        //               child: SingleTypeChoices(),
        //             ),
        //           )),
        //       if (_showUnreadBar)
        //         Positioned(
        //           top: 0,
        //           left: 0,
        //           right: 0,
        //           child: Center(
        //             child: IntelUnreadBar(
        //               scrollController: PrimaryScrollController.of(context),
        //               filter: (intel) {
        //                 //                           if (intel.type != IntelType.radarSignal.name) {
        //                 //                             return false;
        //                 //                           }

        //                 //                           if (currentSingleId == 'all') return true;

        //                 // // 根据 singleTypeOptions 查找对应的 pushFilter
        //                 //                           final option = state.singleTypeOptions
        //                 //                               .cast<SingleTypeOptions?>()
        //                 //                               .firstWhere(
        //                 //                                 (opt) => opt?.slug == currentSingleId,
        //                 //                                 orElse: () => null,
        //                 //                               );

        //                 //                           // 如果找不到或 pushFilter 为空，则不显示
        //                 //                           if (option == null || option.pushFilter == null) {
        //                 //                             return false;
        //                 //                           }

        //                 //                           // 判断 aiAgent name 是否匹配
        //                 //                           return intel.aiAgent?.name?['en'] ==
        //                 //                               option.pushFilter;
        //                 if (intel.type != IntelType.radarSignal.name) {
        //                   return false;
        //                 }

        //                 if (currentSingleId == 'all') return true;
        //                 if (currentOption == null ||
        //                     currentOption.pushFilter == null) {
        //                   return false;
        //                 }
        //                 return intel.aiAgent?.name?['en'] ==
        //                     currentOption.pushFilter;
        //               },
        //             ),
        //           ),
        //         )
        //     ],
        //   ),
        // );
      },
    );
  }
}

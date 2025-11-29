import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/intel/intel_state.dart';
import '../../../data/models/options/single_type/single_type.dart';
import '../../../enums/intel_type.dart';
import 'intel_list.dart';

class SignalIntelList extends StatefulWidget {
  const SignalIntelList({super.key, this.pageStorageKey, this.showUnreadBar});

  final Key? pageStorageKey;
  final bool? showUnreadBar;

  @override
  State<SignalIntelList> createState() => _SignalIntelListState();
}

class _SignalIntelListState extends State<SignalIntelList> {
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

        return IntelList(
          scrollKey: widget.pageStorageKey,
          intelligences: state.singleIntelligences,
          visibleIds: state.visibleIds,
          isLoading: state.isFetchingSingleMore,
          isNotMore: state.isNotSingleMore,
          onRefresh: () async {
            await context.read<IntelCubit>().refreshSingleIntelligence();
          },
          unreadBarFilter: (intel) {
            if (intel.type != IntelType.radarSignal.name) {
              return false;
            }

            if (currentSingleId == 'all') return true;
            if (currentOption == null || currentOption.pushFilter == null) {
              return false;
            }
            return intel.aiAgent?.name?['en'] == currentOption.pushFilter;
          },
          onLoad: () {
            context.read<IntelCubit>().getSingleIntelligence(state.singleId);
          },
        );
      },
    );
  }
}

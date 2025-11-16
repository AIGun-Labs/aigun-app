import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubits/intel/intel_cubit.dart';
import '../../../cubits/intel/intel_state.dart';
import '../../../cubits/options/option_cubit.dart';
import '../../../l10n/l10n.dart';
import '../../../shared/widgets/multiple_choice.dart';
import '../../../themes/themes.dart';
import '../intel.dart';
import 'intel_list.dart';

class SignalIntelList extends StatefulWidget {
  const SignalIntelList({super.key});

  @override
  State<SignalIntelList> createState() => _SignalIntelListState();
}

class _SignalIntelListState extends State<SignalIntelList> {
  late ScrollController _scrollController;
  bool _showUnreadBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    // 当前滚动位置
    final currentScroll = _scrollController.position.pixels;

    // 如果当前滚动位置大于500，则显示未读条
    if (currentScroll >= 500) {
      if (!_showUnreadBar) {
        setState(() {
          _showUnreadBar = true;
        });
      }
    } else {
      // 如果当前滚动位置小于500，则隐藏未读条
      if (_showUnreadBar) {
        setState(() {
          _showUnreadBar = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(
      builder: (context, state) {
        return Column(
          children: [
            _buildSignTypeChoice(context),
            Expanded(
              child: Container(
                color: AppColors.card(context),
                child: Stack(
                  children: [
                    IntelList(
                      scrollController: _scrollController,
                      intelligences: state.singleIntelligences,
                      visibleIds: state.visibleIds,
                      isLoading: state.isFetchingSingleMore,
                      isNotMore: state.isNotSingleMore,
                      onRefresh: () {
                        context.read<IntelCubit>().refreshSingleIntelligence();
                      },
                      onLoad: () {
                        context
                            .read<IntelCubit>()
                            .getSingleIntelligence(state.singleId);
                      },
                    ),
                    if (_showUnreadBar)
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: IntelUnreadBar(
                            scrollController: _scrollController,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildSignTypeChoice(BuildContext context) {
    final singleTypeChoices =
        context.watch<OptionsCubit>().state.singleTypeChoices();
    final selectedId = context.watch<IntelCubit>().state.singleId;
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      return ExpandableScrollableWrap(
          spacing: 6.w,
          padding:
              EdgeInsetsGeometry.symmetric(horizontal: 12.w, vertical: 6.h),
          selectedValue: selectedId,
          onSelected: (value) {
            if (state.isFetchingSingleMore) {
              return;
            }
            context.read<IntelCubit>().updateSingleId(value);
          },
          items: [
            ChoiceItem(label: S.of(context).all, value: 'all'),
            ...singleTypeChoices
          ]);
    });
  }
}

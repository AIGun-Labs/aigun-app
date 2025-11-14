import 'package:flutter/material.dart';
import 'package:flutter_aigun/screens/intel/intel.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_list.dart';
import 'package:flutter_aigun/themes/themes.dart';

class EventHandlerList extends StatelessWidget {
  const EventHandlerList(
      {super.key, required this.scrollController, required this.showUnreadBar});
  final ScrollController scrollController;
  final bool showUnreadBar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // LatestDiscoveriesSection(scrollController: _scrollController),
        Expanded(
          child: Container(
            color: AppColors.card(context),
            child: Stack(
              children: [
                IntelList(scrollController: scrollController),
                if (showUnreadBar)
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: IntelUnreadBar(scrollController: scrollController),
                    ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}

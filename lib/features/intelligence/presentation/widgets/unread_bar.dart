import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';
import '../cubits/intelligence/intelligence_cubit.dart';
import '../cubits/intelligence/intelligence_state.dart';
import '../cubits/unread/unread_cubit.dart';
import '../cubits/unread/unread_state.dart';

/// Unread Bar Widget
///
/// Displays a floating bar showing the count of unread intelligence items.
/// Uses nested BlocBuilder to listen to both IntelligenceCubit (for tab state)
/// and UnreadCubit (for unread items state).
class UnreadBarWidget extends StatelessWidget {
  const UnreadBarWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Nested BlocBuilder pattern for multiple cubits
    return BlocBuilder<IntelligenceCubit, IntelligenceState>(
      buildWhen: (previous, current) =>
          previous.activeTabIndex != current.activeTabIndex,
      builder: (context, intelligenceState) {
        return BlocBuilder<UnreadCubit, UnreadState>(
          buildWhen: (previous, current) =>
              previous.showUnreadBar != current.showUnreadBar ||
              previous.unreadItems != current.unreadItems,
          builder: (context, unreadState) {
            if (!unreadState.showUnreadBar || !unreadState.hasUnread) {
              return const SizedBox.shrink();
            }

            final count = intelligenceState.isEventsTab
                ? unreadState.unreadEventCount
                : unreadState.unreadSignalCount;

            if (count <= 0) {
              return const SizedBox.shrink();
            }

            // Adjust top position based on tab (signals tab has extra chain filter header)
            final topOffset = intelligenceState.isSignalsTab ? 100.w : 56.w;

            return Positioned(
              top: topOffset,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.quaternary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_upward,
                            size: 18.sp, color: Colors.white),
                        SizedBox(width: 2.w),
                        Text(
                          S.of(context).newIntel(count),
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

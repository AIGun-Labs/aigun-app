import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/intel/intel_cubit.dart';
import '../../cubits/intel/intel_state.dart';
import '../../l10n/l10n.dart';
import '../../themes/themes.dart';

class IntelUnreadBar extends StatelessWidget {
  const IntelUnreadBar({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntelCubit, IntelState>(builder: (context, state) {
      if (state.unreadIds.isNotEmpty) {
        return GestureDetector(
          onTap: () {
            scrollController.animateTo(
              0.0, // 滚动到顶部
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // clear unread ids
            context.read<IntelCubit>().clearUnreadIds();
          },
          child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.quaternary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      S.of(context).newIntel(state.unreadIds.length),
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    )
                  ],
                ),
              )),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

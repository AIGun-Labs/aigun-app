import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/l10n.dart';
import '../../../../themes/colors.dart';

class HotTokenFilterHeader extends StatelessWidget {
  final String selectedNetwork;
  final Map<String, String> networks;
  final ValueChanged<String> onNetworkSelected;
  const HotTokenFilterHeader(
      {super.key,
      required this.selectedNetwork,
      required this.networks,
      required this.onNetworkSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background(context),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          spacing: 8.w,
          children: networks.entries.map((e) {
            final isSelected = selectedNetwork == e.value;
            return GestureDetector(
              onTap: () => onNetworkSelected(e.value),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.foreground(context)
                      : AppColors.quinary,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  e.key.toLowerCase() == 'all'
                      ? S.of(context).allNetwork
                      : e.key,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.background(context)
                        : AppColors.foreground(context),
                    fontSize: 12.sp,
                    height: 1.2.h,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

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
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 8.h,
        children: networks.entries.map((e) {
          final isSelected = selectedNetwork == e.value;
          return SizedBox(
              height: 28.h,
              child: TextButton(
                onPressed: () => onNetworkSelected(e.value),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    isSelected
                        ? AppColors.foreground(context)
                        : AppColors.quinary,
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    isSelected
                        ? AppColors.background(context)
                        : AppColors.foreground(context),
                  ),
                  textStyle: WidgetStateProperty.all(
                      TextStyle(fontSize: 14.sp, height: 1.1.h)),
                ),
                child: Text(
                  e.key.toLowerCase() == 'all'
                      ? S.of(context).allNetwork
                      : e.key,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isSelected
                        ? AppColors.background(context)
                        : AppColors.foreground(context),
                  ),
                ),
              ));
        }).toList(),
      ),
    );
  }
}

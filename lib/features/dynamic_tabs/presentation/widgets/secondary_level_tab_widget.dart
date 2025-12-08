import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/presentation/widgets/multiple_choice.dart';

class SecondaryLevelTabWidget extends StatelessWidget {
  final List<ChoiceItem> items;
  final String selectedValue;
  final void Function(String) onSelected;

  const SecondaryLevelTabWidget({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableScrollableWrap(
      spacing: 10.w,
      runSpacing: 10.h,
      backgroundColor: Colors.white,
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 6.h),
      selectedValue: selectedValue,
      onSelected: onSelected,
      items: items,
    );
  }
}

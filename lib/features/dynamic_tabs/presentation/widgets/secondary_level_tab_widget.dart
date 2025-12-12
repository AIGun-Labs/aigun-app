import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/domain/entities/choice_item_entity.dart';
import '../../../../shared/presentation/widgets/multiple_choice.dart';

class SecondaryLevelTabWidget extends StatelessWidget {
  final List<ChoiceItemEntity> items;
  final String selectedValue;
  final void Function(ChoiceItemEntity) onChanged;

  const SecondaryLevelTabWidget({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableScrollableWrap(
      spacing: 10.w,
      runSpacing: 10.h,
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      selectedValue: selectedValue,
      onChanged: onChanged,
      items: items,
    );
  }
}

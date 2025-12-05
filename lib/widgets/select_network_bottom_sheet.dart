import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/l10n.dart';

class SelectNetworkBottomSheet extends StatelessWidget {
  const SelectNetworkBottomSheet({super.key, required this.onSelect});

  final Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return _buildBottomSheet(context);
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          _buildHandle(),
          SizedBox(height: 20.h),
          _buildTitle(context),
          SizedBox(height: 15.h),
          _buildNetworkList(context, onSelect),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(3.r),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).wallet_selectNetwork,
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }

  Widget _buildNetworkList(BuildContext context, Function(String) onSelect) {
    return SizedBox.shrink();
  }
}

void showSelectNetworkBottomSheet(
  BuildContext context,
  Function(String) onSelect,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.90,
        child: SelectNetworkBottomSheet(onSelect: onSelect),
      );
    },
  );
}

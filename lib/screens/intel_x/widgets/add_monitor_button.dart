import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddMonitorButton extends StatelessWidget {
  const AddMonitorButton({super.key, this.disabled = false});
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: disabled
          ? null
          : () {
              context.push(
                Routes.addXMonitor,
              );
            },
      textColor: Colors.white,
      backgroundColor: Colors.black,
      height: 45.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
            weight: 780,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Text(
            S.of(context).intelGroups_intelXGroupAddMonitor,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}

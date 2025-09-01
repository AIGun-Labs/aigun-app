import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetTradeButton extends StatelessWidget {
  const SetTradeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        CustomButton(
          onPressed: () {},
          textColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          height: 45.h,
          child: Row(
            children: [
              SizedBox(width: 80.w),
              Text(
                S.of(context).intelGroups_intelXGroupSetTrade,
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10.w,
          child: Image.asset(
            'assets/images/new-coin.png',
            width: 60.w,
            height: 60.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

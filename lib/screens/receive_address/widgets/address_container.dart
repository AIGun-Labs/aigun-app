import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/index.dart';
import 'package:flutter_aigun/utils/debounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressContainer extends StatelessWidget {
  final String address;

  const AddressContainer({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: Color(0x99BBBBBB)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0.w),
                child: Text(
                  address,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              Divider(
                height: 20.h,
                color: Color(0x99BBBBBB),
              ),
              GestureDetector(
                onTap: () {
                  DebouncerUtils.run(
                    immediate: true,
                    action: () {
                      Clipboard.setData(ClipboardData(text: address)).then((_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S.of(context).ui_copied),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }).catchError((error) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      });
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, 1.h),
                      child: SvgPicture.asset(
                        'assets/images/icons/antOutline-copy.svg',
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      S.of(context).common_copy,
                      style: TextStyle(fontSize: 18.sp, height: 1.2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 304.w),
          child: Text(
            S.of(context).ui_addressWarning,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Color(0xBD101010),
            ),
          ),
        ),
      ],
    );
  }
}

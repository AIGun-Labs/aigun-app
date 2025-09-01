import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntelHeader extends StatelessWidget {
  const IntelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0.w),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 17.5.w,
            backgroundImage: AssetImage('assets/images/token.webp'),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomInput(
              height: 40.h,
              isOutline: true,
              hintText: S.of(context).intel_intelSearch,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0.w,
                vertical: 10.h,
              ),
              fontSize: 12.sp,
              controller: TextEditingController(),
              borderRadius: BorderRadius.circular(20.r),
              prefixIcon: _buildSearchIcon(context),
              suffixIcon: _buildPasteButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchIcon(BuildContext context) {
    return Container(
      width: 28.w,
      height: 16.h,
      margin: EdgeInsets.only(right: 8.w),
      child: SvgPicture.asset(
        'assets/images/icons/icons8-search.svg',
        width: 16.w,
        height: 16.h,
        colorFilter: ColorFilter.mode(
          Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildPasteButton(BuildContext context) {
    return Transform.translate(
      offset: Offset(3.w, 0),
      child: SizedBox(
        width: 50.w,
        height: 25.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            backgroundColor: Color(0xFFE2E2E2).withValues(alpha: .4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            shadowColor: Colors.transparent,
          ),
          onPressed: () {},
          child: Text(
            S.of(context).intel_intelPaste,
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withValues(alpha: 0.63),
            ),
          ),
        ),
      ),
    );
  }
}

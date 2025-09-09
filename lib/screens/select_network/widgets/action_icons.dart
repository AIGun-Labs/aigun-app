import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/receive_address/widgets/qr_code_container.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/debounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionIcons extends StatelessWidget {
  const ActionIcons({super.key, required this.address, required this.name});

  final String address;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIconContainer(
          'assets/images/icons/antOutline-qrcode.svg',
          false,
          context,
          () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Padding(
                    padding: EdgeInsets.only(top: 12.w),
                    child: QrCodeContainer(address: address),
                  ),
                );
              },
            );
          },
        ),
        SizedBox(width: 10.0.w),
        _buildIconContainer(
            'assets/images/icons/antOutline-copy.svg', true, context, () {
          DebouncerUtils.run(
            immediate: true,
            action: () {
              Clipboard.setData(ClipboardData(text: address));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.card(context),
                  content: Text(
                    S.of(context).ui_copied,
                    style: TextStyle(color: AppColors.textPrimary(context)),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildIconContainer(String iconPath, bool isCopyIcon,
      BuildContext context, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0.r),
        splashColor: Colors.grey.withValues(alpha: .5),
        child: Container(
          width: 40.0.w,
          height: 40.0.h,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 20.0.w,
              height: 20.0.h,
            ),
          ),
        ),
      ),
    );
  }
}

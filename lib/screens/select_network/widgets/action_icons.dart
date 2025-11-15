import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../l10n/l10n.dart';
import '../../../utils/debounce.dart';
import '../../../utils/toast.dart';
import '../../receive_address/widgets/qr_code_container.dart';

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
                  contentPadding: EdgeInsets.all(24.w),
                  content: SizedBox(
                    width: 300.w,
                    height: 300.w,
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
            action: () async {
              await Clipboard.setData(ClipboardData(text: address));

              ToastUtils.showCenterToast(context, S.of(context).copySuccess);
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

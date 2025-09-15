import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeContainer extends StatelessWidget {
  final String address;

  const QrCodeContainer({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230.w,
      height: 250.h,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: QrImageView(
          data: address,
          size: 200.w,
          version: QrVersions.auto,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

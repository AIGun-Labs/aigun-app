import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeContainer extends StatelessWidget {
  final String address;
  final double? height;
  final double? width;

  const QrCodeContainer(
      {super.key, required this.address, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: address,
        size: width,
        version: QrVersions.auto,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'widgets/address_container.dart';
import 'widgets/network_logo.dart';
import 'widgets/qr_code_container.dart';

class ReceiveAddressScreen extends StatelessWidget {
  const ReceiveAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context).extra as Map<String, dynamic>;
    final networkName = state['chainName'];
    final address = state['address'];
    final chainId = state['chainId'];

    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).ui_receiveAddress),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            NetworkLogo(chainId: chainId.toString()),
            SizedBox(height: 20.h),
            QrCodeContainer(address: address),
            SizedBox(height: 22.h),
            Text(
              S.of(context).ui_yourAddress(networkName),
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(height: 21.h),
            AddressContainer(address: address),
          ],
        ),
      ),
    );
  }
}

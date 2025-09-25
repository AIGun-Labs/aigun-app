import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/receive_address/widgets/qr_code_container.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';
import 'package:flutter_aigun/widgets/token/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ReceiveAddressScreen extends StatelessWidget {
  const ReceiveAddressScreen({
    super.key,
  });

  // final String avatarUrl;
  // final String title;
  // final String symbol;
  // final String name;
  // final String address;

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context).extra as Map<String, dynamic>;

    final avatar = state['avatar'] ?? '';
    final subAvatar = state['subAvatar'] ?? '';
    final title = state['title'] ?? '';
    final symbol = state['symbol'] ?? '';
    final address = state['address'] ?? '';

    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).receive),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              ReceiveTokenAvatar(avatar: avatar, subAvatar: subAvatar),
              SizedBox(height: 16.h),
              ReceiveAddressTitle(title: title),
              SizedBox(height: 16.h),
              ReceiveAddressExplain(symbol: symbol),
              // SizedBox(height: 20.h),
              // NetworkLogo(chainId: chainId.toString()),
              // SizedBox(height: 20.h),
              SizedBox(height: 20.h),
              QrCodeContainer(address: address, height: 202.h, width: 198.w),
              SizedBox(height: 20.h),

              ReceiveAddressContainer(address: state['address'] ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}

class ReceiveAddressContainer extends StatelessWidget {
  const ReceiveAddressContainer({super.key, required this.address});
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border(context)),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              address,
              softWrap: true,
              maxLines: null,
              style: TextStyle(
                  fontSize: 16.sp, color: AppColors.textPrimary(context)),
            ),
          ),
          SizedBox(width: 18.w),
          GestureDetector(
            onTap: () {
              ClipboardUtils.copy(address).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      S.of(context).ui_copied,
                      style: TextStyle(color: AppColors.textPrimary(context)),
                    ),
                    duration: const Duration(seconds: 2),
                    backgroundColor: AppColors.card(context),
                  ),
                );
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.foreground(context),
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              child: Text(
                S.of(context).copy,
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.background(context)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReceiveTokenAvatar extends StatelessWidget {
  const ReceiveTokenAvatar(
      {super.key, required this.avatar, required this.subAvatar});

  final String avatar;
  final String subAvatar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: SmartNetworkImage(url: avatar, width: 80.w, height: 80.h),
        ),
        if (subAvatar.isNotEmpty)
          Positioned(
            right: -(40.w / 2),
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.w),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: SmartNetworkImage(
                    url: subAvatar, width: 40.w, height: 40.h),
              ),
            ),
          )
      ],
    );
  }
}

class ReceiveAddressTitle extends StatelessWidget {
  const ReceiveAddressTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
    );
  }
}

class ReceiveAddressExplain extends StatelessWidget {
  const ReceiveAddressExplain({super.key, required this.symbol});
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildExplainText(context, "这是$symbol网络通用地址"),
        _buildExplainText(context, "仅支持接收$symbol网络资产"),
      ],
    );
  }

  Widget _buildExplainText(BuildContext context, String text) {
    return Text(text,
        style: TextStyle(
            fontSize: 14.sp, color: AppColors.textSecondary(context)));
  }
}

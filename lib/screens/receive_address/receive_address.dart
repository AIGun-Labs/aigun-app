import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/receive_address/widgets/qr_code_container.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/utils/clipboard.dart';
import 'package:flutter_aigun/utils/image_utils.dart';
import 'package:flutter_aigun/utils/toast.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/feature_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ReceiveAddressScreen extends StatelessWidget {
  const ReceiveAddressScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> state = {};
    try {
      state = GoRouterState.of(context).extra as Map<String, dynamic>;
    } catch (e) {
      debugPrint('GoRouterState.of failed in ReceiveAddressScreen: $e');
    }

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

              if (address.isNotEmpty) ReceiveAddressContainer(address: address),
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
                ToastUtils.showCenterToast(context, S.of(context).copySuccess);
              }).catchError((error) {
                ToastUtils.showCenterToast(context, error.toString());
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
      clipBehavior: Clip.none, // 解决子组件被裁剪的问题
      children: [
        ClipOval(
          child: FeatureImage(
              url: ImageUtils.getImageUrl(avatar),
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover),
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
                child: FeatureImage(
                    url: ImageUtils.getImageUrl(subAvatar),
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover),
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

  //  handle BNB Special circumstances
  String replaceTitle(String title) {
    if (title.isEmpty) return '';

    return title.replaceFirst("BNB Smart Chain", "BSC").trim();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      replaceTitle(title),
      textAlign: TextAlign.center,
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
        _buildExplainText(
            context, S.of(context).receiveAddressExplain1(symbol)),
        _buildExplainText(
            context, S.of(context).receiveAddressExplain2(symbol)),
      ],
    );
  }

  Widget _buildExplainText(
    BuildContext context,
    String text,
    // String leading, String name, String suffix
  ) {
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14.sp, color: AppColors.textSecondary(context)));

    // return RichText(
    //     text: TextSpan(
    //         style: TextStyle(
    //             fontSize: 16.sp, color: AppColors.textSecondary(context)),
    //         children: [
    //       TextSpan(text: "Only send"),
    //       TextSpan(
    //           text: " $name ",
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //           )),
    //       TextSpan(text: "assets to this address"),
    //     ]));
  }
}

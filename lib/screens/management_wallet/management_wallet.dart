import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/wallet_list.dart';

class ManagementWalletScreen extends StatefulWidget {
  const ManagementWalletScreen({super.key});

  @override
  State<ManagementWalletScreen> createState() => _ManagementWalletScreenState();
}

class _ManagementWalletScreenState extends State<ManagementWalletScreen> {
  bool isAddWalletPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).wallet_managementWallet,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).wallet_totalAssetEstimation,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '\$1,000',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              fontSize: 32.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const WalletList(),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: GestureDetector(
              onTapDown: (_) => setState(() => isAddWalletPressed = true),
              onTapUp: (_) => setState(() => isAddWalletPressed = false),
              onTapCancel: () => setState(() => isAddWalletPressed = false),
              onTap: () {
                // TODO: 实现添加钱包功能
              },
              child: AnimatedScale(
                scale: isAddWalletPressed ? 0.95 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).branding_createWallet,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

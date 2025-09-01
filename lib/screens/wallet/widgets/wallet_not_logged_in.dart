import 'package:flutter/material.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WalletNotLoggedIn extends StatelessWidget {
  const WalletNotLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(S.of(context).authMessages_pleaseLoginFirst)),
          SizedBox(height: 10.w),
          CustomButton(
            width: 100.w,
            height: 40.w,
            fontSize: 14.sp,
            textColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              context.push(Routes.login);
            },
            child: Text(S.of(context).common_login),
          ),
        ],
      ),
    );
  }
}

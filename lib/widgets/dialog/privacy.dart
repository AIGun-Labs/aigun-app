import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/themes/colors.dart';
import 'package:flutter_aigun/utils/storage/local/permission_storage.dart';
import 'package:flutter_aigun/utils/url.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyDialog {
  Future<bool?> show(BuildContext context) async {
    return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => const PrivacyDialogContent());
  }
}

class PrivacyDialogContent extends StatelessWidget {
  const PrivacyDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return CupertinoAlertDialog(
        title: Padding(
          padding: EdgeInsetsGeometry.only(bottom: 12.h),
          child: Text(S.of(context).tips),
        ),
        content: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: S.of(context).ben,
            style: TextStyle(color: AppColors.textPrimary(context)),
          ),
          WidgetSpan(
              child: GestureDetector(
            onTap: () {
              launchUrl("https://privacy.aigun.ai");
            },
            child: Text("《${S.of(context).privacyPolicy}》",
                style: const TextStyle(color: AppColors.quaternary)),
          )),
          TextSpan(
              text: S.of(context).privacyPolicyDesc,
              style: TextStyle(color: AppColors.textPrimary(context))),
          TextSpan(
              text: S.of(context).privacyPolicyStartUse,
              style: TextStyle(color: AppColors.textPrimary(context))),
        ])),
        actions: [
          CupertinoDialogAction(
            child: Text(
              S.of(context).cancel,
              style: TextStyle(color: AppColors.textPrimary(context)),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          CupertinoDialogAction(
            child: Text(
              S.of(context).confirm,
              style: const TextStyle(color: AppColors.quaternary),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        backgroundColor: AppColors.background(context),
        title: const Text("Privacy Policy"),
        content: const Text("This is the privacy policy of the app."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "OK",
              style: TextStyle(color: AppColors.textPrimary(context)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.quaternary),
            ),
          ),
        ],
      );
    }
  }
}

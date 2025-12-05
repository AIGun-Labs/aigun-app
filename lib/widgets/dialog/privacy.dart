import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../config/url.dart';
import '../../core/router/constants.dart';
import '../../l10n/l10n.dart';
import '../../themes/colors.dart';

class PrivacyDialog {
  Future<bool?> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PrivacyDialogContent(),
    );
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
          text: TextSpan(
            children: [
              TextSpan(
                text: S.of(context).ben,
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
              TextSpan(
                text: ' ${S.of(context).userAgreement} ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.pushNamed(
                      RouteNames.webviewPreview,
                      queryParameters: {
                        "url": UrlConfig.userAgreement,
                        "title": S.of(context).userAgreement,
                      },
                    );
                  },
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.quaternary,
                  color: AppColors.quaternary,
                ),
              ),
              TextSpan(
                text: ' ${S.of(context).and} ',
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
              TextSpan(
                text: ' ${S.of(context).privacyPolicy} ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.pushNamed(
                      RouteNames.webviewPreview,
                      queryParameters: {
                        "url": UrlConfig.privacyPolicy,
                        "title": S.of(context).privacyPolicyTitle,
                      },
                    );
                  },
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.quaternary,
                  color: AppColors.quaternary,
                ),
              ),
              TextSpan(
                text: S.of(context).privacyPolicyDesc,
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
              TextSpan(
                text: S.of(context).privacyPolicyStartUse,
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
            ],
          ),
        ),
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
              S.of(context).startUsing,
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
        title: Padding(
          padding: EdgeInsetsGeometry.only(bottom: 12.h),
          child: Text(S.of(context).tips),
        ),
        content: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.of(context).ben,
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
              TextSpan(
                text: ' ${S.of(context).userAgreement} ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.pushNamed(
                      RouteNames.webviewPreview,
                      queryParameters: {
                        "url": UrlConfig.userAgreement,
                        "title": S.of(context).userAgreement,
                      },
                    );
                  },
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.quaternary,
                  color: AppColors.quaternary,
                ),
              ),
              TextSpan(
                text: ' ${S.of(context).and} ',
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
              TextSpan(
                text: S.of(context).privacyPolicy,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.pushNamed(
                      RouteNames.webviewPreview,
                      queryParameters: {
                        "url": UrlConfig.privacyPolicy,
                        "title": S.of(context).privacyPolicyTitle,
                      },
                    );
                  },
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.quaternary,
                  color: AppColors.quaternary,
                ),
              ),
              TextSpan(
                text: " ${S.of(context).privacyPolicyDesc}",
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
              TextSpan(
                text: S.of(context).privacyPolicyStartUse,
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              S.of(context).cancel,
              style: TextStyle(color: AppColors.textPrimary(context)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              S.of(context).startUsing,
              style: const TextStyle(color: AppColors.quaternary),
            ),
          ),
        ],
      );
    }
  }
}
